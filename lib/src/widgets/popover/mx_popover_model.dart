import 'package:flutter/material.dart';

class MXPopoverModel {
  MXPopoverModel({
    this.textStyle,
    this.showTriangle = true,
  });

  bool showTriangle;

  TextStyle? textStyle;
}
