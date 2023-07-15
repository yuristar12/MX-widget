import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/sideBar/mx_side_bar_item.dart';
import 'package:mx_widget/src/widgets/sideBar/mx_side_bar_page_content.dart';
import 'package:mx_widget/src/widgets/sideBar/mx_side_bar_anchor_content.dart';

class MXSideBar extends StatefulWidget {
  MXSideBar({
    super.key,
    required this.height,
    required this.controller,
    this.customContentPadding,
    this.sideBarColor,
    this.contentColor,
    this.type = MXSideBarTypeEnum.page,
  }) : assert(() {
          bool flag = controller.sideBarItemList
              .every((element) => element.builder != null);

          if (!flag) {
            throw FlutterError('model层不能缺少builder方法');
          }

          if (type == MXSideBarTypeEnum.anchor) {
            flag = controller.sideBarItemList
                .every((element) => element.id != null);
            if (!flag) {
              throw FlutterError('anchor模式下model層必須傳入ID');
            }
          }

          return true;
        }());

  /// [type] sideBar 的类型 anchor 为锚点 page 为页面
  final MXSideBarTypeEnum type;

  /// [controller] 控制器
  final MXSideBarController controller;

  /// [height] 高度
  final double height;

  /// [customContentPadding] 自定义padding间距
  final double? customContentPadding;

  /// [sideBarColor] 自定义左侧选项的颜色
  final Color? sideBarColor;

  /// [contentColor] 自定义内容区域颜色
  final Color? contentColor;

  @override
  State<MXSideBar> createState() => MXSideBarState();
}

class MXSideBarState extends State<MXSideBar> {
  MXSideBarAnchorContentState? anchorContentState;

  @override
  void initState() {
    if (widget.type == MXSideBarTypeEnum.anchor) {}

    widget.controller.setState(this);

    super.initState();

    if (widget.controller.initValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (anchorContentState != null) {
          String id = widget
              .controller.sideBarItemList[widget.controller.activityValue].id!;
          anchorContentState!.onSideBarChangeLinkScrollOffset(id);
        }
      });
    }
  }

  List<Widget> _getSideBarItemList() {
    List<Widget> children = [];
    MXSideBarController controller = widget.controller;
    int activityValue = controller.activityValue;

    int length = controller.sideBarItemList.length;

    for (var i = 0; i < length; i++) {
      var element = controller.sideBarItemList[i];

      children.add(MXSideBarItem(
        index: i,
        model: element,
        listLength: length,
        isActivity: activityValue == i,
        itemBuilder: controller.sideBarItemBuilder,
        onTap: () {
          if (activityValue == i) return;

          controller.onTabChange(i);

          if (widget.type == MXSideBarTypeEnum.anchor) {
            String id = widget.controller
                .sideBarItemList[widget.controller.activityValue].id!;
            anchorContentState!.onSideBarChangeLinkScrollOffset(id);
          }
        },
      ));
    }

    return children;
  }

  void onActivityChange() {
    setState(() {});
  }

  Widget _buildSideBarLeft() {
    return Container(
        height: widget.height,
        color: widget.sideBarColor ?? MXTheme.of(context).infoColor1,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _getSideBarItemList(),
          ),
        ));
  }

  Widget _buildSideContentWarp() {
    double paddingSize =
        widget.customContentPadding ?? MXTheme.of(context).space16;

    return Expanded(
      child: Container(
        color: widget.contentColor ?? MXTheme.of(context).whiteColor,
        height: widget.height,
        padding: EdgeInsets.only(
            top: paddingSize, left: paddingSize, right: paddingSize),
        child: _buildSideContent(),
      ),
    );
  }

  Widget _buildSideContent() {
    if (widget.type == MXSideBarTypeEnum.anchor) {
      return LayoutBuilder(
          builder: ((context, constraints) => MXSideBarAnchorContent(
              sideBarItemList: widget.controller.sideBarItemList,
              controller: widget.controller,
              width: constraints.maxWidth,
              anchorInitCallback: (MXSideBarAnchorContentState state) {
                anchorContentState = state;
              })));
    } else {
      return MXSideBarPageContent(
          height: widget.height,
          activityIndex: widget.controller.activityValue,
          sideBarList: widget.controller.sideBarItemList);
    }
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildSideBarLeft(), _buildSideContentWarp()],
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: _buildBody(context),
    );
  }
}
