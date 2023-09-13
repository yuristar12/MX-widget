import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

class MXPopUpBottomBody extends StatelessWidget {
  const MXPopUpBottomBody({
    super.key,
    this.title,
    this.leftText,
    this.rightText,
    this.titleStyle,
    this.leftWidget,
    this.rightWidget,
    this.onRightCallback,
    this.onLeftCallback,
    required this.child,
    this.backgroundColor,
    this.horizontalSpace,
    this.titleWidget,
  });

  final String? title;

  final String? leftText;

  final String? rightText;

  final TextStyle? titleStyle;

  final Widget? leftWidget;

  final Widget? rightWidget;

  final Widget? titleWidget;

  final VoidCallback? onRightCallback;

  final VoidCallback? onLeftCallback;

  final Color? backgroundColor;

  final Widget child;

  final double? horizontalSpace;

  Widget _buildTitle(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          child: _buildTtileLeft(),
        ),
        Center(
          child: _buildTitleCenter(context),
        ),
        Positioned(
          right: 0,
          child: _buildTitleRight(),
        ),
      ],
    );
  }

  Widget _buildTtileLeft() {
    return Visibility(
        visible: leftWidget != null || leftText != null,
        child: leftWidget ??
            MXButton(
              customMargin: const EdgeInsets.all(0),
              text: leftText ?? '',
              afterClickButtonCallback: () {
                onLeftCallback?.call();
              },
              sizeEnum: MXButtonSizeEnum.small,
              themeEnum: MXButtonThemeEnum.error,
              typeEnum: MXButtonTypeEnum.plainText,
            ));
  }

  Widget _buildTitleRight() {
    return Visibility(
        visible: rightWidget != null || rightText != null,
        child: rightWidget ??
            MXButton(
              customMargin: const EdgeInsets.all(0),
              text: rightText ?? '',
              afterClickButtonCallback: () {
                onRightCallback?.call();
              },
              sizeEnum: MXButtonSizeEnum.small,
              themeEnum: MXButtonThemeEnum.primary,
              typeEnum: MXButtonTypeEnum.text,
            ));
  }

  Widget _buildTitleCenter(BuildContext context) {
    if (title == null) {
      return Container();
    }

    return MXText(
      data: title,
      maxLines: 1,
      font: MXTheme.of(context).fontBodyLarge,
      style: titleStyle ??
          TextStyle(
              overflow: TextOverflow.ellipsis,
              color: MXTheme.of(context).fontUsePrimaryColor,
              fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    if (title != null ||
        rightText != null ||
        rightWidget != null ||
        leftText != null ||
        leftWidget != null ||
        titleWidget != null) {
      if (titleWidget != null) {
        children.add(titleWidget!);
      } else {
        children.add(_buildTitle(context));
      }
    }

    children.add(child);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalSpace ?? MXTheme.of(context).space16,
          vertical: MXTheme.of(context).space8),
      decoration: BoxDecoration(
          color: backgroundColor ?? MXTheme.of(context).whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MXTheme.of(context).radiusMedium),
              topRight: Radius.circular(MXTheme.of(context).radiusMedium))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
