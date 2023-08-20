import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/calendar/calendarOfDay/mx_calendar_of_day.dart';

class MXCalendarOfDayByRange extends MXCalendarOfDay {
  const MXCalendarOfDayByRange({
    super.key,
    super.builder,
    required super.day,
    required super.width,
    super.clickCallback,
    this.isEnd = false,
    this.isStart = false,
    this.isRange = false,
    this.aweakColor,
    this.weaknessColor,
  });

  final bool isEnd;
  final bool isStart;

  final bool isRange;

  final Color? weaknessColor;

  final Color? aweakColor;

  @override
  BorderRadiusGeometry getRadius(MXThemeConfig mxThemeConfig) {
    Radius radius = Radius.circular(mxThemeConfig.radiusDefault);

    if (isStart) {
      return BorderRadius.only(topLeft: radius, bottomLeft: radius);
    } else if (isEnd) {
      return BorderRadius.only(topRight: radius, bottomRight: radius);
    }

    return const BorderRadius.all(Radius.zero);
  }

  @override
  Color getTextColor(MXThemeConfig mxThemeConfig) {
    if (isEnd || isStart) return mxThemeConfig.whiteColor;
    return mxThemeConfig.fontUsePrimaryColor;
  }

  @override
  Color getBackgroundColor(MXThemeConfig mxThemeConfig) {
    if (isEnd || isStart) return aweakColor ?? mxThemeConfig.brandPrimaryColor;
    if (isRange) return weaknessColor ?? mxThemeConfig.brandColor2;
    return Colors.transparent;
  }
}
