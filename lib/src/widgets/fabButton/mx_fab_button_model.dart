import 'package:flutter/widgets.dart';

import '../../../mx_widget.dart';

class MXFabButtonModel {
  MXFabButtonModel({
    this.text,
    this.icon,
    this.customPosition,
    this.padding = 20,
    this.customHeight,
    this.customWidth,
    this.afterClickButtonCallback,
    required this.themeEnum,
    required this.sizeEnum,
    this.aligiment = MXFabButtonAligimentEnum.bottomRight,
  }) : assert(() {
          if (aligiment == MXFabButtonAligimentEnum.customer &&
              customPosition == null) {
            throw FlutterError('自定义模式下，位置信息必须传入');
          }

          return true;
        }());

  final double? padding;

  final MXFabButtonAligimentEnum aligiment;

  final MXButtonThemeEnum themeEnum;

  final MXButtonSizeEnum sizeEnum;

  final String? text;

  final IconData? icon;

  final MXFabButtonCustomPosition? customPosition;

  final VoidCallback? afterClickButtonCallback;

  final double? customWidth;
  final double? customHeight;
}
