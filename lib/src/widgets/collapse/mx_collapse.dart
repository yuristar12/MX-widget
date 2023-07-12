import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

import 'mx_collapse_paner_item.dart';

/// ------------------------------------------------------------------折叠面板组件
/// [padding] 容器的内边距 默认为16
/// [customColor] 面板的颜色
/// [controller] 面板控制器，可获取展开面板的值与通过控制器打开/关闭指定的面板
/// [collapseIcon] 右侧展开状态的icon图标
/// [noCollapseIcon] 右侧非展开状态的icon图标

class MXCollapse extends StatefulWidget {
  const MXCollapse(
      {super.key,
      this.padding = 16,
      this.customColor,
      required this.controller,
      this.collapseIcon = Icons.keyboard_arrow_up_outlined,
      this.noCollapseIcon = Icons.keyboard_arrow_down_outlined});

  /// [padding] 容器的内边距 默认为16
  final double padding;

  /// [controller] 面板控制器，可获取展开面板的值与通过控制器打开/关闭指定的面板
  final MXCollapsePannerController controller;

  /// [collapseIcon] 右侧展开状态的icon图标
  final IconData collapseIcon;

  /// [noCollapseIcon] 右侧非展开状态的icon图标
  final IconData noCollapseIcon;

  /// [customColor] 面板的颜色
  final Color? customColor;

  @override
  State<MXCollapse> createState() => MXCollapseState();
}

class MXCollapseState extends State<MXCollapse> {
  List<String> value = [];

  @override
  void didUpdateWidget(covariant MXCollapse oldWidget) {
    if (oldWidget.controller != widget.controller) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    List<String>? initValue = widget.controller.initValue;

    if (initValue != null) {
      for (var element in initValue) {
        value.add(element);
      }
      widget.controller.value = value;
    }

    widget.controller.setState(this);
  }

  void onValueChange() {
    value = widget.controller.value;
    setState(() {
      widget.controller.onChange?.call(value);
    });
  }

  Widget _buildBody() {
    List<Widget> children = [];

    int length = widget.controller.collapseItemList.length;
    for (var i = 0; i < length; i++) {
      MXCollapsePannerModel element = widget.controller.collapseItemList[i];

      children.add(MXCollapsePanerItem(
          model: element,
          customColor: widget.customColor,
          padding: widget.padding,
          isCollapse: _collapseIsCollapse(element.id),
          useBottomBorder: i < length - 1,
          collapseIcon: widget.collapseIcon,
          collapseItemClick: () {
            widget.controller.onHandleCollpaseItemById(element.id);
          },
          noCollapseIcon: widget.noCollapseIcon));
    }

    return Column(
      children: children,
    );
  }

  bool _collapseIsCollapse(String id) {
    return value.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: _buildBody(),
    );
  }
}
