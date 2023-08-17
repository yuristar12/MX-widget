import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXCalendarOfDayByRange extends StatelessWidget {
  const MXCalendarOfDayByRange(
      {super.key,
      required this.day,
      this.isEnd = false,
      this.isStart = false,
      this.isRange = false,
      required this.clickCallback});

  final String day;

  final bool isEnd;
  final bool isStart;

  final bool isRange;

  final VoidCallback clickCallback;

  BorderRadiusGeometry _getRadius(MXThemeConfig mxThemeConfig) {
    Radius radius = Radius.circular(mxThemeConfig.radiusDefault);

    if (isStart) {
      return BorderRadius.only(topLeft: radius, bottomLeft: radius);
    } else if (isEnd) {
      return BorderRadius.only(topRight: radius, bottomRight: radius);
    }

    return const BorderRadius.all(Radius.zero);
  }

  Color _getTextColor(MXThemeConfig mxThemeConfig) {
    if (isEnd || isStart) return mxThemeConfig.whiteColor;
    return mxThemeConfig.fontUsePrimaryColor;
  }

  Color _getBackgroundColor(MXThemeConfig mxThemeConfig) {
    if (isEnd || isStart) return mxThemeConfig.brandPrimaryColor;
    if (isRange) return mxThemeConfig.brandColor2;
    return Colors.transparent;
  }

  Widget _buildBody(BuildContext context) {
    MXThemeConfig mxThemeConfig = MXTheme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: _getRadius(mxThemeConfig),
          color: _getBackgroundColor(mxThemeConfig)),
      child: Center(
        child: MXText(
          isNumber: true,
          font: mxThemeConfig.fontBodyMedium,
          data: day,
          textColor: _getTextColor(mxThemeConfig),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: clickCallback, child: _buildBody(context));
  }
}
