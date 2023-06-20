import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/popUp/mx_pop_up_body.dart';
import 'package:mx_widget/src/widgets/popUp/mx_pop_up_route.dart';

class MXPopUp {
  // ignore: non_constant_identifier_names
  static void MXpopUpByBottom(
    BuildContext context, {
    Color? customModelColor,
    String? modelLabel,
    bool modelClose = true,
    required String title,
    required Widget child,
    String? leftText,
    String? rightText,
    TextStyle? titleStyle,
    Widget? leftWidget,
    Widget? rightWidget,
    VoidCallback? onRightCallback,
    VoidCallback? onLeftCallback,
    Color? backgroundColor,
  }) {
    _buildPopUp(
        modelClose: modelClose,
        context: context,
        modelLabel: modelLabel,
        mxPopUpShowTypeEnum: MXPopUpShowTypeEnum.toBottom,
        customModelColor: customModelColor,
        builder: (BuildContext context) {
          return MXPopUpBottomBody(
            title: title,
            leftText: leftText,
            rightText: rightText,
            rightWidget: rightWidget,
            leftWidget: leftWidget,
            onLeftCallback: onLeftCallback,
            onRightCallback: onRightCallback,
            titleStyle: titleStyle,
            backgroundColor: backgroundColor,
            child: child,
          );
        });
  }

  // ignore: non_constant_identifier_names
  static void MXpopUpByOther(
    BuildContext context,
    WidgetBuilder builder,
    MXPopUpShowTypeEnum mxPopUpShowTypeEnum, {
    Color? customModelColor,
    String? modelLabel,
    bool modelClose = true,
  }) {
    if (mxPopUpShowTypeEnum == MXPopUpShowTypeEnum.toBottom) {
      throw Error();
    }
    _buildPopUp(
        modelClose: modelClose,
        context: context,
        modelLabel: modelLabel,
        mxPopUpShowTypeEnum: mxPopUpShowTypeEnum,
        customModelColor: customModelColor,
        builder: builder);
  }

  static void _buildPopUp(
      {required bool modelClose,
      required BuildContext context,
      required String? modelLabel,
      required MXPopUpShowTypeEnum mxPopUpShowTypeEnum,
      required Color? customModelColor,
      required WidgetBuilder builder}) {
    Navigator.of(context).push(MXPopUpRoute(
        modelClose: modelClose,
        modelLabel: modelLabel,
        showTypeEnum: mxPopUpShowTypeEnum,
        customModelColor: customModelColor,
        builder: builder));
  }
}
