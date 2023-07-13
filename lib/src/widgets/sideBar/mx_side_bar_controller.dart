import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/sideBar/mx_side_bar.dart';
import 'package:mx_widget/src/widgets/sideBar/mx_side_bar_item_model.dart';

typedef MXSideBarOnTabChange = void Function(int index);

class MXSideBarController {
  MXSideBarController({
    this.initValue,
    this.onTabChangeCallback,
    required this.sideBarItemList,
  }) : assert(() {
          if (initValue != null) {
            if (initValue > sideBarItemList.length - 1) {
              throw FlutterError("初始值大小不能超过数组大小。");
            }
          }

          return true;
        }()) {
    if (initValue != null) activityValue = initValue!;
  }

  /// [initValue] 初始化值范围是[sideBarItemList]下标
  int? initValue;

  /// [sideBarItemList] sideBar的选项列表
  List<MXSideBarItemModel> sideBarItemList;

  MXSideBarState? state;

  MXSideBarOnTabChange? onTabChangeCallback;

  /// [activityValue] sideBar被选中的下标
  int activityValue = 0;

  /// 设置视图层的state
  void setState(MXSideBarState state) {
    this.state = state;
  }

  void onTabChange(int index) {
    activityValue = index;

    state?.onActivityChange();

    onTabChangeCallback?.call(activityValue);
  }
}
