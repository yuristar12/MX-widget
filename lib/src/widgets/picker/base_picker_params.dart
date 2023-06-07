import 'package:flutter/material.dart';

import '../../export.dart';

class BasePickerParams {
  BasePickerParams({
    this.onConfirm,
    this.onCancel,
    this.backgroundColor,
    required this.text,
    this.useTitle = true,
    this.pickerHeight = 200,
    this.pickerSelectContainer,
    this.pickerColumnNum = 5,
    this.useSaftArea = false,
  });

  final dynamic onConfirm;

  final dynamic onCancel;

  final Color? backgroundColor;

  final String text;

  final bool useTitle;

  final double pickerHeight;

  final Widget? pickerSelectContainer;

  final int pickerColumnNum;

  final bool useSaftArea;
}
