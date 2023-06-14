import 'package:mx_widget/src/export.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_base_style.dart';

class MXTagDeepStyle extends MXTagBaseStyle {
  @override
  void setStyle(
      BuildContext context, MXTagThemeEnum themeEnum, MXTagshapeEnum shapeEnum,
      {bool disabled = false}) {
    super.setStyle(context, themeEnum, shapeEnum);
    if (disabled) {
      setDisableStyle();
      return;
    }
    textColor = MXTheme.of(context).whiteColor;
    switch (themeEnum) {
      case MXTagThemeEnum.info:
        textColor = MXTheme.of(context).fontUsePrimaryColor;
        backgroundColor = MXTheme.of(context).infoColor3;
        break;
      case MXTagThemeEnum.primary:
        backgroundColor = MXTheme.of(context).brandPrimaryColor;
        break;
      case MXTagThemeEnum.danger:
        backgroundColor = MXTheme.of(context).errorPrimaryColor;
        break;
      case MXTagThemeEnum.warning:
        backgroundColor = MXTheme.of(context).warnPrimaryColor;
        break;
      case MXTagThemeEnum.success:
        backgroundColor = MXTheme.of(context).successPrimaryColor;
        break;
    }

    border = 0;
  }
}
