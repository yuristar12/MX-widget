import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/picker/datePicker/model/date_picker_model.dart';
import 'package:mx_widget/src/widgets/picker/datePicker/mx_date_picker.dart';
import 'package:mx_widget/src/widgets/picker/multipleOptionsPicker/model/multiple_options_model.dart';
import 'package:mx_widget/src/widgets/picker/multipleOptionsPicker/mx_multiple_options_picker.dart';
import 'package:mx_widget/src/widgets/picker/optionsPicker/model/options_picker_model.dart';
import 'package:mx_widget/src/widgets/picker/optionsPicker/mx_options_picker.dart';

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

  showOptionsPicker(BuildContext context,
      OptionsPickerParams optionsPickerParams, MXOptionsQuery mxOptionsQuery) {
    OptionsPickerModel optionsPickerModel = OptionsPickerModel(
      options: mxOptionsQuery.options,
      initialValue: mxOptionsQuery.initialValue,
      optionProperty: mxOptionsQuery.optionProperty,
    );

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return MXOptionsPicker(
              optionsPickerParams: optionsPickerParams,
              optionsPickerModel: optionsPickerModel);
        },
        backgroundColor: Colors.transparent);
  }

  showMultipleOptionsPicker(
      BuildContext context,
      MultipleOptionsQuery multipleOptionsQuery,
      MultiplePickerParams multiplePickerParams) {
    MultipleOptionsModel multipleOptionsModel = MultipleOptionsModel(
      options: multipleOptionsQuery.options,
      initialValue: multipleOptionsQuery.initialValue,
      optionProperty: multipleOptionsQuery.optionProperty,
    );

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return MXMultipleOptionsPicker(
            multipleOptionsModel: multipleOptionsModel,
            multiplePickerParams: multiplePickerParams,
          );
        },
        backgroundColor: Colors.transparent);
  }
}
