import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

class MXButtonStyle {
  // 背景颜色
  Color? backgroundColor;
  // border颜色
  Color? borderColor;
  // border宽度
  double? borderWidth;
  // 文字颜色
  Color? textColor;

  MXButtonStyle(
      {this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.textColor});

  /// 通过按钮的主题风格来获取对应的按钮状态样式
  MXButtonStyle.getFillStyleByTheme(
    BuildContext context,
    MXButtonThemeEnum theme,
    MXButtonStatusEnum statusEnum,
  ) {
    switch (theme) {
      case MXButtonThemeEnum.primary:
        backgroundColor = _getColorByPrimary(context, statusEnum);
        textColor = MXTheme.of(context).whiteColor;
        break;
      case MXButtonThemeEnum.error:
        backgroundColor = _getColorByError(context, statusEnum);
        textColor = MXTheme.of(context).whiteColor;
        break;
      case MXButtonThemeEnum.success:
        backgroundColor = _getColorBySuccess(context, statusEnum);
        textColor = MXTheme.of(context).whiteColor;
        break;
      case MXButtonThemeEnum.warn:
        backgroundColor = _getColorByWarn(context, statusEnum);
        textColor = MXTheme.of(context).whiteColor;
        break;
    }

    /// 将border的颜色设置为背景色
    borderColor = backgroundColor;
  }

  /// 通过按钮的主题风格来获取对应的按钮状态样式
  MXButtonStyle.getTextStyleByTheme(
    BuildContext context,
    MXButtonThemeEnum theme,
    MXButtonStatusEnum statusEnum,
  ) {
    switch (theme) {
      case MXButtonThemeEnum.primary:
        textColor = _getColorByPrimary(context, statusEnum);
        break;
      case MXButtonThemeEnum.error:
        textColor = _getColorByError(context, statusEnum);
        break;
      case MXButtonThemeEnum.success:
        textColor = _getColorBySuccess(context, statusEnum);
        break;
      case MXButtonThemeEnum.warn:
        textColor = _getColorByWarn(context, statusEnum);
        break;
    }

    /// 统一设置文字按钮的背景色
    backgroundColor =
        _getButtonTypeByTextClickStatusBackgroundColor(context, statusEnum);

    /// 将border的颜色设置为背景色
    borderColor = backgroundColor;
  }

  /// 通过按钮的主题风格来获取对应的按钮状态样式
  MXButtonStyle.getOutlineStyleByTheme(
    BuildContext context,
    MXButtonThemeEnum theme,
    MXButtonStatusEnum statusEnum,
  ) {
    switch (theme) {
      case MXButtonThemeEnum.primary:
        textColor = _getColorByPrimary(context, statusEnum);
        break;
      case MXButtonThemeEnum.error:
        textColor = _getColorByError(context, statusEnum);
        break;
      case MXButtonThemeEnum.success:
        textColor = _getColorBySuccess(context, statusEnum);
        break;
      case MXButtonThemeEnum.warn:
        textColor = _getColorByWarn(context, statusEnum);
        break;
    }

    /// 统一设置外框按钮的背景色
    backgroundColor =
        _getButtonTypeByOutlineClickStatusBackgroundColor(context, statusEnum);

    /// 将border的颜色设置为文件颜色
    borderColor = textColor;
    borderWidth = 1;
  }

  /// 根据按钮的状态来获取对应的品牌色
  Color _getColorByPrimary(
      BuildContext context, MXButtonStatusEnum statusEnum) {
    switch (statusEnum) {
      case MXButtonStatusEnum.normal:
        return MXTheme.of(context).brandPrimaryColor;
      case MXButtonStatusEnum.disabled:
        return MXTheme.of(context).brandDisabledColor;
      case MXButtonStatusEnum.click:
        return MXTheme.of(context).brandClickColor;
    }
  }

  /// 根据按钮的状态来获取对应的错误色
  Color _getColorByError(BuildContext context, MXButtonStatusEnum statusEnum) {
    switch (statusEnum) {
      case MXButtonStatusEnum.normal:
        return MXTheme.of(context).errorPrimaryColor;
      case MXButtonStatusEnum.disabled:
        return MXTheme.of(context).errorDisabledColor;
      case MXButtonStatusEnum.click:
        return MXTheme.of(context).errorClickColor;
    }
  }

  /// 根据按钮的状态来获取对应的警告色
  Color _getColorByWarn(BuildContext context, MXButtonStatusEnum statusEnum) {
    switch (statusEnum) {
      case MXButtonStatusEnum.normal:
        return MXTheme.of(context).warnPrimaryColor;
      case MXButtonStatusEnum.disabled:
        return MXTheme.of(context).warnDisabledColor;
      case MXButtonStatusEnum.click:
        return MXTheme.of(context).warnClickColor;
    }
  }

  /// 根据按钮的状态来获取对应的成功色
  Color _getColorBySuccess(
      BuildContext context, MXButtonStatusEnum statusEnum) {
    switch (statusEnum) {
      case MXButtonStatusEnum.normal:
        return MXTheme.of(context).successPrimaryColor;
      case MXButtonStatusEnum.disabled:
        return MXTheme.of(context).successDisabledColor;
      case MXButtonStatusEnum.click:
        return MXTheme.of(context).successClickColor;
    }
  }

  /// 获取文字按钮对应状态的背景色
  Color _getButtonTypeByTextClickStatusBackgroundColor(
      BuildContext context, MXButtonStatusEnum statusEnum) {
    switch (statusEnum) {
      case MXButtonStatusEnum.click:
        return MXTheme.of(context).infoPrimaryColor;
      case MXButtonStatusEnum.disabled:
        return MXTheme.of(context).infoDisabledColor;
      default:
        return Colors.transparent;
    }
  }

  /// 获取外框按钮对应状态的背景色
  Color _getButtonTypeByOutlineClickStatusBackgroundColor(
      BuildContext context, MXButtonStatusEnum statusEnum) {
    switch (statusEnum) {
      case MXButtonStatusEnum.click:
        return MXTheme.of(context).infoPrimaryColor;
      case MXButtonStatusEnum.disabled:
        return MXTheme.of(context).infoDisabledColor;
      default:
        return MXTheme.of(context).whiteColor;
    }
  }
}
