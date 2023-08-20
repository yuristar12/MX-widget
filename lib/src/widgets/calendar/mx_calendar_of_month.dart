import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/calendar/mx_calendar_of_month_content.dart';

class MXCalendarOfMonth extends StatelessWidget {
  const MXCalendarOfMonth(
      {super.key,
      required this.time,
      required this.eventKey,
      this.compensateOfDay = 0,
      required this.controller});

  final DateTime time;

  final int compensateOfDay;

  final MXCalendarController controller;

  final String eventKey;

  Widget _buildTitleEnum(String str, BuildContext context) {
    MXFontStyle font = MXTheme.of(context).fontBodySmall!;

    Color textColor = MXTheme.of(context).fontUsePrimaryColor;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MXTheme.of(context).space4),
      child: MXText(
        data: str,
        style: TextStyle(
            fontSize: font.size, color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    List<Widget> children = [];

    MXFontStyle font = MXTheme.of(context).fontBodySmall!;

    Color textColor = MXTheme.of(context).fontUsePrimaryColor;

    // 年
    children.add(MXText(
      isNumber: true,
      data: time.year.toString(),
      font: font,
      textColor: textColor,
    ));

    children.add(_buildTitleEnum('年', context));

    // 月
    children.add(MXText(
      isNumber: true,
      data: (time.month).toString(),
      font: font,
      textColor: textColor,
    ));
    children.add(_buildTitleEnum('月', context));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: MXTheme.of(context).space16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _buildContent() {
    return MXCalendarOfMonthContent(
      time: time,
      eventKey: eventKey,
      controller: controller,
      compensateOfDay: compensateOfDay,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(_buildTitle(context));

    children.add(SizedBox(
      height: MXTheme.of(context).space8,
    ));

    children.add(_buildContent());

    return Container(
      padding: EdgeInsets.symmetric(vertical: MXTheme.of(context).space16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: children,
      ),
    );
  }
}
