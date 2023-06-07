import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/datePicker/date_picker_model.dart';
import 'package:mx_widget/src/widgets/datePicker/mx_date_picker.dart';

import '../../export.dart';

class MXPickers {
  showDatePicker(
    BuildContext context,
    DatePickerQuery datePickerQuery,
    DatePickerParams datePickerParams,
  ) {
    DateTime now = DateTime.now();

    datePickerQuery.startDate ??= [now.year - 10, now.month, now.day];
    datePickerQuery.endDate ??= [now.year + 10, now.month, now.day];

    DatePickerModel datePickerModel = DatePickerModel(
        startDate: datePickerQuery.startDate!,
        endDate: datePickerQuery.endDate!,
        initialDate: datePickerQuery.value);

    switch (datePickerParams.datePickerFormatType) {
      case DatePickerFormatType.MM_DD:
        datePickerModel.useMonth = true;
        datePickerModel.useDay = true;
        break;
      case DatePickerFormatType.YYYY_MM:
        datePickerModel.useYear = true;
        datePickerModel.useMonth = true;
        break;
      case DatePickerFormatType.YYYY_MM_DD:
        datePickerModel.useYear = true;
        datePickerModel.useMonth = true;
        datePickerModel.useDay = true;
        break;
      case DatePickerFormatType.YYYY_MM_DD_WW:
        datePickerModel.useYear = true;
        datePickerModel.useMonth = true;
        datePickerModel.useDay = true;
        datePickerModel.useWeek = true;
        break;
      case DatePickerFormatType.YYYY_MM_DD_HH_mm_ss:
        datePickerModel.useYear = true;
        datePickerModel.useMonth = true;
        datePickerModel.useDay = true;
        datePickerModel.useHour = true;
        datePickerModel.useMinute = true;
        datePickerModel.useSecond = true;
        break;
    }

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return MXDatePicker(
            datePickerParams: datePickerParams,
            datePickerModel: datePickerModel,
          );
        });
  }
}
