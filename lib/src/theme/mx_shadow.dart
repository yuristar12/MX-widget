import 'package:flutter/material.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';

/// 阴影样式规范
extension MXShadow on MXThemeConfig {
  /// 一般用于层级最低的阴影
  List<BoxShadow>? get shadowBottomList => showdowsMap['shadowBottomList'];

  /// 一般用于层级中间的阴影
  List<BoxShadow>? get shadowMediumList => showdowsMap['shadowMediumList'];

  /// 一般用于层级最上的阴影
  List<BoxShadow>? get shadowTopList => showdowsMap['shadowTopList'];
}
