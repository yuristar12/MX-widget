import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/picker/base_picker_params.dart';

import '../../../export.dart';

class DatePickerParams extends BasePickerParams {
  DatePickerParams({
    DatePickerCallback? onConfirm,
    DatePickerCallback? onCancel,
    Color? backgroundColor,
    String text = '选择时间',
    bool useTitle = true,
    double pickerHeight = 200,
    Widget? pickerSelectContainer,
    int pickerColumnNum = 5,
    bool useSaftArea = false,
    this.datePickerFormatType = DatePickerFormatType.YYYY_MM_DD,
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

  final DatePickerFormatType datePickerFormatType;
}
