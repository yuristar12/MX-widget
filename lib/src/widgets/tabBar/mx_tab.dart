import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

class MXTab extends Tab {
  // 单个tab显示的文字
  @override

  /// ignore: overridden_fields
  final String? text;

  /// icon图标
  @override

  /// ignore: overridden_fields
  final Widget? icon;

  // 子节点
  @override

  /// ignore: overridden_fields
  final Widget? child;

  // icon的间距
  @override

  /// ignore: overridden_fields
  final EdgeInsetsGeometry iconMargin;

  // tab的高度
  @override

  /// ignore: overridden_fields
  final double? height;

  /// 是否禁用
  final bool disabled;

  /// tab的大小
  final MXTabSizeEnum size;

  /// 徽标
  final MXBadge? badge;

  @override
  const MXTab({
    Key? key,
    this.text,
    this.icon,
    this.child,
    this.badge,
    this.disabled = false,
    this.size = MXTabSizeEnum.small,
    this.iconMargin = const EdgeInsets.only(bottom: 4, right: 4),
    this.height,
  }) : super(
            key: key,
            text: text,
            height: height,
            icon: icon,
            iconMargin: iconMargin,
            child: child);

  @override
  Widget build(BuildContext context) {
    return buildTabBody(context);
  }

  Widget buildTabBody(BuildContext context) {
    Widget label;

    if (icon == null) {
      label = _buildTabLabelText(context);
    } else if (text == null && child == null) {
      label = icon!;
    } else {
      label = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          icon ?? const SizedBox(),
          SizedBox(
            width: iconMargin.horizontal,
            height: iconMargin.vertical,
          ),
          _buildTabLabelText(context)
        ],
      );
    }

    if (badge != null) {
      label = Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(child: label),
          Positioned(
            top: 0,
            right: 0,
            child: badge!,
          ),
        ],
      );
    }

    return IgnorePointer(
        ignoring: disabled,
        child: Container(
          height: _getTabHeight(),
          alignment: Alignment.center,
          child: Center(
            widthFactor: 1,
            child: label,
          ),
        ));
  }

  Widget _buildTabLabelText(BuildContext context) {
    return child ?? _getFont(context);
  }

  double _getTabHeight() {
    return height ?? (icon != null ? 72 : 48);
  }

  Widget _getFont(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          decoration: TextDecoration.none,
          overflow: TextOverflow.fade,
          fontSize: _getFontSize(context)),
    );
  }

  /// 文字的大小
  double _getFontSize(BuildContext context) {
    switch (size) {
      case MXTabSizeEnum.lager:
        return MXTheme.of(context).fontBodyMedium!.size;
      case MXTabSizeEnum.small:
        return MXTheme.of(context).fontBodySmall!.size;
    }
  }
}
