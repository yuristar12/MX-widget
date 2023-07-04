import 'package:flutter/widgets.dart';

import '../../../mx_widget.dart';

/// -------------------------------------------------------单个折叠面板组件的数据模型
/// [id] 折叠面板的id
/// [collapseNotice] 右侧折叠面板展开的提醒文字
/// [noCollapseNotice] 右侧折叠面板收起的提醒文字
/// [title] 折叠面板的文字
/// [child] 折叠面板展开的内容
/// [mxCollapsePlacementEnum] 折叠面板展开的内容排列方式top/bottom

class MXCollapsePannerModel {
  MXCollapsePannerModel({
    required this.id,
    this.collapseNotice,
    this.noCollapseNotice,
    required this.title,
    required this.child,
    this.mxCollapsePlacementEnum = MXCollapsePlacementEnum.bottom,
  });

  /// [title] 折叠面板的文字
  String title;

  /// [id] 折叠面板的id
  String id;

  /// [child] 折叠面板展开的内容
  Widget child;

  /// [collapseNotice] 右侧折叠面板展开的提醒文字
  String? collapseNotice;

  /// [noCollapseNotice] 右侧折叠面板收起的提醒文字
  String? noCollapseNotice;

  /// [mxCollapsePlacementEnum] 折叠面板展开的内容排列方式top/bottom
  MXCollapsePlacementEnum mxCollapsePlacementEnum;
}
