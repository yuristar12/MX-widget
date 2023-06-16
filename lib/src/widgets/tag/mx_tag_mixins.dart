import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/widgets/text/mx_text.dart';

import 'mx_tag_base_style.dart';
import 'mx_tag_deep_style.dart';
import 'mx_tag_outline_plain.dart';
import 'mx_tag_outline_style.dart';
import 'mx_tag_plain_style.dart';

class MXTagMixins {
  late MXTagBaseStyle style;
  void setStyle(BuildContext context, MXTagModeEnum modeEnum,
      MXTagThemeEnum themeEnum, MXTagshapeEnum shapeEnum,
      {bool disabled = false}) {
    switch (modeEnum) {
      case MXTagModeEnum.deep:
        style = MXTagDeepStyle();
        break;
      case MXTagModeEnum.plain:
        style = MXTagPlainStyle();
        break;
      case MXTagModeEnum.outline:
        style = MXTagOutlineStyle();
        break;
      case MXTagModeEnum.outlinePlain:
        style = MXTagOutlinePlainStyle();
        break;
    }
    style.setStyle(context, themeEnum, shapeEnum, disabled: disabled);
  }

  MXFontStyle getFontSize(BuildContext context, MXTagSizeEnum sizeEnum) {
    MXFontStyle fontStyle;
    switch (sizeEnum) {
      case MXTagSizeEnum.lager:
        fontStyle = MXTheme.of(context).fontBodySmall!;
        break;
      case MXTagSizeEnum.medium:
        fontStyle = MXTheme.of(context).fontBodySmall!;
        break;
      case MXTagSizeEnum.small:
        fontStyle = MXTheme.of(context).fontInfoLarge!;
        break;
      case MXTagSizeEnum.mini:
        fontStyle = MXTheme.of(context).fontInfoSmall!;
        break;
    }
    return fontStyle;
  }

  Widget? getIcon(BuildContext context, MXTagSizeEnum sizeEnum,
      {IconData? icon, Widget? iconWidget}) {
    if (iconWidget != null) {
      return iconWidget;
    }

    if (icon != null) {
      return MXIcon(
        icon: icon,
        iconColor: style.textColor,
        iconFontSize: getFontSize(context, sizeEnum).size,
      );
    }
    return null;
  }

  EdgeInsets getPadding(BuildContext context, MXTagSizeEnum sizeEnum) {
    switch (sizeEnum) {
      case MXTagSizeEnum.lager:
        return const EdgeInsets.only(left: 16, right: 16, top: 9, bottom: 9);
      case MXTagSizeEnum.medium:
        return const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3);
      case MXTagSizeEnum.small:
        return const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2);
      case MXTagSizeEnum.mini:
        return const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2);
    }
  }

  Widget buildTag(
    BuildContext context,
    MXTagSizeEnum sizeEnum,
    String text, {
    Widget? textWidget,
    Widget? iconWidget,
    IconData? icon,
    Color? backgroundColor,
    EdgeInsets? padding,
    bool? needCloseIcon,
  }) {
    Widget child = textWidget ??
        MXText(
          forceVerticalCenter: true,
          data: text,
          font: getFontSize(context, sizeEnum),
          style: TextStyle(color: style.textColor),
        );

    List<Widget> list = [];

    if (icon != null || iconWidget != null) {
      // ignore: no_leading_underscores_for_local_identifiers
      var _icon =
          getIcon(context, sizeEnum, icon: icon, iconWidget: iconWidget);
      if (icon != null) {
        list.add(_icon!);
      }
    }

    if (list.isNotEmpty) {
      list.add(child);
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }

    if (needCloseIcon == true) {
      // ignore: no_leading_underscores_for_local_identifiers
      var _closeIcon = getIcon(context, sizeEnum,
          icon: Icons.close_rounded, iconWidget: null);
      if (list.isNotEmpty) {
        list.add(_closeIcon!);
      } else {
        list.add(child);
        list.add(_closeIcon!);
      }
    }

    child = Container(
        decoration: BoxDecoration(
            color: backgroundColor ?? style.backgroundColor,
            borderRadius: style.borderRadius,
            border: Border.all(
                width: style.border!,
                color: style.border! > 0
                    ? style.borderColor!
                    : Colors.transparent)),
        padding: padding ?? getPadding(context, sizeEnum),
        child: child);

    return child;
  }
}
