// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_base_style.dart';

class MXTagOutlineStyle extends MXTagBaseStyle {
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
        borderColor = MXTheme.of(context).fontUseSecondColors;
        break;
      case MXTagThemeEnum.primary:
        textColor = MXTheme.of(context).brandPrimaryColor;
        borderColor = textColor;
        break;
      case MXTagThemeEnum.danger:
        textColor = MXTheme.of(context).errorPrimaryColor;
        borderColor = textColor;
        break;
      case MXTagThemeEnum.warning:
        textColor = MXTheme.of(context).warnPrimaryColor;
        borderColor = textColor;
        break;
      case MXTagThemeEnum.success:
        textColor = MXTheme.of(context).successPrimaryColor;
        borderColor = textColor;
        break;
    }

    backgroundColor = MXTheme.of(context).whiteColor;
  }
}
