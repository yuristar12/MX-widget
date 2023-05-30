import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/config/global_enum.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_base.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_mixins.dart';

// ignore: must_be_immutable
class MXTag extends StatelessWidget with MXTagMixins implements MXTagBase {
  MXTag({
    super.key,
    required this.text,
    this.backgroundColor,
    this.icon,
    this.isAdd,
    this.iconWidget,
    this.padding,
    this.textWidget,
    this.sizeEnum = MXTagSizeEnum.medium,
    this.modeEnum = MXTagModeEnum.deep,
    this.shapeEnum = MXTagshapeEnum.square,
    this.themeEnum = MXTagThemeEnum.primary,
  });

  String text;
  Color? backgroundColor;

  IconData? icon;

  Widget? iconWidget;

  MXTagModeEnum modeEnum;

  EdgeInsets? padding;

  MXTagshapeEnum shapeEnum;

  MXTagSizeEnum sizeEnum;

  Widget? textWidget;

  MXTagThemeEnum themeEnum;

  bool? isAdd;

  Widget _buildTag(BuildContext context) {
    setStyle(context, modeEnum, themeEnum, shapeEnum);

    return buildTag(
      context,
      sizeEnum,
      text,
      textWidget: textWidget,
      icon: icon,
      iconWidget: iconWidget,
      backgroundColor: backgroundColor,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTag(context);
  }
}
