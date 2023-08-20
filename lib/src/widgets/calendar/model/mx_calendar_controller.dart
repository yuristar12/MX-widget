import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

/// 日历组件的控制器
/// [typeEnum] 选择的类型 single/multiple/range
/// [defaultValue] 默认需要选中的值 single下为[DateTime]/multiple下为[List<DateTime>]
/// range 下为 [MXCalendarValueByRange]
/// [minDate] 开始时间 如果携带具体日期如'2021,1,15' 则15日包括（15日）之前的日期无法选择
/// [maxDate] 结束时间 如果携带具体日期如'2021,12,18' 则18日包括（18日）之后的日期无法选择
/// [dayBuilder] 自定义单个日期渲染内容
/// [disableds] 无法选择的日期数组
/// [weaknessColor] 只有当选择类型为range 时生效，被选中之间的日期盒子背景颜色
/// [aweakColor] 被选中的日期盒子背景颜色
/// [onSelect] 日期被选择时

class MXCalendarController {
  MXCalendarController(
      {this.typeEnum = MXCalendarTypeEnum.single,
      this.defaultValue,
      required this.minDate,
      required this.maxDate,
      this.onSelect,
      this.disableds,
      this.aweakColor,
      this.dayBuilder,
      this.weaknessColor,
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

  final MXCalendarOfDayBuilder? dayBuilder;

  final Color? weaknessColor;

  final Color? aweakColor;

  final MXCalendarOnSelect? onSelect;

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
