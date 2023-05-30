import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_base_style.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_deep_style.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_outline_plain.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_outline_style.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_plain_style.dart';

import '../../config/global_enum.dart';

class MXTagBase {
  late String text;
  late IconData? icon;
  late Widget? iconWidget;
  late Color? backgroundColor;
  late Widget? textWidget;
  late EdgeInsets? padding;
  late MXTagModeEnum modeEnum;
  late MXTagSizeEnum sizeEnum;
  late MXTagshapeEnum shapeEnum;
  late MXTagThemeEnum themeEnum;
}
