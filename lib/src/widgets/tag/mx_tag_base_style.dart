import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/export.dart';

class MXTagBaseStyle {
  MXTagBaseStyle(
      {this.context,
      this.backgroundColor,
      this.border,
      this.borderColor,
      this.borderRadius,
      this.textColor});

  BuildContext? context;

  Color? textColor;
  Color? backgroundColor;
  Color? borderColor;
  BorderRadiusGeometry? borderRadius;

  double? border;

  void setStyle(
      BuildContext context, MXTagThemeEnum themeEnum, MXTagshapeEnum shapeEnum,
      {bool disabled = false}) {
    this.context = context;
    _setBorderRadius(shapeEnum);
  }

  void _setBorderRadius(MXTagshapeEnum shapeEnum) {
    switch (shapeEnum) {
      case MXTagshapeEnum.round:
        borderRadius = BorderRadius.circular(MXTheme.of(context).radiusRound);
        break;
      case MXTagshapeEnum.square:
        borderRadius = BorderRadius.circular(MXTheme.of(context).radiusSmall);
        break;
    }
  }

  void setDisableStyle() {
    textColor = MXTheme.of(context).infoColor6;
    backgroundColor = MXTheme.of(context).infoDisabledColor;
    borderColor = textColor;
  }
}
