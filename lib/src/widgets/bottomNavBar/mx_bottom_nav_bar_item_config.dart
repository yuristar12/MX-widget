import 'package:flutter/gestures.dart';
import 'package:mx_widget/src/widgets/bottomNavBar/mx_bottom_nav_bar_icon_config.dart';
import 'package:mx_widget/src/widgets/bottomNavBar/mx_bottom_nav_bar_icon_text_config.dart';
import 'package:mx_widget/src/widgets/bottomNavBar/mx_bottom_nav_bar_item_badge_config.dart';
import 'package:mx_widget/src/widgets/bottomNavBar/mx_bottom_nav_bar_text_config.dart';

///[mxBottomNavBarIconConfig] navBar的类型为纯icon，则每个navBarItem的配置

///[mxBottomNavBarTextConfig] navBar的类型为纯文字，则每个navBarItem的配置

///[mxBottomNavBarIconTextConfig] navBar的类型为icon+文字，则每个navBarItem的配置

///[mxBottomNavBarItemBadgeConfig] 底部每个navBarItem的飘新配置
class MXBottomNavBarItemConfig {
  MXBottomNavBarItemConfig(
      {required this.onTap,
      this.mxBottomNavBarIconConfig,
      this.mxBottomNavBarIconTextConfig,
      this.mxBottomNavBarItemBadgeConfig,
      this.mxBottomNavBarTextConfig});
  MXBottomNavBarIconConfig? mxBottomNavBarIconConfig;
  MXBottomNavBarTextConfig? mxBottomNavBarTextConfig;
  MXBottomNavBarIconTextConfig? mxBottomNavBarIconTextConfig;
  MXBottomNavBarItemBadgeConfig? mxBottomNavBarItemBadgeConfig;

  final GestureTapCallback onTap;
}
