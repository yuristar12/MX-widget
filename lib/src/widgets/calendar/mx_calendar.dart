import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/calendar/mx_calendar_header.dart';
import 'package:mx_widget/src/widgets/calendar/mx_calendar_content.dart';
import 'package:mx_widget/src/widgets/calendar/mx_calendar_controller.dart';

const Map<int, String> weekMap = {
  0: '日',
  1: '一',
  2: '二',
  3: '三',
  4: '四',
  5: '五',
  6: '六',
};

class MXCalendar extends StatelessWidget {
  const MXCalendar({super.key, required this.controller});

  final MXCalendarController controller;

  static int compensateOfDay = 0;

  List<String> _getHeaderList() {
    List<String> list = [];

    for (var i = 0; i < weekMap.length; i++) {
      int index = i + controller.firstDayOfWeek;

      if (weekMap.containsKey(index)) {
        list.add(weekMap[index]!);
      }

      if (i == weekMap.length - 1) {
        int weekLength = weekMap.length;
        int listLength = list.length;
        if (listLength < weekLength) {
          compensateOfDay = listLength;
          int subLength = weekLength - listLength;
          for (var j = 0; j < subLength; j++) {
            list.add(weekMap[j]!);
          }
        }
      }
    }

    return list;
  }

  Widget _buildTitle() {
    List<String> headerList = _getHeaderList();

    return MXCalendarHeader(headerList: headerList);
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
          child: MXCalendarContent(
              controller: controller, compensateOfDay: compensateOfDay)),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    children.add(_buildTitle());

    children.add(_buildContent(context));

    return Column(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
