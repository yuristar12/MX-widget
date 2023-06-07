import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/config/global_enum.dart';

// startDate = [1991,1,2];
// endDate=[1991,1,31];
// initialDate= [1991,1,31];

class DatePickerModel {
  bool useYear;
  bool useMonth;
  bool useDay;
  bool useWeek;
  bool useHour;
  bool useMinute;
  bool useSecond;

  late List<int> startDate;
  late List<int> endDate;
  late List<int>? initialDate;

  late DateTime value;

  final Map<DatePickerListUnitEnum, String> dateUnitMap = {
    DatePickerListUnitEnum.year: '年',
    DatePickerListUnitEnum.month: '月',
    DatePickerListUnitEnum.day: '日',
    DatePickerListUnitEnum.week: '周',
    DatePickerListUnitEnum.hour: '时',
    DatePickerListUnitEnum.minute: '分',
    DatePickerListUnitEnum.second: '秒',
  };

  final weekMap = ['一', '二', '三', '四', '五', '六', '天'];

  late MXDatePickerListType dateListMap = {
    DatePickerListUnitEnum.year:
        List.generate(endDate[0] - startDate[0] + 1, (index) {
      return startDate[0] + index;
    }),
    DatePickerListUnitEnum.month: [],
    DatePickerListUnitEnum.day: [],
    DatePickerListUnitEnum.week: List.generate(7, (index) {
      return index;
    }),
    DatePickerListUnitEnum.hour: List.generate(24, (index) {
      return index;
    }),
    DatePickerListUnitEnum.minute: List.generate(60, (index) {
      return index;
    }),
    DatePickerListUnitEnum.second: List.generate(60, (index) {
      return index;
    }),
  };

  late int yearIndex;
  late int monthIndex;
  late int dayIndex;
  late int weekIndex;

  static int dateIndexOfYear = 0;

  static int dateIndexOfMonth = 1;

  static int dateIndexOfDay = 2;

  late MXDatePickerScrollContollers scrollContollers;

  DatePickerModel({
    this.useYear = false,
    this.useMonth = false,
    this.useDay = false,
    this.useWeek = false,
    this.useHour = false,
    this.useMinute = false,
    this.useSecond = false,
    required this.startDate,
    required this.endDate,
    this.initialDate,
  }) {
    //  构造函数执行顺序
    initialValue();
    initialMonthValue(value.year);
    initialDayValue(value.year, value.month);

    initialControllers();

    registerListener();
  }

// 初始化value值
  void initialValue() {
    var _startDate = DateTime(startDate[dateIndexOfYear],
        startDate[dateIndexOfMonth], startDate[dateIndexOfDay], 0, 0, 0);

    var _endDate = DateTime(endDate[dateIndexOfYear], endDate[dateIndexOfMonth],
        endDate[dateIndexOfDay], 0, 0, 0);
// 如果初始化有传入初始时间则进行初始化处理
    if (initialDate != null) {
      value = DateTime(
          initialDate![dateIndexOfYear],
          initialDate![dateIndexOfMonth],
          initialDate![dateIndexOfDay],
          0,
          0,
          0);
      if (value.isBefore(_startDate)) {
        value = _startDate;
      } else if (value.isAfter(_endDate)) {
        value = _endDate;
      }
      return;
    }
    // 没有初始化则取当前时间

    value = DateTime.now();

    if (value.isBefore(_startDate)) {
      value = _startDate;
    } else if (value.isAfter(_endDate)) {
      value = _endDate;
    }
  }

// 初始化月份
  void initialMonthValue(int year) {
    // 首先判断开始时间的年份是否相等
    if (startDate[dateIndexOfYear] == endDate[dateIndexOfYear]) {
      dateListMap[DatePickerListUnitEnum.month] = List.generate(
          endDate[dateIndexOfMonth] - startDate[dateIndexOfMonth] + 1, (index) {
        return index + startDate[dateIndexOfMonth] + 1;
      });
    }
    // 判断结束时间是否与选中的年份相同
    else if (endDate[dateIndexOfYear] == year) {
      dateListMap[DatePickerListUnitEnum.month] =
          List.generate(endDate[dateIndexOfMonth], (index) => index + 1);
    }
    // 判断开始时间是否与选中的年份相同
    else if (startDate[dateIndexOfYear] == year) {
      dateListMap[DatePickerListUnitEnum.month] =
          List.generate(12 - startDate[dateIndexOfMonth], (index) => index + 1);
    }
    // 如果都不相同则添加12个月份进去
    else {
      dateListMap[DatePickerListUnitEnum.month] =
          List.generate(12, (index) => index + 1);
    }
  }

