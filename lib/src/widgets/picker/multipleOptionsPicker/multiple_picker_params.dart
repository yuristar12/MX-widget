import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/picker/base_picker_params.dart';

import '../../../export.dart';

class MultiplePickerParams extends BasePickerParams {
  MultiplePickerParams({
    OptionsPickerCallback? onConfirm,
    OptionsPickerCallback? onCancel,
    Color? backgroundColor,
    String text = '多级选择器组件',
    bool useTitle = true,
    double pickerHeight = 200,
    Widget? pickerSelectContainer,
    int pickerColumnNum = 5,
    bool useSaftArea = false,
  }) : super(
            text: text,
            onCancel: onCancel,
            onConfirm: onConfirm,
            useTitle: useTitle,
            useSaftArea: useSaftArea,
            backgroundColor: backgroundColor,
            pickerColumnNum: pickerColumnNum,
            pickerHeight: pickerHeight,
            pickerSelectContainer: pickerSelectContainer);
}
