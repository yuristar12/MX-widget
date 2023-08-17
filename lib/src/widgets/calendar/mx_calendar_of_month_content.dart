import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/calendar/calendarOfDay/mx_calendar_of_day_by_common.dart';
import 'package:mx_widget/src/widgets/calendar/calendarOfDay/mx_calendar_of_day_by_disabled.dart';
import 'package:mx_widget/src/widgets/calendar/calendarOfDay/mx_calendar_of_day_by_range.dart';

class MXCalendarOfMonthContent extends StatefulWidget {
  const MXCalendarOfMonthContent(
      {super.key,
      required this.time,
      required this.controller,
      required this.eventKey,
      required this.compensateOfDay});

  final DateTime time;
  final String eventKey;

  final int compensateOfDay;
  final MXCalendarController controller;

  @override
  State<MXCalendarOfMonthContent> createState() =>
      _MXCalendarOfMonthContentState();
}

class _MXCalendarOfMonthContentState extends State<MXCalendarOfMonthContent> {
  void _onClickDay(int day) {
    DateTime currentTime =
        DateTime(widget.time.year, widget.time.month.toInt(), day);

    MXCalendarTypeEnum typeEnum = widget.controller.typeEnum;

    switch (typeEnum) {
      case MXCalendarTypeEnum.single:
        _onClickDayBySingle(currentTime);
        break;

      case MXCalendarTypeEnum.multiple:
        _onClickDayByMultiple(currentTime);
        break;

      case MXCalendarTypeEnum.range:
        _onClickDayByRange(currentTime);
        break;
    }
  }

  /// 当模式为单选时触发
  void _onClickDayBySingle(DateTime currentTime) {
    dynamic value = widget.controller.value;
    bool isUpdateLayout = false;
    if (value != null) {
      if (value.year != currentTime.year || value.month != currentTime.month) {
        isUpdateLayout = true;
      }
      if (widget.controller.value.isAtSameMomentAs(currentTime)) return;
    }
    widget.controller.value = currentTime;
    if (isUpdateLayout) {
      mxEventCenter.trigger<DateTime>(widget.eventKey, params: currentTime);
    } else {
      setState(() {});
    }
  }

  /// 当模式为多选时触发
  void _onClickDayByMultiple(DateTime currentTime) {
    List<DateTime> value = widget.controller.value as List<DateTime>;

    if (value.contains(currentTime)) {
      value.remove(currentTime);
    } else {
      value.add(currentTime);
    }

    mxEventCenter.trigger<DateTime>(widget.eventKey, params: currentTime);
  }

  /// 当模式为范围时触发
  void _onClickDayByRange(DateTime currentTime) {
    MXCalendarValueByRange value =
        widget.controller.value as MXCalendarValueByRange;

    if (value.startTime == null) {
      value.startTime = currentTime;
    } else if (value.startTime != null && value.endTime == null) {
      // 判断时间是否早于开始时间如果是则重新复制开始时间
      if (currentTime.isBefore(value.startTime!)) {
        value.startTime = currentTime;
      } else if (currentTime.isAfter(value.startTime!)) {
        value.endTime = currentTime;
      }
    }
    // 如果开始及结束时间都存在，则清空两个时间并且重新赋值开始时间
    else if (value.startTime != null && value.endTime != null) {
      value.cleanTime();
      value.startTime = currentTime;
    }
    mxEventCenter.trigger<DateTime>(widget.eventKey, params: currentTime);
  }

  bool _judgeActivity(int day) {
    bool result = false;
    MXCalendarController controller = widget.controller;

    if (controller.value == null) return result;

    switch (controller.typeEnum) {
      case MXCalendarTypeEnum.single:
        result = _judgeActivityBySingle(day);
        break;
      case MXCalendarTypeEnum.multiple:
        result = _judgeActivityByMultiple(day);
        break;
      default:
        return false;
    }

    return result;
  }

  bool _judgeIsRange(int day) {
    DateTime currentTime =
        DateTime(widget.time.year, widget.time.month.toInt(), day);
    MXCalendarValueByRange value =
        widget.controller.value as MXCalendarValueByRange;

    DateTime? startTime = value.startTime;

    DateTime? endTime = value.endTime;

    if (startTime != null && endTime != null) {
      if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
        return true;
      }
    }

