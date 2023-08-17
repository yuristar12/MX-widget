import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

// 日历中被禁用的日期组件
class MXCalendarOfDayByDisabled extends StatelessWidget {
  const MXCalendarOfDayByDisabled({super.key, required this.day});

  final String day;

  Widget _buildBody(BuildContext context) {
    MXThemeConfig mxThemeConfig = MXTheme.of(context);
    return Center(
      child: MXText(
        data: day,
        isNumber: true,
        fontWeight: FontWeight.bold,
        font: mxThemeConfig.fontBodyMedium,
        textColor: mxThemeConfig.fontUseDisabledColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: _buildBody(context));
  }
}
