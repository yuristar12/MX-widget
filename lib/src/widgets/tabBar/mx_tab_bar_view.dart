import 'package:flutter/material.dart';

class MXTabBarView extends TabBarView {
  /// 子widget列表
  @override
  // ignore: overridden_fields
  final List<Widget> children;

  /// 控制器
  @override
  // ignore: overridden_fields
  final TabController? controller;

  /// 是否可以滑动切换
  final bool isSlideSwitch;

  @override
  const MXTabBarView({
    Key? key,
    required this.children,
    this.controller,
    this.isSlideSwitch = false,
  }) : super(
            key: key,
            children: children,
            controller: controller,
            physics: isSlideSwitch
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics());

  Widget build(BuildContext context) {
    return TabBarView(
      // ignore: sort_child_properties_last
      children: children,
      controller: controller,
    );
  }
}
