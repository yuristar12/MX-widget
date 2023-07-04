import 'package:flutter/material.dart';

class MXGridItemModel {
  String? assetUrl;

  String? netUrl;

  Widget? customWidget;

  String title;

  String? des;

  MXGridItemModel({
    this.assetUrl,
    this.netUrl,
    this.customWidget,
    required this.title,
    this.des,
  });
}
