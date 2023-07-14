import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/sideBar/mx_side_bar.dart';
import 'package:mx_widget/src/widgets/sideBar/mx_side_bar_item_model.dart';

typedef MXSideBarOnTabChange = void Function(int index);

typedef MXSideBarItemBuilder = Widget Function(
    MXSideBarItemModel model, bool isActivity);

class MXSideBarController {
  MXSideBarController({
    this.initValue,
    this.sideBarItemBuilder,
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

  /// [sideBarItemBuilder] 自定义item的widget
  MXSideBarItemBuilder? sideBarItemBuilder;

  MXSideBarState? state;

  MXSideBarOnTabChange? onTabChangeCallback;

  /// [activityValue] sideBar被选中的下标
  int activityValue = 0;

  /// 设置视图层的state
  void setState(MXSideBarState state) {
    this.state = state;
  }

  /// 修改sideBar的活动状态
  void onTabChange(int index) {
    if (index == activityValue) return;
    activityValue = index;

    state?.onActivityChange();

    onTabChangeCallback?.call(activityValue);
  }

  /// 跳转至最后一个
  void onTabChangeToLast() {
    int index = sideBarItemList.length - 1;

    onTabChange(index);
  }
}
