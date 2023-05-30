import 'package:mx_widget/src/widgets/checkBox/mx_check_base_series.dart';

class MXCheckBoxSeriesController {
  MXCheckBoxBaseSeriesState? state;

  /// 全选
  void toggleAll(bool value) {
    state?.toggleByAll(value);
  }

  /// 反选
  void reverseAll() {
    state?.reverseAll();
  }

  ///通过id选中某一个
  void toggleSingleById(String id, bool value) {
    state?.toggleBySingle(id, value, notify: true, useChange: true);
  }

  /// 返回选中的状态
  List<String> allCheckedIds() {
    List<String> ids = [];
    state?.checkedIds.forEach((key, value) {
      if (state?.checkedIds[key] == true) {
        ids.add(key);
      }
    });
    return ids;
  }

  /// 通过id获取checkBox是否被选中
  bool? getCheckBoxStateById(String id) {
    List<String> ids = allCheckedIds();

    return ids.contains(id);
  }
}
