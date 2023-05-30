import 'package:flutter/material.dart';

class MXBottomNavBarIconTextConfig {
  MXBottomNavBarIconTextConfig({
    this.text,
    this.selectIcon,
    this.unSelectIcon,
    this.defaultIcon,
  });

  String? text;
  Widget? selectIcon;

  Widget? unSelectIcon;

  Widget? defaultIcon;
}
