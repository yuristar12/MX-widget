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

/// dialongloading状态的回调方法
typedef MXDialogLoadingCallback = Future<bool> Function();

/// stepper步骤器组件
enum MXStepperSizeEnum { mini, small, medium }

enum MXStepperThemeEnum { fill, plain, bord }

typedef MXStepperOnChangeCallback = void Function(int value);

///
/// 下拉菜单
typedef MXDropDownMenuOnChangeCallback = void Function(List<String>);

enum MXDropDownMenuItemColumnsEnum { one, two, three }

/// 下拉菜单的单个菜单item属性
/// [value] 对应id
/// [label] 对应标题
enum MXDropDownMenuOptionsEnum {
  value,
  label,
}

/// gird 宫格组件
/// [norma] 一般
/// [card] 卡片
enum MXGirdThemeEnum {
  norma,
  card,
}

/// gird 每个item的大小
/// [mini] 小
/// [medium] 中等
/// [large] 大
enum MXGirdSizeEnum {
  mini,
  medium,
  large,
}

/// gird 单个item 点击事件
/// [index] 对应数组下标
typedef MXGirdItemClickCallback = void Function(int index);

/// searchBar 的样式
///
enum MXSearchBarThemeEnum {
  rect,
  round,
}

/// collapse 的排列位置
enum MXCollapsePlacementEnum {
  top,
  bottom,
}

typedef MXCollapseOnChange = void Function(List<String>? value);

/// result 结果页

enum MXResultTypeEnum {
  primary,
  success,
  error,
  warn,
}

/// countDown组件
enum MXCountDownFormatEnum {
  ddhhmmss,
  ddhhmmsss,
  hhmmss,
  hhmmsss,
}

enum MXCountDownShapeEnum { circ, rect, plain, reverse }

enum MXCountDownSizeEnum {
  mini,
  medium,
  lager,
}

/// countDown组件改变的回调方法
typedef MXCountDownOnChange = void Function(int time);

typedef MXCountDownOnFinish = void Function();

/// progress进度条组件
enum MXProgressThemeEnum {
  primary,
  success,
  error,
  warn,
}

enum MXProgressTypeEnum {
  circ,
  line,
}

/// textArea组件

enum MXTextAreaTypeEnum {
  card,
  norma,
}

enum MXTextAreaSizeEnum {
  small,
  medium,
  large,
}

/// 排列方式
enum MXTextAreaAlignmentEnum {
  vertical,
  horizontal,
}

/// steps组件

enum MXStepsTypeEnum {
  number,
  simple,
  pattern,
}

/// sideBar组件
enum MXSideBarTypeEnum {
  page,
  anchor,
}
