import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

class MXPopUpBottomBody extends StatelessWidget {
  const MXPopUpBottomBody(
      {super.key,
      required this.title,
      this.leftText,
      this.rightText,
      this.titleStyle,
      this.leftWidget,
      this.rightWidget,
      this.onRightCallback,
      this.onLeftCallback,
      required this.child,
      this.backgroundColor});

  final String title;

  final String? leftText;

  final String? rightText;

  final TextStyle? titleStyle;

  final Widget? leftWidget;

  final Widget? rightWidget;

  final VoidCallback? onRightCallback;

  final VoidCallback? onLeftCallback;

  final Color? backgroundColor;

  final Widget child;

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTtileLeft(),
        _buildTitleCenter(context),
        _buildTitleRight()
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
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MXTheme.of(context).space16,
          vertical: MXTheme.of(context).space8),
      decoration: BoxDecoration(
          color: backgroundColor ?? MXTheme.of(context).whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MXTheme.of(context).radiusMedium),
              topRight: Radius.circular(MXTheme.of(context).radiusMedium))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildTitle(context), child],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
