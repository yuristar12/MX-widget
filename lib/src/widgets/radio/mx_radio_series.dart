import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/checkBox/mx_check_base_series.dart';

import '../../export.dart';

class MXRadioSeries extends MXCheckBoxBaseSeries {
  const MXRadioSeries({
    Key? key,
    Axis direction = Axis.horizontal,
    VoidCallback? onOverloadChcked,
    List<String>? checkIds,
    int? titleMaxLine,
    Widget? child,
    required List<MXRadio> checkRadios,
    OnCheckBoxSeriesValueChange? onCheckBoxSeriesValueChange,
    ContentBuilder? contentBuilder,
    IconBuilder? iconBuilder,
    MXCheckBoxModeEnum? modeEnum,
    double? iconSpace,
    MXCheckBoxDirectionEnum? directionEnum,
  }) : super(
          child: child,
          checkBoxs: checkRadios,
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
        );

  @override
  State<MXCheckBoxBaseSeries> createState() => MXRadioSeriesState();
}

class MXRadioSeriesState extends MXCheckBoxBaseSeriesState {
  @override
  bool toggleBySingle(String id, bool value,
      {bool notify = false, bool useChange = true}) {
    checkedIds.forEach((key, value) {
      checkedIds[key] = false;
    });

    checkedIds[id] = value;

    if (notify) {
      setState(() {});
    }

    // 触发传入的变更方法

    if (useChange) {
      onSeriesValueChange();
    }

    return true;
  }
}
