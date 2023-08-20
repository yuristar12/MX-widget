import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/calendar/calendarOfDay/mx_calendar_of_day.dart';

class MXCalendarOfDayByCommon extends MXCalendarOfDay {
  const MXCalendarOfDayByCommon({
    super.key,
    super.builder,
    required super.width,
    required super.day,
    super.clickCallback,
    this.isActivity = false,
    this.aweakColor,
  });

  final bool isActivity;
  final Color? aweakColor;

  @override
  BorderRadiusGeometry getRadius(MXThemeConfig mxThemeConfig) {
    Radius radius = Radius.circular(mxThemeConfig.radiusDefault);

    return BorderRadius.all(radius);
  }

  @override
  Color getBackgroundColor(MXThemeConfig mxThemeConfig) {
    if (isActivity) return aweakColor ?? mxThemeConfig.brandPrimaryColor;

    return Colors.transparent;
  }

  @override
  Color getTextColor(MXThemeConfig mxThemeConfig) {
    if (isActivity) return mxThemeConfig.whiteColor;
    return mxThemeConfig.fontUsePrimaryColor;
  }
}
