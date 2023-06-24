import 'package:flutter/widgets.dart';
import 'package:mx_widget/src/widgets/dialog/mx_dialog_body.dart';

import '../../../mx_widget.dart';

///----------------------------------------------------------------------弹窗组件

class MXDialog {
  /// 反馈内容的对话框
  /// [title] 弹窗的标题
  /// [confirmCallback] 确认按钮的回调方法
  /// [closeCallback] 取消按钮的回调方法
  /// [confirmText] 确认按钮的文案
  /// [confirmWidget] 自定义的确认按钮组件
  /// [content] 弹窗内容的文案
  /// [contentStyle] 弹窗内容的自定义字体样式
  /// [extendButtons] 扩展的按钮集合，只适用与feedback类型的弹窗
  /// [contentWidget] 自定义弹窗内容的部件
  static void dialogByFeedback({
    required String confirmText,
    required BuildContext context,
    String? title,
    VoidCallback? confirmCallback,
    VoidCallback? closeCallback,
    MXButton? confirmWidget,
    List<MXButton>? extendButtons,
    Widget? contentWidget,
    String? content,
    TextStyle? contentStyle,
  }) {
    Widget child = MXDialogBody(
      content: content,
      confirmWidget: confirmWidget,
      closeCallback: closeCallback,
      contentWidget: contentWidget,
      contentStyle: contentStyle,
      confirmText: confirmText,
      title: title,
      extendButtons: extendButtons,
      confirmCallback: confirmCallback,
    );

    showDialog(context, child);
  }

  /// 携带自定义组件的confirm
  /// [title] 弹窗的标题
  /// [confirmCallback] 确认按钮的回调方法
  /// [closeCallback] 取消按钮的回调方法
  /// [cancelText] 取消按钮的文案
  /// [confirmText] 确认按钮的文案
  /// [confirmWidget] 自定义的确认按钮组件
  /// [content] 弹窗内容的文案
  /// [contentStyle] 弹窗内容的自定义字体样式
  /// [customWidget] 扩展的自定义部件有两种位置top与center，只适用
  /// dialogByConfigAndCustomWidget的弹窗高度限制为160
  /// [dialogCustomWidgetDirectionEnum] 弹窗自定义扩展部件的位置

  static void dialogByConfigAndCustomWidget({
    required String title,
    required String cancelText,
    required String confirmText,
    required Widget customWidget,
    required BuildContext context,
    VoidCallback? confirmCallback,
    VoidCallback? closeCallback,
    MXButton? confirmWidget,
    MXButton? cancelWidget,
    String? content,
    TextStyle? contentStyle,
    MXDialogCustomWidgetDirectionEnum dialogCustomWidgetDirectionEnum =
        MXDialogCustomWidgetDirectionEnum.center,
  }) {
    Widget child = MXDialogBody(
      title: title,
      content: content,
      customWidget: customWidget,
      cancelText: cancelText,
      cancelWidget: cancelWidget,
      confirmWidget: confirmWidget,
      closeCallback: closeCallback,
      contentStyle: contentStyle,
      confirmText: confirmText,
      confirmCallback: confirmCallback,
      dialogCustomWidgetDirectionEnum: dialogCustomWidgetDirectionEnum,
      dialogFooterDirectionEnum: MXDialogFooterDirectionEnum.horizontal,
    );

    showDialog(context, child);
  }

  /// 确认形式的对话框
  /// [title] 弹窗的标题
  /// [confirmCallback] 确认按钮的回调方法
  /// [closeCallback] 取消按钮的回调方法
  /// [cancelText] 取消按钮的文案
  /// [confirmText] 确认按钮的文案
  /// [confirmWidget] 自定义的确认按钮组件
  /// [content] 弹窗内容的文案
  /// [contentStyle] 弹窗内容的自定义字体样式
  /// [contentWidget] 自定义弹窗内容的部件
  /// dialogByConfigAndCustomWidget的弹窗高度限制为160
  /// [dialogFooterDirectionEnum] 弹窗底部按钮的排列方式 horizontal与vertical
  static void dialogByConfirm(
      {required String cancelText,
      required String confirmText,
      required BuildContext context,
      String? title,
      VoidCallback? confirmCallback,
      VoidCallback? closeCallback,
      VoidCallback? cancelCallback,
      MXButton? confirmWidget,
      MXButton? cancelWidget,
      Widget? contentWidget,
      String? content,
      TextStyle? contentStyle,
      MXDialogFooterDirectionEnum dialogFooterDirectionEnum =
          MXDialogFooterDirectionEnum.horizontal}) {
    Widget child = MXDialogBody(
      title: title,
      content: content,
      cancelText: cancelText,
      cancelWidget: cancelWidget,
      cancelCallback: cancelCallback,
      confirmWidget: confirmWidget,
      closeCallback: closeCallback,
      contentWidget: contentWidget,
      contentStyle: contentStyle,
      confirmText: confirmText,
      dialogFooterDirectionEnum: dialogFooterDirectionEnum,
      confirmCallback: confirmCallback,
    );
    showDialog(context, child);
  }

  static void showDialog(BuildContext context, Widget child) {
    MXPopUp.MXpopUpByOther(context, (BuildContext content) {
      return child;
    }, MXPopUpShowTypeEnum.toCenter, modelClose: false);
  }
}
