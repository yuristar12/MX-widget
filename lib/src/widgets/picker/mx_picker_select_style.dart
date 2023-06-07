import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mx_widget/src/theme/mx_colors.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';

class MXPickerSelectStyle {
  MXPickerSelectStyle();

  /// 距离小于0.5即代表选中的状态
  selectStyleByFontWeight(double distance) {
    if (distance < 0.5) {
      return FontWeight.bold;
    } else {
      return FontWeight.w400;
    }
  }

  selectStyleByFontColor(BuildContext context, double distance) {
    if (distance < 0.5) {
      return MXTheme.of(context).fontUsePrimaryColor;
    } else {
      return MXTheme.of(context).fontUseSecondColors;
    }
  }
}
