import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

import 'mx_calendar_of_month.dart';

class MXCalendarContent extends StatefulWidget {
  const MXCalendarContent(
      {super.key, required this.controller, required this.compensateOfDay});

  final MXCalendarController controller;

  final int compensateOfDay;

  @override
  State<MXCalendarContent> createState() => _MXCalendarContentState();
}

class _MXCalendarContentState extends State<MXCalendarContent> {
  final GlobalKey globalKey = GlobalKey();

  @override
  void dispose() {
    mxEventCenter.off(globalKey.toString());
    super.dispose();
  }

  @override
  void initState() {
    mxEventCenter.onRegister(globalKey.toString(), _layoutUpdate);

    super.initState();
  }

  List<Widget> _getCalendarMonthList() {
    List<Widget> children = [];

    MXCalendarTime minDate = widget.controller.minDate;

    MXCalendarTime maxDate = widget.controller.maxDate;

    DateTime startTime = DateTime(minDate.year, minDate.month);

    DateTime endTime = DateTime(maxDate.year, maxDate.month);

    int startMonth = startTime.month;

    int starYear = startTime.year;

    int endMonth = endTime.month;

    int subYear = endTime.year - starYear;

    int singleMonth = startMonth + endMonth;

    int totalMonth = subYear * 12 + singleMonth - 1;

    int month = startMonth;

    int year = starYear;

    for (var i = 0; i < totalMonth; i++) {
      month += i == 0 ? 0 : 1;

      if (month % 12 == 0) {
        month = 0;
        year += 1;
      }

      DateTime time = DateTime(year.toInt(), month.toInt());
      children.add(MXCalendarOfMonth(
          eventKey: globalKey.toString(),
          time: time,
          controller: widget.controller,
          compensateOfDay: widget.compensateOfDay));
    }

    return children;
  }

  void _layoutUpdate<DateTime>({DateTime? params}) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getCalendarMonthList(),
    );
  }
}
