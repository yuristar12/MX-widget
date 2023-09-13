import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

typedef MXActionOptionClick = void Function(MXActionSheetListModel model);

class MXActionSheetContentByListItem extends StatelessWidget {
  const MXActionSheetContentByListItem(
      {super.key,
      required this.model,
      required this.isLast,
      required this.optionClick});

  final MXActionSheetListModel model;

  final MXActionOptionClick optionClick;

  final bool isLast;

  // 文字及icon的颜色
  Color _textColor(BuildContext context) {
    Color color;
    MXThemeConfig mxThemeConfig = MXTheme.of(context);
    switch (model.type) {
      case MXActionSheetListType.common:
        color = mxThemeConfig.fontUsePrimaryColor;
        break;
      case MXActionSheetListType.primary:
        color = mxThemeConfig.brandPrimaryColor;
        break;
      case MXActionSheetListType.disabled:
        color = mxThemeConfig.fontUseDisabledColor;
        break;
      case MXActionSheetListType.error:
        color = mxThemeConfig.errorPrimaryColor;
        break;
    }

    return color;
  }

  // 文字样式
  Widget _buildText(BuildContext context, Color textColor) {
    return MXText(
      data: model.label,
      isLine: true,
      textColor: textColor,
      font: MXTheme.of(context).fontBodyMedium,
    );
  }

  Widget _buildIcon(BuildContext context, Color color) {
    List<Widget> children = [];

    children.add(MXIcon(
      icon: model.icon!,
      iconColor: color,
      iconFontSize: MXTheme.of(context).fontBodyMedium!.size,
    ));

    children.add(SizedBox(
      width: MXTheme.of(context).space8,
    ));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildBadge(BuildContext context) {
    List<Widget> children = [];

    children.add(SizedBox(
      width: MXTheme.of(context).space8,
    ));

    children.add(model.badge!);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    Color color = _textColor(context);
    if (model.icon != null) {
      children.add(_buildIcon(context, color));
    }

    children.add(_buildText(context, color));

    if (model.badge != null) {
      children.add(_buildBadge(context));
    }

    return GestureDetector(
      onTap: () {
        if (model.type == MXActionSheetListType.disabled) return;
        optionClick(model);
      },
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: MXTheme.of(context).space16),
        decoration: BoxDecoration(
          color: MXTheme.of(context).whiteColor,
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                      color: MXTheme.of(context).infoColor1, width: 1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
