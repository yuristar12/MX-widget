import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/message/mx_message_manage.dart';

class MXMessage {
  static warning(BuildContext context, MXMessageModel model) {
    MXMessageManage.createMessage(context,
        model: model, type: MXMessageTypeEnum.waring);
  }

  static error(BuildContext context, MXMessageModel model) {
    MXMessageManage.createMessage(context,
        model: model, type: MXMessageTypeEnum.error);
  }

  static success(BuildContext context, MXMessageModel model) {
    MXMessageManage.createMessage(context,
        model: model, type: MXMessageTypeEnum.success);
  }

  static info(BuildContext context, MXMessageModel model) {
    MXMessageManage.createMessage(context,
        model: model, type: MXMessageTypeEnum.info);
  }
}
