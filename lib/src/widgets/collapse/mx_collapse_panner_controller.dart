import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';

/// -----------------------------------------------------------折叠面板组件的控制器
/// [initValue] 初始化需要展开的值
/// [isOnlyOne] 折叠面板是否只有一个能展开
/// [collapseItemList] 折叠面板组的单个折叠面板
/// [onChange] 折叠面板暂开或关闭的回调事件
class MXCollapsePannerController {
  MXCollapsePannerController({
    this.initValue,
    this.isOnlyOne = true,
    required this.collapseItemList,
  }) : assert(() {
          if (initValue != null && isOnlyOne && initValue.length > 1) {
            throw FlutterError("如果处于只能一个展开，initValue的长度不能超过一。");
          }
          return true;
        }());

  /// [initValue] 初始化需要展开的值
  List<String>? initValue;

  /// [isOnlyOne] 折叠面板是否只有一个能展开
  bool isOnlyOne;

  /// [collapseItemList] 折叠面板组的单个折叠面板
  List<MXCollapsePannerModel> collapseItemList;

  /// [value] 记录展开的值
  List<String> value = [];

  /// mxCollapse 组件的state
  MXCollapseState? state;

  /// [onChange] 折叠面板暂开或关闭的回调事件
  MXCollapseOnChange? onChange;

  void setState(MXCollapseState state) {
    this.state = state;
  }

  void onHandleCollpaseItemById(String id) {
    if (value.isEmpty) {
      value.add(id);
      state?.onValueChange();
      return;
    } else {
      bool flag = value.contains(id);
      if (isOnlyOne) {
        value.clear();
        if (!flag) {
          value.add(id);
        }
      } else {
        if (flag) {
          value.remove(id);
        } else {
          value.add(id);
        }
      }
      state?.onValueChange();
    }
  }
}
