import 'package:flutter/material.dart';

class MXStepsItemModel {
  MXStepsItemModel({
    this.icon,
    required this.title,
    this.description,
    this.pluginWidget,
    this.activityTitle,
    this.pastTitle,
  });

  final IconData? icon;

  final String title;

  final String? description;

  final Widget? pluginWidget;

  final String? activityTitle;

  final String? pastTitle;
}
