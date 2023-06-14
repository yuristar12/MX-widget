import 'package:flutter/material.dart';
import 'package:mx_widget/src/config/global_enum.dart';
import 'package:mx_widget/src/theme/mx_colors.dart';
import 'package:mx_widget/src/theme/mx_spaces.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';

/// ---------------------------------------------------------------------icon组件
/// [iconSizeEnum] /// icon大小
/// [iconColor] /// 颜色
/// [action] icon的点击事件
/// [icon] icon图标
/// [disabled] icon点击是否禁用
/// [iconFontSize] icon图标的自定义大小

class MXIcon extends StatelessWidget {
  const MXIcon({
    super.key,
    this.action,
    this.iconColor,
    required this.icon,
    this.disabled = false,
    this.iconFontSize,
    this.iconSizeEnum = MXIconSizeEnum.medium,
    this.useDefaultPadding = true,
  });

  /// icon大小
  final MXIconSizeEnum iconSizeEnum;

  /// icon 颜色
  final Color? iconColor;

  /// icon点击事件

  final MXIconAction? action;

  /// icon图标

  final IconData icon;

  /// 是否禁用

  final bool disabled;

  /// icon图标的自定义大小
  final double? iconFontSize;

  final bool useDefaultPadding;

  /// 获取icon图标的颜色
  Color _getIconColor(BuildContext context) {
    return iconColor ?? MXTheme.of(context).fontUseIconColor;
  }

  /// 获取内间距
  EdgeInsets _getPadding(BuildContext context) {
    if (!useDefaultPadding) {
      return const EdgeInsets.all(0);
    }

    switch (iconSizeEnum) {
      case MXIconSizeEnum.large:
        return EdgeInsets.all(MXTheme.of(context).space8 - 2);
      case MXIconSizeEnum.medium:
        return EdgeInsets.all(MXTheme.of(context).space4);
      case MXIconSizeEnum.small:
        return EdgeInsets.all(MXTheme.of(context).space4 - 2);
    }
  }

  double _getIconSize() {
    if (iconFontSize != null) {
      return iconFontSize!;
    }

    switch (iconSizeEnum) {
      case MXIconSizeEnum.large:
        return 18;
      case MXIconSizeEnum.medium:
        return 16;
      case MXIconSizeEnum.small:
        return 14;
    }
  }

  Widget toBuildIcon(BuildContext context) {
    return Icon(
      icon,
      size: _getIconSize(),
      color: _getIconColor(context),
    );
  }

  Widget toBuildIconBody(BuildContext context) {
    if (action != null) {
      return IconButton(
        padding: const EdgeInsets.all(0),
        alignment: Alignment.center,
        iconSize: _getIconSize(),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: disabled ? null : action,
        icon: toBuildIcon(context),
        disabledColor: MXTheme.of(context).fontUseDisabledColor,
      );
    } else {
      return Container(
          padding: _getPadding(context), child: toBuildIcon(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return toBuildIconBody(context);
  }
}
