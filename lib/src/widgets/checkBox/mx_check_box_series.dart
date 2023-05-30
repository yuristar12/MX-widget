
import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/widgets/checkBox/mx_check_base_series.dart';

class MXCheckBoxSeries extends MXCheckBoxBaseSeries {
  MXCheckBoxSeries(
      {Key? key,
      int? max,
      Axis direction = Axis.horizontal,
      VoidCallback? onOverloadChcked,
      List<String>? checkIds,
      int? titleMaxLine,
      Widget? child,
      required List<MXCheckBox> checkBoxs,
      OnCheckBoxSeriesValueChange? onCheckBoxSeriesValueChange,
      ContentBuilder? contentBuilder,
      IconBuilder? iconBuilder,
      MXCheckBoxModeEnum? modeEnum,
      double? iconSpace,
      MXCheckBoxDirectionEnum? directionEnum,
      MXCheckBoxSeriesController? checkBoxSeriesController,
      bool? useIndeterminate})
      : assert(() {
          if (useIndeterminate != null && checkBoxSeriesController == null) {
            throw FlutterError(
                '使用useIndeterminate，必须传入checkBoxSeriesController实体类');
          }

          return true;
        }()),
        super(
            child: child,
            checkBoxs: checkBoxs,
            key: key,
            checkIds: checkIds,
            onOverloadChcked: onOverloadChcked,
            titleMaxLine: titleMaxLine,
            onCheckBoxSeriesValueChange: onCheckBoxSeriesValueChange,
            contentBuilder: contentBuilder,
            iconBuilder: iconBuilder,
            modeEnum: modeEnum,
            iconSpace: iconSpace,
            directionEnum: directionEnum,
            direction: direction,
            controller: checkBoxSeriesController,
            useIndeterminate: useIndeterminate);

  @override
  State<MXCheckBoxBaseSeries> createState() => MXCheckBoxSeriesState();
}

class MXCheckBoxSeriesState extends MXCheckBoxBaseSeriesState {}
