import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';
import 'package:mx_widget/src/widgets/swiperCell/mx_swiper_cell_handle.dart';

final double mxSwiperCellPadding = MXTheme.getThemeConfig().space16;

final double mxSwiperCellFontSize =
    MXTheme.getThemeConfig().fontBodySmall!.size;

class MXSwiperCell extends StatefulWidget {
  const MXSwiperCell(
      {super.key,
      this.customContent,
      this.title,
      this.note,
      this.description,
      this.leftListController,
      this.rightListController});

  /// 自定义渲染组件
  final Widget? customContent;

  /// 标题内容左侧
  final String? title;

  /// 提醒内容右侧
  final String? note;

  /// 描述内容下边内容
  final String? description;

  /// 左侧滑动的列表
  final List<SwiperCellHandleController>? leftListController;

  /// 右侧滑动的列表
  final List<SwiperCellHandleController>? rightListController;

  @override
  State<MXSwiperCell> createState() => _MXSwiperCellState();
}

class _MXSwiperCellState extends State<MXSwiperCell> {
  double transformX = 0;

  double startX = 0;

  double durationX = 0;

  double width = 0;

  double leftWidth = 0;

  double rightWidth = 0;
// 是否开启动画效果 滑动时会关闭动画
  bool isAnimations = true;

  // 未操作时不需要渲染按钮，这个值用来缓存却不不进行多次渲染按钮
  bool isCacheLeft = false;
  bool isCacheRight = false;

  Map<int, double> leftItemWidth = {};

  Map<int, double> rightItemWidth = {};

  @override
  void initState() {
    if (widget.leftListController != null) {
      leftWidth =
          _getCellHandleWidth(widget.leftListController!, leftItemWidth);
    }

    if (widget.rightListController != null) {
      rightWidth =
          _getCellHandleWidth(widget.rightListController!, rightItemWidth);
    }

    super.initState();
  }

  double _getCellHandleWidth(
      List<SwiperCellHandleController> list, Map<int, double> mapList) {
    double width = 0;
    for (int i = 0; i < list.length; i++) {
      // 这里padding的距离
      width += mxSwiperCellPadding * 2;
      var element = list[i];
      // 添加icon的大小
      if (element.icon != null) {
        width += mxSwiperCellFontSize;
      }
      if (element.text != null) {
        if (element.icon != null) {
          width += 8;
        }
        // 添加文字内容的大小
        int length = element.text!.length;
        width += length * (mxSwiperCellFontSize);
      }

      mapList[i] = width;
    }

    return width;
  }

  List<Widget> _buildCellHandle(List<SwiperCellHandleController> controllerList,
      Map<int, double> widthMap) {
    List<Widget> children = [];

    double left = 0;

    for (var i = 0; i < controllerList.length; i++) {
      SwiperCellHandleController swiperCellHandleController = controllerList[i];
      if (i > 0) {
        left += widthMap[i - 1]!;
      }
      children.add(Positioned.fill(
          left: left,
          child: Align(
            alignment: Alignment.topLeft,
            child: FractionallySizedBox(
              heightFactor: 1,
              child: MXSwiperCellHandle(
                  width: widthMap[i]!,
                  swiperCellHandleController: swiperCellHandleController),
            ),
          )));
    }

    return children;
  }

  Widget _buildCellLeft() {
    List<Widget> children =
        _buildCellHandle(widget.leftListController!, leftItemWidth);

    return Positioned.fill(
        left: 0,
        child: Align(
          alignment: Alignment.topLeft,
          child: FractionallySizedBox(
              widthFactor: leftWidth / width,
              child: Stack(
                children: children,
              )),
        ));
  }

  Widget _buildCellRight() {
    List<Widget> children =
        _buildCellHandle(widget.rightListController!, rightItemWidth);
    return Positioned.fill(
        left: width - rightWidth,
        child: Align(
          alignment: Alignment.topLeft,
          child: FractionallySizedBox(
              child: Stack(
            children: children,
          )),
        ));
  }

