import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';
import 'package:mx_widget/src/widgets/popover/popover_position.dart';
import 'package:mx_widget/src/widgets/popover/mx_popover_triangle.dart';
import 'package:mx_widget/src/widgets/popover/popover_over_layer_controller.dart';

const double space = 10;

double padding = MXTheme.getThemeConfig().space12;

enum RenderDirectionEnum { column, horizontal }

const List<MXPopoverPositionEnum> topDirectionList = [
  MXPopoverPositionEnum.topLeft,
  MXPopoverPositionEnum.topCenter,
  MXPopoverPositionEnum.topRight,
];

const List<MXPopoverPositionEnum> bottomDirectionList = [
  MXPopoverPositionEnum.bottomLeft,
  MXPopoverPositionEnum.bottomCenter,
  MXPopoverPositionEnum.bottomRight
];

const List<MXPopoverPositionEnum> leftDirectionList = [
  MXPopoverPositionEnum.leftTop,
  MXPopoverPositionEnum.leftCenter,
  MXPopoverPositionEnum.leftBottom,
];

const List<MXPopoverPositionEnum> rightDirectionList = [
  MXPopoverPositionEnum.rightTop,
  MXPopoverPositionEnum.rightCenter,
  MXPopoverPositionEnum.rightBottom
];

const Map<RenderDirectionEnum, List<MXPopoverPositionEnum>>
    renderDirectionJudgeMap = {
  RenderDirectionEnum.column: [
    MXPopoverPositionEnum.topLeft,
    MXPopoverPositionEnum.topCenter,
    MXPopoverPositionEnum.topRight,
    MXPopoverPositionEnum.bottomLeft,
    MXPopoverPositionEnum.bottomCenter,
    MXPopoverPositionEnum.bottomRight
  ],
  RenderDirectionEnum.horizontal: [
    MXPopoverPositionEnum.leftTop,
    MXPopoverPositionEnum.leftCenter,
    MXPopoverPositionEnum.leftBottom,
    MXPopoverPositionEnum.rightTop,
    MXPopoverPositionEnum.rightCenter,
    MXPopoverPositionEnum.rightBottom
  ]
};

class MXPopoverWrap extends StatefulWidget {
  const MXPopoverWrap(
      {super.key,
      required this.renderChild,
      required this.position,
      required this.controller,
      required this.showTriangle});

  final Widget renderChild;

  final PopoverOverLayerController controller;

  final PopoverPosition position;

  final bool showTriangle;

  @override
  State<MXPopoverWrap> createState() => _MXPopoverWrapState();
}

