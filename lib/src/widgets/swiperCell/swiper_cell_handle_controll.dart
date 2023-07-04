import 'package:flutter/cupertino.dart';
import 'package:mx_widget/mx_widget.dart';

class SwiperCellHandleController {
  SwiperCellHandleController(
      {this.icon,
      this.text,
      this.onTap,
      this.theme = MXButtonThemeEnum.primary})
      : assert(() {
          if (text == null && icon == null) {
            throw FlutterError("text或者icon必须存在一个");
          }
          return true;
        }());

  IconData? icon;

  String? text;

  MXButtonThemeEnum? theme;

  VoidCallback? onTap;
}
