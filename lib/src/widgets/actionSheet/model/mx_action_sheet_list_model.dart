import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

class MXActionSheetListModel {
  MXActionSheetListModel(
      {this.icon,
      this.badge,
      required this.label,
      required this.value,
      this.type = MXActionSheetListType.common});

  final String label;

  final String value;

  final MXActionSheetListType type;

  final IconData? icon;

  final MXBadge? badge;
}
