import 'package:flutter/material.dart';

import '../../../mx_widget.dart';

class MXCellModel {
  MXCellModel(
      {required this.title,
      this.description,
      this.useBorder = true,
      this.note,
      this.align = MXCellAlign.middle,
      this.useRightArrow = true,
      this.rightIconWidget,
      this.leftIconWidget,
      this.onClick,
      this.noteWidget,
      this.rightWidget,
      this.useArrow = true,
      this.type = MXCellType.singleLine});

  final String title;

  final String? description;

  bool useBorder;

  final String? note;

  final bool useRightArrow;

  final Widget? rightIconWidget;

  final Widget? rightWidget;

  final Widget? leftIconWidget;

  final MXCellOnClick? onClick;

  final MXCellAlign align;

  final Widget? noteWidget;

  final MXCellType type;

  final bool useArrow;
}