    return false;
  }

// 判断单选情况下的是否选中
  bool _judgeActivityBySingle(int day) {
    DateTime value = widget.controller.value;
    DateTime currentTime =
        DateTime(widget.time.year, widget.time.month.toInt(), day);

    if (value.isAtSameMomentAs(currentTime)) return true;

    return false;
  }

// 判断多选情况下的是否选中
  bool _judgeActivityByMultiple(int day) {
    List<DateTime> value = widget.controller.value as List<DateTime>;
    DateTime currentTime =
        DateTime(widget.time.year, widget.time.month.toInt(), day);

    if (value.contains(currentTime)) return true;
    return false;
  }

// 判断范围情况下的是否选中开始时间
  bool _judgeActivityByRangeOfStart(int day) {
    DateTime currentTime =
        DateTime(widget.time.year, widget.time.month.toInt(), day);
    MXCalendarValueByRange value =
        widget.controller.value as MXCalendarValueByRange;

    DateTime? startTime = value.startTime;

    if (startTime != null && startTime.isAtSameMomentAs(currentTime)) {
      return true;
    }
    return false;
  }

  // 判断范围情况下的是否选中结束时间
  bool _judgeActivityByRangeOfEnd(int day) {
    DateTime currentTime =
        DateTime(widget.time.year, widget.time.month.toInt(), day);
    MXCalendarValueByRange value =
        widget.controller.value as MXCalendarValueByRange;

    DateTime? endTime = value.endTime;

    if ((endTime != null && endTime.isAtSameMomentAs(currentTime))) {
      return true;
    }
    return false;
  }

  bool _judgeByDisabled(int day) {
    DateTime currentTime =
        DateTime(widget.time.year, widget.time.month.toInt(), day);

    return widget.controller.disableds!.contains(currentTime);
  }

  Widget _buildContent() {
    DateTime time = widget.time;

    // 获取当月一共多少天
    int monthTotalDay =
        DateTime(time.year.toInt(), time.month.toInt() + 1, 0).day;

    // 获取当月第一天是星期几
    int firstDay = DateTime(time.year.toInt(), time.month.toInt(), 1).weekday;

    int totalNum = monthTotalDay + firstDay;

    return LayoutBuilder(
        builder: ((BuildContext context, BoxConstraints constraints) {
      MXCalendarTypeEnum typeEnum = widget.controller.typeEnum;
      double width = constraints.biggest.width / 7;
      List<Widget> children = [];

      const double dayItemHeight = 60;

      final double horizontalSpace =
          typeEnum == MXCalendarTypeEnum.range ? 0 : 4;
      const double columnSpace = 4;

      for (var i = 0; i < totalNum; i++) {
        if (i < firstDay) {
          children.add(SizedBox(
            width: width,
            height: dayItemHeight,
          ));
        } else {
          int day = i - firstDay + 1;

          bool isDisabled = _judgeByDisabled(day);

          if (isDisabled) {
            children.add(MXCalendarOfDayByDisabled(day: day.toString()));
          } else if (typeEnum == MXCalendarTypeEnum.range) {
            children.add(MXCalendarOfDayByRange(
                day: day.toString(),
                isRange: _judgeIsRange(day),
                isEnd: _judgeActivityByRangeOfEnd(day),
                isStart: _judgeActivityByRangeOfStart(day),
                clickCallback: () {
                  _onClickDay(day);
                }));
          } else {
            children.add(MXCalendarOfDayByCommon(
              day: day.toString(),
              clickCallback: () {
                _onClickDay(day);
              },
              isActivity: _judgeActivity(day),
            ));
          }
        }
      }

      return SizedBox(
        height: ((totalNum / 7).ceil()) * dayItemHeight,
        child: GridView.count(
          crossAxisSpacing: horizontalSpace,
          mainAxisSpacing: columnSpace,
          crossAxisCount: 7,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio:
              (width - horizontalSpace) / (dayItemHeight - columnSpace),
          children: children,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
