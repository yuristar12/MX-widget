import 'package:flutter/widgets.dart';

import '../../../mx_widget.dart';

class MXProgressController {
  MXProgressController({
    this.initValue,
  }) : assert(() {
          if (initValue != null) {
            if (initValue > 100) {
              throw FlutterError("进度不能超过100");
            }
          }
          return true;
        }()) {
    if (initValue != null) {
      value = initValue!;
    }
  }

  int? initValue;

  int value = 0;

  bool isSuccess = false;

  MXProgressState? state;

  void setProgressState(MXProgressState state) {
    this.state = state;
  }

  void setProgressValue(int value) {
    isSuccess = false;
    if (value <= 0) {
      this.value = 0;
    } else if (value >= 100) {
      setToSuccess();
    } else {
      this.value = value;
    }

    state?.onValueChange();
  }

  /// 直接设置为100%
  void setToSuccess() {
    value = 100;
    isSuccess = true;
  }

  /// 重置为0
  void reset() {
    value = 0;
    isSuccess = false;

    state?.onValueChange();
  }
}
