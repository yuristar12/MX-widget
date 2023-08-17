import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXCalendarController {
  MXCalendarController(
      {this.typeEnum = MXCalendarTypeEnum.single,
      this.defaultValue,
      required this.minDate,
      required this.maxDate,
      this.disableds,
      this.firstDayOfWeek = 0})
      : assert(() {
          if (defaultValue != null) {
            if (typeEnum == MXCalendarTypeEnum.single) {
              if (defaultValue.runtimeType != DateTime) {
                throw FlutterError("默认值类型不匹配，应为DateTime");
              }
            } else if (typeEnum == MXCalendarTypeEnum.multiple) {
              if (defaultValue.runtimeType != List<DateTime>) {
                throw FlutterError("默认值类型不匹配，应为List<DateTime>");
              }
            } else if (typeEnum == MXCalendarTypeEnum.range) {
              if (defaultValue.runtimeType != MXCalendarValueByRange) {
                throw FlutterError("默认值类型不匹配，应为MXCalendarValueByRange");
              }
            }
          }

          return true;
        }()) {
    _onInit();
  }

  final MXCalendarTypeEnum typeEnum;

  final dynamic defaultValue;

  final int firstDayOfWeek;

  final MXCalendarTime minDate;

  final MXCalendarTime maxDate;

  late dynamic value;

  late List<DateTime>? disableds;

  void _onInit() {
    if (defaultValue != null) {
      value = defaultValue;
    } else {
      if (typeEnum == MXCalendarTypeEnum.single) {
        value = null;
      } else if (typeEnum == MXCalendarTypeEnum.multiple) {
        List<DateTime> list = [];
        value = list;
      } else if (typeEnum == MXCalendarTypeEnum.range) {
        value = MXCalendarValueByRange();
      }
    }
    _onInitDisableds();
  }

  /// 初始化无法选择的日期
  void _onInitDisableds() {
    if (disableds == null) {
      List<DateTime> list = [];
      disableds = list;
    }

    if (minDate.day != null && minDate.day! > 0) {
      int year = minDate.year;
      int month = minDate.month;
      for (var i = 0; i < minDate.day!; i++) {
        disableds!.add(DateTime(year, month, i + 1));
      }
    }

    if (maxDate.day != null && maxDate.day! > 0) {
      int year = maxDate.year;
      int month = maxDate.month;
      DateTime endTime = DateTime(year, month, 0);
      int dayTotal = endTime.day;
      int sub = dayTotal - maxDate.day!;

      for (var i = 0; i <= sub; i++) {
        disableds!.add(DateTime(year, month, i + 1 + maxDate.day!));
      }
    }
  }
}
