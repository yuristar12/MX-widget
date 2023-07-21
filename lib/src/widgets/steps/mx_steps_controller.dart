import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXStepsController {
  MXStepsController({
    required this.stepsItems,
    this.initValue,
    this.onAction,
  }) : assert(() {
          if (initValue != null) {
            // if (initValue > stepsItems.length - 1) {
            //   throw FlutterError('初始值超出数组下标');
            // }
          }

          return true;
        }()) {
    if (initValue != null) {
      activityIndex = initValue!;
    }
  }

  final List<MXStepsItemModel> stepsItems;

  final int? initValue;

  final VoidCallback? onAction;

  late MXStepsState? state;

  int activityIndex = 0;

  void setState(MXStepsState state) {
    this.state = state;
  }

  /// 设置活动状态 [index] 数组下标
  void setActivityIndex(int index) {
    if (index > stepsItems.length - 1) return;

    activityIndex = index;
    state?.onActivityChange.call();

    onAction?.call();
  }
}
