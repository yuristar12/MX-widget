// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_base_style.dart';

class MXTagOutlinePlainStyle extends MXTagBaseStyle {
  @override
  void setStyle(
      BuildContext context, MXTagThemeEnum themeEnum, MXTagshapeEnum shapeEnum,
      {bool disabled = false}) {
    super.setStyle(context, themeEnum, shapeEnum);
    border = 1;
    if (disabled) {
      setDisableStyle();
      return;
    }
    switch (themeEnum) {
      case MXTagThemeEnum.info:
        textColor = MXTheme.of(context).fontUsePrimaryColor;
        backgroundColor = MXTheme.of(context).infoColor3;
        borderColor = MXTheme.of(context).infoColor5;
        break;
      case MXTagThemeEnum.primary:
        textColor = MXTheme.of(context).brandPrimaryColor;
        backgroundColor = MXTheme.of(context).brandColor2;
        borderColor = textColor;
        break;
      case MXTagThemeEnum.danger:
        textColor = MXTheme.of(context).errorPrimaryColor;
        backgroundColor = MXTheme.of(context).errorColor2;
        borderColor = textColor;
        break;
      case MXTagThemeEnum.warning:
        textColor = MXTheme.of(context).warnPrimaryColor;
        backgroundColor = MXTheme.of(context).warnColor2;
        borderColor = textColor;
        break;
      case MXTagThemeEnum.success:
        textColor = MXTheme.of(context).successPrimaryColor;
        backgroundColor = MXTheme.of(context).successColor2;
        borderColor = textColor;
        break;
    }
  }
}