  // 初始化天
  void initialDayValue(int year, int month) {
    int startYear = startDate[dateIndexOfYear];
    int startMonth = startDate[dateIndexOfMonth];
    int startDay = startDate[dateIndexOfDay];

    int endYear = endDate[dateIndexOfYear];
    int endMonth = endDate[dateIndexOfMonth];
    int endDay = endDate[dateIndexOfDay];

    // 如果开始时间的年与月与结束时间都相等
    if (startYear == endYear && startMonth == endMonth) {
      dateListMap[DatePickerListUnitEnum.day] =
          List.generate(endDay - startDay + 1, (index) => index + startDay + 1);
    } else if
        // 如果开始时间的年月与选中的相同
        (startYear == year && startMonth == month) {
      // 这里需要算出来开始时间选中的天数这样就不用考虑闰年的情况
      int day = DateTime(startYear, startMonth + 1, 0).day;

      dateListMap[DatePickerListUnitEnum.day] =
          List.generate(day - startDay + 1, (index) => startDay + index + 1);
    } else if
        // 如果结束时间的年月与选中的相同
        (endYear == year && endMonth == month) {
      dateListMap[DatePickerListUnitEnum.day] =
          List.generate(endDay, (index) => index + 1);
    } else {
      // 这里需要算出来开始时间选中的天数这样就不用考虑闰年的情况
      int day = DateTime(year, month + 1, 0).day;
      dateListMap[DatePickerListUnitEnum.day] =
          List.generate(day, (index) => index + 1);
    }
  }

  // 初始化控制器
  initialControllers() {
    scrollContollers = {};
    yearIndex = value.year - dateListMap[DatePickerListUnitEnum.year]![0];
    monthIndex = value.month - dateListMap[DatePickerListUnitEnum.month]![0];
    dayIndex = value.day - dateListMap[DatePickerListUnitEnum.day]![0];
    weekIndex = value.day - dateListMap[DatePickerListUnitEnum.week]![0];

    scrollContollers[DatePickerListUnitEnum.year] =
        FixedExtentScrollController(initialItem: yearIndex);

    scrollContollers[DatePickerListUnitEnum.month] =
        FixedExtentScrollController(initialItem: monthIndex);

    scrollContollers[DatePickerListUnitEnum.day] =
        FixedExtentScrollController(initialItem: dayIndex);

    scrollContollers[DatePickerListUnitEnum.week] =
        FixedExtentScrollController(initialItem: weekIndex);

    scrollContollers[DatePickerListUnitEnum.hour] =
        FixedExtentScrollController(initialItem: value.hour);

    scrollContollers[DatePickerListUnitEnum.minute] =
        FixedExtentScrollController(initialItem: value.minute);

    scrollContollers[DatePickerListUnitEnum.second] =
        FixedExtentScrollController(initialItem: value.second);
  }

  // 添加控制器监听滚动的选择
  void registerListener() {
    scrollContollers[DatePickerListUnitEnum.year]!.addListener(() {
      yearIndex = scrollContollers[DatePickerListUnitEnum.year]!.selectedItem;
    });
    scrollContollers[DatePickerListUnitEnum.month]!.addListener(() {
      monthIndex = scrollContollers[DatePickerListUnitEnum.month]!.selectedItem;
    });
    scrollContollers[DatePickerListUnitEnum.day]!.addListener(() {
      dayIndex = scrollContollers[DatePickerListUnitEnum.day]!.selectedItem;
    });
    scrollContollers[DatePickerListUnitEnum.week]!.addListener(() {
      weekIndex = scrollContollers[DatePickerListUnitEnum.week]!.selectedItem;
    });
  }

// 重新刷新月份列表

  void refreshMonthOnControllerChange() {
    var selectOfYear = dateListMap[DatePickerListUnitEnum.year]![0] + yearIndex;

    initialMonthValue(selectOfYear);

    scrollContollers[DatePickerListUnitEnum.month]!.jumpToItem(
        monthIndex < dateListMap[DatePickerListUnitEnum.month]!.length
            ? monthIndex
            : dateListMap[DatePickerListUnitEnum.month]!.length);
  }

// 重新刷新天数列表

  void refreshDayOnControllerChange() {
    var selectOfYear = dateListMap[DatePickerListUnitEnum.year]![0] + yearIndex;
    var selectOfMonth =
        dateListMap[DatePickerListUnitEnum.month]![0] + monthIndex;
    initialDayValue(selectOfYear, selectOfMonth);

    scrollContollers[DatePickerListUnitEnum.day]!.jumpToItem(
        dayIndex < dateListMap[DatePickerListUnitEnum.day]!.length
            ? dayIndex
            : dateListMap[DatePickerListUnitEnum.day]!.length);
  }

// 重新刷新周列表

  void refresWeekOnControllerChange() {
    // 获取选中的年月日跳转到指定的周几
    var year = scrollContollers[DatePickerListUnitEnum.year]!.selectedItem;
    var month = scrollContollers[DatePickerListUnitEnum.month]!.selectedItem;
    var day = scrollContollers[DatePickerListUnitEnum.day]!.selectedItem;
    var date = DateTime(year, month, day);

    scrollContollers[DatePickerListUnitEnum.week]!.jumpToItem(date.weekday - 1);
  }
}
