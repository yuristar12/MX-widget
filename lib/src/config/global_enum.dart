import 'package:flutter/material.dart';

/// 按钮的类型枚举
enum MXButtonTypeEnum { fill, text, outline, plain, plainText }

/// 按钮的风格枚举
enum MXButtonThemeEnum { primary, error, success, warn, info }

/// 按钮的尺寸大小的枚举
enum MXButtonSizeEnum {
  large,
  medium,
  small,
  mini,
}

/// 按钮的形状枚举
enum MXButtonShapeEnum {
  round,
  square,
  circ,
  rect,
}

/// 按钮的状态正常形态/按下/禁用
enum MXButtonStatusEnum {
  normal,
  click,
  disabled,
}

typedef ButtonEvent = void Function();

/// 单个tab的大小枚举 大/小
enum MXTabSizeEnum { lager, small }

/// tabbar样式
enum MXTabBarOutlineTypeEnum {
  // 填充样式
  filled,
  // 胶囊样式
  capsule,
  // 卡片
  card
}

/// 微标的大小
enum MXBadgeSizeEnum {
  /// 宽20
  large,

  /// 宽16
  small,
}

/// 微标的圆角度数
enum MXBadgeRadiusEnum {
  /// 圆角 8
  large,

  /// 圆角 4
  small,
}

enum MXBadgeTypeEnum {
  /// 红点
  point,

  /// 文字样式
  text,

  /// 正方形形
  square,

  /// 角标
  cornerMark
}

/// icon组件的点击事件类型
typedef MXIconAction = void Function();

/// icon组件的大小枚举
enum MXIconSizeEnum {
  large,
  medium,
  small,
}

/// navBar组件的点击事件类型
typedef MXNavBarOnBack = void Function();

enum MXDivideAlignmentEnum {
  left,
  center,
  right,
}

/// 图片的模式
enum MXImageModeEnum {
  cut,
  cover,
  circle,
  fitWidth,
  fitHeight,
  roundSquare,
}

/// 头像的大小
enum MXAvatarSizeEnum { lager, medium, small }

/// 头像的模式
enum MXAvatarModeEnum {
  icon,
  img,
  text,
  imgList,
}

/// 头像展示的类型
enum MXAvatarShapeEnum {
  circle,
  square,
}

/// checkBox的大小类型
enum MXCheckBoxSizeEnum {
  lager,
  small,
}

/// checkBox的模式
enum MXCheckBoxModeEnum {
  circle,
  square,
  card,
}

/// checkBox的方向
enum MXCheckBoxDirectionEnum {
  left,
  right,
}

/// checkBox自定义icon控件
typedef IconBuilder = Widget? Function(BuildContext context, bool isCheck);

/// checkBox自定义内容控件
typedef ContentBuilder = Widget? Function(BuildContext context, bool isCheck);

/// checkBox点击事件
typedef OnCheckBoxValueChange = void Function(bool checkValue);

/// switch组件

enum MXSwitchSizeEnum {
  lager,
  medium,
  small,
}

enum MXSwitchModeEnum {
  fill,
  text,
  icon,
}

/// switch组件的点击事件类型
typedef MXSwitchOnChange = void Function(bool value);

/// tag组件
enum MXTagModeEnum {
  deep,
  plain,
  outline,
  outlinePlain,
}

/// tag大小
enum MXTagSizeEnum {
  lager,
  medium,
  small,
  mini,
}

/// tag形状
enum MXTagshapeEnum {
  square,
  round,
}

/// tag主题
enum MXTagThemeEnum {
  primary,
  info,
  danger,
  warning,
  success,
}

/// selectTag组件的点击事件类型
typedef MXTagSelectOnChange = void Function(bool value);

/// bottomNavBar

enum MXBottomNavBarTypeEnum {
  text,
  icon,
  iconText,
}

enum MXBottomNavBarShapeEnum {
  rectangle,
  round,
}

enum MXBottomNavBarItemTypeEnum {
  weak,
  extrude,
}

/// bottomNavBar组件的点击事件类型
typedef MXBottomNavOnChange = void Function(int index);

enum DatePickerListUnitEnum {
  year,
  month,
  day,
  week,
  hour,
  minute,
  second,
}

enum DatePickerFormatType {
  // ignore: constant_identifier_names
  MM_DD,
  // ignore: constant_identifier_names
  YYYY_MM,
  // ignore: constant_identifier_names
  YYYY_MM_DD,
  // ignore: constant_identifier_names
  YYYY_MM_DD_WW,
  // ignore: constant_identifier_names
  YYYY_MM_DD_HH_mm_ss,
}

typedef MXDatePickerListType = Map<DatePickerListUnitEnum, List<int>>;

typedef MXDatePickerScrollContollers
    = Map<DatePickerListUnitEnum, FixedExtentScrollController>;

/// datepicker组件的点击事件类型
typedef DatePickerCallback = void Function(DateTime);

/// optionsPicker组件的点击事件类型
typedef OptionsPickerCallback = void Function(List<dynamic>);

enum OptionsPropertyEnum {
  label,
  value,
}

enum MultipleOptionsPropertyEnum {
  label,
  value,
  children,
}

// toast排列的方向
enum MXToastDirectionEnum {
  vertical,
  horizontal,
}

// input组件的大小
enum MXInputSizeEnum { small, lager }

// input类型
enum MXInputTypeEnum {
  norma,
  twoLine,
}

// input的输入类型
enum MXInputFormatEnum {
  norma,
  number,
}

/// authCode 验证码回调方法
typedef MXAuthCodeConfirmCallback = void Function(List<int>);

/// popup 的出现方式类型
enum MXPopUpShowTypeEnum {
  toLeft,
  toRight,
  toBottom,
  toTop,
  toCenter,
}

/// dialog 按钮的排列方式
enum MXDialogFooterDirectionEnum { horizontal, vertical }

enum MXDialogCustomWidgetDirectionEnum { top, center }
