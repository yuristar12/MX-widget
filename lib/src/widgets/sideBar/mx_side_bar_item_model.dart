import 'package:flutter/material.dart';

typedef SideBarPageItemBuilder = Widget Function(int index);

class MXSideBarItemModel {
  MXSideBarItemModel({
    required this.title,
    this.id,
    this.icon,
    this.builder,
  });

  final String title;

  final IconData? icon;

  final SideBarPageItemBuilder? builder;

  final String? id;
}
