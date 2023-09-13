import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXDrawerOptionsModel {
  MXDrawerOptionsModel(
      {required this.title,
      this.icon,
      this.disabled = false,
      this.placement = MXDrawerOptionItemPlacementEnum.center});

  final String title;

  final IconData? icon;

  final bool disabled;

  final MXDrawerOptionItemPlacementEnum placement;
}
