import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/calendar/calendarOfDay/mx_calendar_of_day.dart';

import '../../../../mx_widget.dart';

// // 日历中被禁用的日期组件
class MXCalendarOfDayByDisabled extends MXCalendarOfDay {
  const MXCalendarOfDayByDisabled(
      {super.key, required super.day, required super.width, super.builder});

  @override
  Color getTextColor(MXThemeConfig mxThemeConfig) {
    return mxThemeConfig.fontUseDisabledColor;
  }

  @override
  Widget buildBody(BuildContext context) {
    return SizedBox(
      child: buildContent(context),
    );
  }
}
