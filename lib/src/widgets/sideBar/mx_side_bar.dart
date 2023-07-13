import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/sideBar/mx_side_bar_item.dart';
import 'package:mx_widget/src/widgets/sideBar/mx_side_bar_page_content.dart';

class MXSideBar extends StatefulWidget {
  MXSideBar({
    super.key,
    required this.height,
    required this.controller,
    this.customContentPadding,
    this.type = MXSideBarTypeEnum.page,
  }) : assert(() {
          bool flag = controller.sideBarItemList
              .every((element) => element.builder != null);

          if (!flag) {
            throw FlutterError('model层不能缺少builder方法');
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

  @override
  State<MXSideBar> createState() => MXSideBarState();
}

class MXSideBarState extends State<MXSideBar> {
  @override
  void initState() {
    widget.controller.setState(this);

    super.initState();
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
        onTap: () {
          if (activityValue == i) return;

          controller.onTabChange(i);
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
        color: MXTheme.of(context).infoColor1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getSideBarItemList(),
        ));
  }

  Widget _buildSideContentWarp() {
    return Expanded(
      child: Container(
        color: MXTheme.of(context).whiteColor,
        height: widget.height,
        padding: EdgeInsets.all(
            widget.customContentPadding ?? MXTheme.of(context).space16),
        child: _buildSideContent(),
      ),
    );
  }

  Widget _buildSideContent() {
    if (widget.type == MXSideBarTypeEnum.anchor) {
      return Container();
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
