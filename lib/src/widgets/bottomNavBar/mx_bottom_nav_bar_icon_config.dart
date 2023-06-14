import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/bottomNavBar/mx_bottom_nav_bar_icon_text_config.dart';

class MXBottomNavBarIconConfig extends MXBottomNavBarIconTextConfig {
  MXBottomNavBarIconConfig(
      {this.selectIcon, this.defaultIcon, this.unSelectIcon})
      : super(
            defaultIcon: defaultIcon,
            unSelectIcon: unSelectIcon,
            selectIcon: selectIcon);

  @override
  // ignore: overridden_fields
  Widget? selectIcon;

  @override
  // ignore: overridden_fields
  Widget? unSelectIcon;
  @override
  // ignore: overridden_fields
  Widget? defaultIcon;
}
