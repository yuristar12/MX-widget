import 'package:flutter/cupertino.dart';

import '../../../mx_widget.dart';

class MXAuthCodeController {
  MXAuthCodeController({this.codeNum = 4, required this.onConfirm}) {
    init();
  }
  int codeNum;
  bool disabled = false;
  bool isError = false;
  int activityInputIndex = 0;
  late MXAuthCodeState mxAuthCodeState;
  MXAuthCodeConfirmCallback onConfirm;
  FocusNode keyListenNode = FocusNode();
  late List<FocusNode> focusNodes = [];
  late List<TextEditingController> textControllers = [];

// 初始化controller与nodes
  void init() {
    focusNodes.clear();
    textControllers.clear();
    for (var i = 0; i < codeNum; i++) {
      FocusNode node = FocusNode();
      TextEditingController controller = TextEditingController();
      focusNodes.add(node);
      textControllers.add(controller);
    }
  }

  void setState(MXAuthCodeState state) {
    mxAuthCodeState = state;
  }

  void setDisabled(bool value) {
    disabled = value;
  }

  void setError(bool value) {
    isError = value;
    // ignore: invalid_use_of_protected_member
    mxAuthCodeState.setState(() {});
  }

  void onInputContentChange(String value, int index, BuildContext context) {
    if (value.isNotEmpty) {
      if (index != codeNum - 1) {
        // 聚焦下一个input
        activityInputIndex += 1;
        // ignore: invalid_use_of_protected_member
        mxAuthCodeState.setState(() {
          FocusScope.of(context).requestFocus(focusNodes[activityInputIndex]);
        });
      } else if (index == codeNum - 1) {
        if (!disabled) {
          onConfirm(getInputValue());
        }
      }
    }
  }

  List<int> getInputValue() {
    List<int> values = [];
    for (var i = 0; i < textControllers.length; i++) {
      var textControllersItem = textControllers[i];
      values.add(int.parse(textControllersItem.value.text));
    }
    return values;
  }
}