  Widget _buildSwiperCellMiddle() {
    return AnimatedContainer(
      curve: CurveUtil.curve_1(),
      duration: Duration(milliseconds: isAnimations ? 600 : 0),
      transform: Matrix4.translationValues(transformX, 0, 0),
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: Container(
          width: width,
          color: MXTheme.of(context).whiteColor,
          padding: EdgeInsets.all(mxSwiperCellPadding),
          child: _buildSwiperCellMiddleContent(),
        ),
      ),
    );
  }

  Widget _buildSwiperCellMiddleContent() {
    List<Widget> children = [];

    children.add(_buildMiddleLeftContent(context));

    if (widget.note != null) {
      children.add(_buildNoteContent(context));
    }

    return widget.customContent ??
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        );
  }

  Widget _buildNoteContent(BuildContext context) {
    return MXText(
      data: widget.note,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      font: MXTheme.of(context).fontBodyMedium,
      textColor: MXTheme.of(context).fontUsePrimaryColor,
    );
  }

  Widget _buildMiddleLeftContent(BuildContext context) {
    List<Widget> children = [];

    children.add(
      MXText(
        data: widget.title,
        font: MXTheme.of(context).fontInfoLarge,
        textColor: MXTheme.of(context).fontUsePrimaryColor,
      ),
    );

    if (widget.description != null) {
      children.add(
        MXText(
          data: widget.description,
          font: MXTheme.of(context).fontBodySmall,
          textColor: MXTheme.of(context).fontUseSecondColors,
        ),
      );
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children);
  }

  Widget _buildContent() {
    List<Widget> children = [];

    if (isCacheLeft) {
      if (widget.leftListController != null) {
        children.add(_buildCellLeft());
      }
    }

    if (isCacheRight) {
      if (widget.rightListController != null) {
        children.add(_buildCellRight());
      }
    }

    children.add(_buildSwiperCellMiddle());
    return Container(
      width: width,
      color: MXTheme.of(context).whiteColor,
      child: Stack(
        children: children,
      ),
    );
  }

  Widget _buildSwiperCellBody() {
    return _buildContent();
  }

  void _onDragStart(DragStartDetails details) {
    isAnimations = false;
    startX = details.globalPosition.dx;
    durationX = startX;
  }

  void _onDragEnd(DragEndDetails details) {
    /// 需要考虑四种情况
    /// 分别是已经触发左侧显示/关闭与右侧显示/关闭

    isAnimations = true;
    double subs = (startX - durationX);
    if (subs < 0 && transformX >= 0) {
      if (transformX > leftWidth * 0.3) {
        transformX = leftWidth;
      } else {
        transformX = 0;
      }
      setState(() {});
    } else if (subs > 0 && transformX >= 0) {
      if (subs > leftWidth * 0.3) {
        transformX = 0;
      } else {
        transformX = leftWidth;
      }
      setState(() {});
    } else if (subs > 0 && transformX <= 0) {
      if (transformX.abs() > rightWidth * 0.3) {
        transformX = -rightWidth;
      } else {
        transformX = 0;
      }
      setState(() {});
    } else if (subs <= 0 && transformX <= 0) {
      if (subs.abs() > rightWidth * 0.3) {
        transformX = 0;
      } else {
        transformX = -rightWidth;
      }
      setState(() {});
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    //  判断左滑还是右滑
    double dx = details.globalPosition.dx;
    bool isRight = false;
    if (dx > durationX) {
      isRight = true;
      if (!isCacheLeft) {
        isCacheLeft = true;
        setState(() {});
      }
    } else {
      isRight = false;
      if (!isCacheRight) {
        isCacheRight = true;
        setState(() {});
      }
    }

    if (isRight) {
      // 判断是否存在左侧的操作按钮
      if (widget.leftListController != null) {
        _onDrawerUpdateByLeft(details);
      }
    } else {
      // 判断是否存在右侧操作按钮
      if (widget.rightListController != null) {
        _onDrawerUpdateByRight(details);
      }
    }
  }

  void _onDrawerUpdateByLeft(DragUpdateDetails details) {
    double dx = details.globalPosition.dx;
    double sub = dx - durationX;

    durationX = dx;
    // 判断左边按钮的宽度

    double value = transformX + sub;
    if (value >= leftWidth) {
      transformX = leftWidth;
    } else {
      transformX = value;
    }

    setState(() {});
  }

  void _onDrawerUpdateByRight(DragUpdateDetails details) {
    double dx = details.globalPosition.dx;
    double sub = (dx - durationX).abs();

    durationX = dx;
    // 判断左边按钮的宽度

    double value = transformX - sub;
    if (value.abs() > rightWidth) {
      transformX = -(leftWidth);
    } else {
      transformX = value;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext content, BoxConstraints constraints) {
      width = double.parse(constraints.biggest.width.toStringAsFixed(1));

      return TapRegion(
        onTapOutside: (event) {
          if (transformX != 0) {
            isAnimations = true;
            transformX = 0;
            setState(() {});
          }
        },
        child: _buildSwiperCellBody(),
      );
    });
  }
}
