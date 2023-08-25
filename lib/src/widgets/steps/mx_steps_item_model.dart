import 'package:flutter/material.dart';

typedef MXStepsItemBuilder = Widget Function(bool isActivity,
    {required int index});

class MXStepsItemModel {
  MXStepsItemModel({
    this.icon,
    required this.title,
    this.description,
    this.pluginWidget,
    this.activityTitle,
    this.pastTitle,
    this.builder,
  });

  final IconData? icon;

  final String title;

  final String? description;

  final Widget? pluginWidget;

  final String? activityTitle;

  final String? pastTitle;

  final MXStepsItemBuilder? builder;
}