class _MXPopoverWrapState extends State<MXPopoverWrap>
    with TickerProviderStateMixin {
  bool isComplated = false;
  double top = 0;
  double left = 0;
  final GlobalKey renderKey = GlobalKey();

  MXPopoverPositionEnum? positionEnum;

  late RenderDirectionEnum directionEnum;

  late AnimationController animationController;

// 记录需要渲染的widget宽度
  double renderWidth = 0;
// 记录需要渲染的widget高度
  double renderHeight = 0;

// 容器最大的宽度,不要考虑高度
  double renderMaxWidth = 0;

  @override
  void initState() {
    setDirectionEnum();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        animationController = AnimationController(
            vsync: this, duration: const Duration(milliseconds: 300))
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.dismissed) {
                // 当动画反转后需要执行销毁popover容器组件
                widget.controller.toHiddenContent();
              }
            },
          )
          ..forward();
        _judgeDirection();
        _onRenderComplated();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // 组件销毁时需要将动画控制器也销毁
    animationController.dispose();
    super.dispose();
  }

  void setDirectionEnum() {
    for (var element in renderDirectionJudgeMap.keys) {
      List<MXPopoverPositionEnum>? list = renderDirectionJudgeMap[element];
      if (list != null) {
        int index = list.indexOf(widget.position.positionEnum);
        if (index > -1) {
          directionEnum = element;
          break;
        }
      }
    }
  }

  void _judgeDirection() {
    if (directionEnum == RenderDirectionEnum.horizontal) {
      _judgeDirectionByHorizontal();
    } else if (directionEnum == RenderDirectionEnum.column) {
      _judgeDirectionByColumn();
    }
  }

  void _judgeDirectionByColumn() {
    RenderBox renderBox = _getRenderBox();

    MXPopoverPositionEnum widgetPositionEnum = widget.position.positionEnum;

    double renderHeight = renderBox.size.height;
    double limitHeight = widget.position.dy - space;

    // 获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width - padding * 2;

    // 获取屏幕剩余高度
    double residueHeight =
        MediaQuery.of(context).size.height - widget.position.dy;

    // 判断是否上面能排下
    if (topDirectionList.contains(widgetPositionEnum)) {
      if (renderWidth > screenWidth) {
        renderMaxWidth = screenWidth;
        positionEnum = MXPopoverPositionEnum.topCenter;
        return;
      }
      if (limitHeight >= renderHeight) {
        positionEnum = widget.position.positionEnum;
        return;
      } else if (residueHeight >= renderHeight) {
        positionEnum = MXPopoverPositionEnum.bottomCenter;
      }
    } else {
      if (renderWidth > screenWidth) {
        renderMaxWidth = screenWidth;
        positionEnum = MXPopoverPositionEnum.bottomCenter;
        return;
      }
      if (residueHeight >= renderHeight) {
        positionEnum = widget.position.positionEnum;
        return;
      } else if (limitHeight >= renderHeight) {
        positionEnum = MXPopoverPositionEnum.topCenter;
      }
    }
  }

  void _judgeDirectionByHorizontal() {
    RenderBox renderBox = _getRenderBox();

    MXPopoverPositionEnum widgetPositionEnum = widget.position.positionEnum;

    double renderWidth = renderBox.size.width;

    // 获取屏幕剩余宽度
    double residueWidthByRight = MediaQuery.of(context).size.width -
        (widget.position.dx + widget.position.width + space);

    // 获取屏幕剩余宽度
    double residueWidthByLeft = (widget.position.dx - space - padding);

    // 判断是否能在右侧排下
    if (rightDirectionList.contains(widgetPositionEnum)) {
      if (residueWidthByRight >= renderWidth) {
        positionEnum = widgetPositionEnum;
        return;
      } else if (residueWidthByLeft >= renderWidth) {
        positionEnum = MXPopoverPositionEnum.leftCenter;
      } else {
        renderMaxWidth = residueWidthByRight - padding;
        positionEnum = MXPopoverPositionEnum.rightCenter;
      }
    } else {
      // 判断是否能在左侧排下
      if (residueWidthByLeft >= renderWidth) {
        positionEnum = widgetPositionEnum;
        return;
      } else if (residueWidthByRight >= renderWidth) {
        positionEnum = MXPopoverPositionEnum.rightCenter;
      } else {
        renderMaxWidth = residueWidthByLeft - padding;
        positionEnum = MXPopoverPositionEnum.leftCenter;
      }
    }
  }

  void _onRenderComplated() {
    RenderBox renderBox = _getRenderBox();
    if (positionEnum != null) {
      if (directionEnum == RenderDirectionEnum.horizontal) {
        if (positionEnum == MXPopoverPositionEnum.rightTop ||
            positionEnum == MXPopoverPositionEnum.leftTop) {
          top = widget.position.dy - renderBox.size.height;
        } else if (positionEnum == MXPopoverPositionEnum.rightCenter ||
            positionEnum == MXPopoverPositionEnum.leftCenter) {
          top = (widget.position.dy + (widget.position.height / 2)) -
              (renderBox.size.height / 2);
        } else if (positionEnum == MXPopoverPositionEnum.rightBottom ||
            positionEnum == MXPopoverPositionEnum.leftBottom) {
          top = widget.position.dy +
              widget.position.height -
              renderBox.size.height;
        }

        if (rightDirectionList.contains(positionEnum)) {
          left = widget.position.dx + widget.position.width + space;
        } else if (leftDirectionList.contains(positionEnum)) {
          left = widget.position.dx -
              (renderMaxWidth > 0 ? renderMaxWidth : renderBox.size.width) -
              space;
        }
      } else if (directionEnum == RenderDirectionEnum.column) {
        if (positionEnum == MXPopoverPositionEnum.topLeft ||
            positionEnum == MXPopoverPositionEnum.bottomLeft) {
          left = widget.position.dx;
        } else if (positionEnum == MXPopoverPositionEnum.topCenter ||
            positionEnum == MXPopoverPositionEnum.bottomCenter) {
          left = (widget.position.dx + widget.position.width / 2) -
              renderBox.size.width / 2;
        } else if (positionEnum == MXPopoverPositionEnum.topRight ||
            positionEnum == MXPopoverPositionEnum.bottomRight) {
          left =
              widget.position.dx + widget.position.width - renderBox.size.width;
        }

        if (topDirectionList.contains(positionEnum)) {
          top = widget.position.dy - space - renderBox.size.height;
        } else if (bottomDirectionList.contains(positionEnum)) {
          top = widget.position.dy + widget.position.height + space;
        }
      }
    } else {
      // 如果为空需要，全部居中处理
      top = widget.position.dy - renderBox.size.height;
      left = (widget.position.dx + widget.position.width / 2) -
          renderBox.size.width / 2;
    }

    setState(() {
      isComplated = true;
    });
  }

  RenderBox _getRenderBox() {
    RenderBox renderBox =
        renderKey.currentContext!.findRenderObject() as RenderBox;

    renderWidth = renderBox.size.width;

    renderHeight = renderBox.size.height;

    return renderBox;
  }

  Widget _buildPopoverTriangle() {
    Widget child;

    if (leftDirectionList.contains(positionEnum)) {
      child = const MXPopoverTriangle(
        direction: TriangleDirection.right,
        size: space,
      );

      if (positionEnum == MXPopoverPositionEnum.leftBottom) {
        return Positioned(bottom: space * 3, left: renderWidth, child: child);
      } else if (positionEnum == MXPopoverPositionEnum.leftCenter) {
        return Positioned(
            top: renderHeight / 2 - space,
            left: renderMaxWidth > 0 ? renderMaxWidth : renderWidth,
            child: child);
      } else if (positionEnum == MXPopoverPositionEnum.leftTop) {
        return Positioned(top: space, left: renderWidth, child: child);
      }

      return Positioned(child: child);
    } else if (rightDirectionList.contains(positionEnum)) {
      child = const MXPopoverTriangle(
        direction: TriangleDirection.left,
        size: space,
      );

      if (positionEnum == MXPopoverPositionEnum.rightCenter) {
        return Positioned(
            top: renderHeight / 2 - space, left: -space, child: child);
      } else if (positionEnum == MXPopoverPositionEnum.rightTop) {
        return Positioned(top: space, left: -space, child: child);
      } else if (positionEnum == MXPopoverPositionEnum.rightBottom) {
        return Positioned(bottom: space * 3, left: -space, child: child);
      }
    } else if (topDirectionList.contains(positionEnum)) {
      child = const MXPopoverTriangle(
        direction: TriangleDirection.bottom,
        size: space,
      );

      if (positionEnum == MXPopoverPositionEnum.topLeft) {
        return Positioned(left: space, top: renderHeight, child: child);
      } else if (positionEnum == MXPopoverPositionEnum.topCenter) {
        return Positioned(
            left: renderWidth / 2 - space, top: renderHeight, child: child);
      } else if (positionEnum == MXPopoverPositionEnum.topRight) {
        return Positioned(right: space * 3, top: renderHeight, child: child);
      }
    } else if (bottomDirectionList.contains(positionEnum)) {
      child = const MXPopoverTriangle(
        direction: TriangleDirection.top,
        size: space,
      );
      if (positionEnum == MXPopoverPositionEnum.bottomLeft) {
        return Positioned(top: -space, left: space, child: child);
      } else if (positionEnum == MXPopoverPositionEnum.bottomCenter) {
        return Positioned(
            top: -space, left: renderWidth / 2 - space, child: child);
      } else if (positionEnum == MXPopoverPositionEnum.bottomRight) {
        return Positioned(top: -space, right: space * 3, child: child);
      }
    }

    return Container();
  }

  Widget _buildWrap(Widget child) {
    List<Widget> children = [];

    if (!isComplated) {
      double maxWidth;
      if (directionEnum == RenderDirectionEnum.column) {
        maxWidth = MediaQuery.of(context).size.width - padding * 2;
        child = ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        );
      } else {
        if (rightDirectionList.contains(widget.position.positionEnum)) {
          maxWidth = MediaQuery.of(context).size.width -
              widget.position.dx -
              widget.position.width -
              padding;
        } else {
          maxWidth = widget.position.dx - padding;
        }

        child = ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        );
      }
    }

    children.add(Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: MXTheme.of(context).shadowTopList,
            borderRadius: BorderRadius.all(
                Radius.circular(MXTheme.of(context).radiusDefault))),
        child: renderMaxWidth > 0
            ? SizedBox(
                width: renderMaxWidth - padding * 2,
                child: child,
              )
            : child));

    if (isComplated && widget.showTriangle) {
      children.add(_buildPopoverTriangle());
    }

    return Positioned(
        top: top,
        left: left,
        key: renderKey,
        child: Stack(clipBehavior: Clip.none, children: children));
  }

  Widget _buildBody() {
    Widget child;

    if (!isComplated) {
      child = Opacity(
          opacity: 0,
          child: Stack(
            children: [_buildWrap(widget.renderChild)],
          ));
    } else {
      child = AnimatedBuilder(
          animation: CurvedAnimation(
              parent: animationController, curve: CurveUtil.curve_1()),
          builder: (BuildContext context, child) {
            return Opacity(
              opacity: animationController.value,
              child: Stack(
                children: [_buildWrap(widget.renderChild)],
              ),
            );
          });
    }

    return TapRegion(
        onTapOutside: (event) {
          final Offset localPosition = event.localPosition;

          // 判断点击区域是否处于触发popover/widget内
          if (localPosition.dx >= widget.position.dx &&
              localPosition.dx <= widget.position.dx + widget.position.width &&
              localPosition.dy >= widget.position.dy &&
              localPosition.dy <= widget.position.dy + widget.position.height) {
            return;
          }

          animationController.reverse();
        },
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
