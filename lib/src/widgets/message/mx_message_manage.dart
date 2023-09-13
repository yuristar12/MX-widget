import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/message/model/mx_message_instance.dart';
import 'package:mx_widget/src/widgets/message/mx_message_content.dart';

class MXMessageManage {
  static int serialNumber = 0;
  static Map<String, MXMessageInstance> messages = {};

// 销毁message
  static destoryMessage(String serialNumberStr) {
    if (messages.containsKey(serialNumberStr)) {
      MXMessageInstance instance = messages[serialNumberStr]!;
      instance.toDestroyMessage();
      messages.remove(serialNumberStr);
    }
  }

// 创建message
  static createMessage(BuildContext context,
      {required MXMessageModel model, required MXMessageTypeEnum type}) {
    serialNumber += 1;
    String serialNumberStr = serialNumber.toString();
    Widget child = MXMessageContent(
      model: model,
      type: type,
      serialNumber: serialNumberStr,
    );
    MXMessageInstance instance = MXMessageInstance();
    messages[serialNumberStr] = instance;
    instance.toCreateMessage(context, child, offsetY: model.offsetY);
  }
}
