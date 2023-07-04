import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/widgets/dropDownMenu/mx_drop_down_menu_item.dart';

import '../../../mx_widget.dart';

class DropDownMenuItemController {
  DropDownMenuItemController(
      {required this.label,
      required this.options,
      this.disabled = false,
      this.initValue,
      this.multiple = false,
      this.onChange,
      this.onConfirm,
      this.onReset,
      this.disabledIds,
      this.columnsEnum = MXDropDownMenuItemColumnsEnum.one})
      : assert(() {
          if (initValue != null) {
            if (!multiple && (initValue.length > 1)) {
              throw FlutterError('单选模式，默认值的长度不能大于1');
            }
          }

          return true;
        }());

  String label;

  bool disabled;

  final List<String>? initValue;

  final bool multiple;

  final List<Map<MXDropDownMenuOptionsEnum, String>> options;

  final MXDropDownMenuOnChangeCallback? onChange;

  final MXDropDownMenuOnChangeCallback? onConfirm;

  final MXDropDownMenuOnChangeCallback? onReset;

  final MXDropDownMenuItemColumnsEnum columnsEnum;

  MXDropDownMenuItemState? state;

  List<String> value = [];

  List<String>? disabledIds;

  void setDisable(value) {
    if (state != null) {
      disabled = value;
    }
  }

  void setState(MXDropDownMenuItemState state) {
    this.state = state;
  }
}
