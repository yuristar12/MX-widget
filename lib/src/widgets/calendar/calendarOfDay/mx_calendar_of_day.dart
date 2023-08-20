import 'package:flutter/material.dart';

import '../../../../mx_widget.dart';

typedef MXCalendarOfDayWidget = Widget Function();

const double height = 60;

class MXCalendarOfDay extends StatelessWidget {
  const MXCalendarOfDay(
      {super.key,
      this.builder,
      required this.day,
      this.clickCallback,
      required this.width});

  final double width;

  final String day;

  final VoidCallback? clickCallback;

  final MXCalendarOfDayWidget? builder;

  BorderRadiusGeometry getRadius(MXThemeConfig mxThemeConfig) {
    Radius radius = Radius.circular(mxThemeConfig.radiusDefault);

    return BorderRadius.all(radius);
  }

  Color getBackgroundColor(MXThemeConfig mxThemeConfig) {
    return Colors.transparent;
  }

  Color getTextColor(MXThemeConfig mxThemeConfig) {
    return mxThemeConfig.fontUsePrimaryColor;
  }

  Widget buildContent(BuildContext context) {
    MXThemeConfig mxThemeConfig = MXTheme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: getBackgroundColor(mxThemeConfig),
          borderRadius: getRadius(mxThemeConfig)),
      child: builder != null
          ? builder!.call()
          : Center(
              child: MXText(
                isNumber: true,
                font: mxThemeConfig.fontBodyMedium,
                data: day,
                fontWeight: FontWeight.bold,
                textColor: getTextColor(mxThemeConfig),
              ),
            ),
    );
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: clickCallback,
      child: buildContent(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: buildBody(context),
    );
  }
}
