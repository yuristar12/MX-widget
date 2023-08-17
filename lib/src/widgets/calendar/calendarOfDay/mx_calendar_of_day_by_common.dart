import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXCalendarOfDayByCommon extends StatelessWidget {
  const MXCalendarOfDayByCommon(
      {super.key,
      required this.day,
      this.isActivity = false,
      required this.clickCallback});

  final String day;

  final bool isActivity;

  final VoidCallback clickCallback;

  BorderRadiusGeometry _getRadius(MXThemeConfig mxThemeConfig) {
    Radius radius = Radius.circular(mxThemeConfig.radiusDefault);

    return BorderRadius.all(radius);
  }

  Color _getBackgroundColor(MXThemeConfig mxThemeConfig) {
    return mxThemeConfig.brandPrimaryColor;
  }

  Color _getTextColor(MXThemeConfig mxThemeConfig) {
    if (isActivity) return mxThemeConfig.whiteColor;
    return mxThemeConfig.fontUsePrimaryColor;
  }

  Widget _buildBody(BuildContext context) {
    MXThemeConfig mxThemeConfig = MXTheme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: _getBackgroundColor(mxThemeConfig),
          borderRadius: _getRadius(mxThemeConfig)),
      child: Center(
        child: MXText(
          isNumber: true,
          font: mxThemeConfig.fontBodyMedium,
          data: day,
          fontWeight: FontWeight.bold,
          textColor: _getTextColor(mxThemeConfig),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickCallback,
      child: _buildBody(context),
    );
  }
}
