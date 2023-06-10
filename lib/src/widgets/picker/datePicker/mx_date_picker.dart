import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/picker/mx_picker_select_item.dart';

import '../../../export.dart';
import 'model/date_picker_model.dart';

const double titleHeight = 57;

class MXDatePicker extends StatefulWidget {
  const MXDatePicker({
    super.key,
    required this.datePickerModel,
    required this.datePickerParams,
  });

  final DatePickerParams datePickerParams;

  final DatePickerModel datePickerModel;

  @override
  State<MXDatePicker> createState() => _MXDatePickerState();
}

class _MXDatePickerState extends State<MXDatePicker> {
  // 用于记录picker的高度

  late double pickerHeight;

  @override
  void initState() {
    pickerHeight = widget.datePickerParams.pickerHeight;
    super.initState();
  }

  Widget _buildPickerBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    EdgeInsets containerPadding =
        EdgeInsets.symmetric(horizontal: MXTheme.of(context).space16);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: pickerHeight + titleHeight),
      child: Column(
        children: [
          _buildPickerTitle(context, containerPadding),
          Container(
            width: width,
            height: pickerHeight,
            padding: containerPadding,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 选中的组件

                _buildPicker(context, width),

                _buildListContainer(context, width),
                // 蒙层
                Positioned(
                    top: 0,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        width: width,
                        height: 40,
                        decoration: _buildTopMaskLayer(context),
                      ),
                    )),

                // 蒙层
                Positioned(
                    bottom: 0,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        width: width,
                        height: 40,
                        decoration: _buildBottomMaskLayer(context),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPicker(BuildContext context, double width) {
    return widget.datePickerParams.pickerSelectContainer ??
        Container(
          height: 40,
          width: width,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(MXTheme.of(context).radiusMedium),
              color: MXTheme.of(context).infoColor3),
        );
  }

  Widget _buildPickerTitle(BuildContext context, EdgeInsets padding) {
    List<Widget> children = [];

    // 添加取消按钮
    children.add(GestureDetector(
      onTap: () {
        DateTime time = _getConfirmDate();
        widget.datePickerParams.onCancel!.call(time);
        Navigator.of(context).pop();
      },
      child: Text(
        '取消',
        style: TextStyle(
            color: MXTheme.of(context).fontUseIconColor,
            fontSize: MXTheme.of(context).fontBodyMedium!.size),
      ),
    ));

    children.add(Text(
      widget.datePickerParams.text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: MXTheme.of(context).fontUsePrimaryColor,
          fontSize: MXTheme.of(context).fontBodyLarge!.size),
    ));

    children.add(GestureDetector(
      onTap: () {
        DateTime time = _getConfirmDate();

        widget.datePickerParams.onConfirm?.call(time);

        Navigator.of(context).pop();
      },
      child: Text(
        '确定',
        style: TextStyle(
            color: MXTheme.of(context).brandPrimaryColor,
            fontSize: MXTheme.of(context).fontBodyMedium!.size),
      ),
    ));

    return Container(
      padding: padding,
      margin: EdgeInsets.symmetric(vertical: MXTheme.of(context).space16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children),
    );
  }

  DateTime _getConfirmDate() {
    DateTime date;

    DateTime now = DateTime.now();

    switch (widget.datePickerParams.datePickerFormatType) {
      case DatePickerFormatType.MM_DD:
        date = DateTime(
          now.year,
          widget.datePickerModel.monthIndex + 1,
          widget.datePickerModel.dayIndex + 1,
        );
        break;
      case DatePickerFormatType.YYYY_MM:
        date = DateTime(
            widget.datePickerModel.yearIndex +
                widget.datePickerModel.startDate[0],
            widget.datePickerModel.monthIndex + 1);

        break;
      case DatePickerFormatType.YYYY_MM_DD:
        date = DateTime(
          widget.datePickerModel.yearIndex +
              widget.datePickerModel.startDate[0],
          widget.datePickerModel.monthIndex + 1,
          widget.datePickerModel.dayIndex + 1,
        );
        break;
      case DatePickerFormatType.YYYY_MM_DD_WW:
        date = DateTime(
          widget.datePickerModel.yearIndex +
              widget.datePickerModel.startDate[0],
          widget.datePickerModel.monthIndex + 1,
          widget.datePickerModel.dayIndex + 1,
        );
        break;
      case DatePickerFormatType.YYYY_MM_DD_HH_mm_ss:
        date = DateTime(
            widget.datePickerModel.yearIndex +
                widget.datePickerModel.startDate[0],
            widget.datePickerModel.monthIndex + 1,
            widget.datePickerModel.dayIndex + 1,
            widget.datePickerModel
                .scrollContollers[DatePickerListUnitEnum.hour]!.selectedItem,
            widget.datePickerModel
                .scrollContollers[DatePickerListUnitEnum.minute]!.selectedItem,
            widget.datePickerModel
                .scrollContollers[DatePickerListUnitEnum.second]!.selectedItem);
        break;
    }

    return date;
  }

  Widget _buildListContainer(BuildContext context, double width) {
    DatePickerModel datePickerModel = widget.datePickerModel;

    return Container(
      width: width,
      height: pickerHeight,
      padding: EdgeInsets.only(
          left: MXTheme.of(context).space16,
          right: MXTheme.of(context).space16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          datePickerModel.useYear
              ? widget.datePickerParams.datePickerFormatType ==
                      DatePickerFormatType.YYYY_MM_DD_HH_mm_ss
                  ? SizedBox(
                      width: 80,
                      child: Expanded(
                          child: _buildList(DatePickerListUnitEnum.year)))
                  : Expanded(child: _buildList(DatePickerListUnitEnum.year))
              : Container(),
          datePickerModel.useMonth
              ? Expanded(child: _buildList(DatePickerListUnitEnum.month))
              : Container(),
          datePickerModel.useDay
              ? Expanded(child: _buildList(DatePickerListUnitEnum.day))
              : Container(),
          datePickerModel.useWeek
              ? Expanded(child: _buildList(DatePickerListUnitEnum.week))
              : Container(),
          datePickerModel.useHour
              ? Expanded(child: _buildList(DatePickerListUnitEnum.hour))
              : Container(),
          datePickerModel.useMinute
              ? Expanded(child: _buildList(DatePickerListUnitEnum.minute))
              : Container(),
          datePickerModel.useSecond
              ? Expanded(child: _buildList(DatePickerListUnitEnum.second))
              : Container(),
        ],
      ),
    );
  }

  Widget _buildList(DatePickerListUnitEnum unitEnum) {
    DatePickerModel datePickerModel = widget.datePickerModel;
    return ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: ListWheelScrollView.useDelegate(
            itemExtent: pickerHeight / widget.datePickerParams.pickerColumnNum,
            // 如果是周则禁用滑动
            physics: unitEnum == DatePickerListUnitEnum.week
                ? const NeverScrollableScrollPhysics()
                : const FixedExtentScrollPhysics(),
            controller: datePickerModel.scrollContollers[unitEnum],
            onSelectedItemChanged: (value) {
              if (unitEnum == DatePickerListUnitEnum.year ||
                  unitEnum == DatePickerListUnitEnum.month ||
                  unitEnum == DatePickerListUnitEnum.day) {
                setState(() {
                  switch (unitEnum) {
                    case DatePickerListUnitEnum.year:
                      datePickerModel.refreshMonthOnControllerChange();
                      datePickerModel.refreshDayOnControllerChange();
                      if (datePickerModel.useWeek) {
                        datePickerModel.refresWeekOnControllerChange();
                      }
                      break;
                    case DatePickerListUnitEnum.month:
                      datePickerModel.refreshDayOnControllerChange();
                      if (datePickerModel.useWeek) {
                        datePickerModel.refresWeekOnControllerChange();
                      }
                      break;
                    case DatePickerListUnitEnum.day:
                      if (datePickerModel.useWeek) {
                        datePickerModel.refresWeekOnControllerChange();
                      }
                      break;
                  }

                  pickerHeight =
                      pickerHeight - Random().nextDouble() / 100000000;
                });
              }
            },
            childDelegate: ListWheelChildBuilderDelegate(
                childCount: datePickerModel.dateListMap[unitEnum]!.length,
                builder: (context, index) {
                  var height =
                      pickerHeight / widget.datePickerParams.pickerColumnNum;
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: height,
                      child: MXPickerSelectItem(
                          index: index,
                          fixedExtentScrollController:
                              datePickerModel.scrollContollers[unitEnum]!,
                          selectColumnCount:
                              widget.datePickerParams.pickerColumnNum,
                          text:

                              // 单独处理周
                              unitEnum == DatePickerListUnitEnum.week
                                  ? '${datePickerModel.dateUnitMap[unitEnum]}${datePickerModel.weekMap[datePickerModel.dateListMap[unitEnum]![index]]}'
                                  : '${datePickerModel.dateListMap[unitEnum]![index]}${datePickerModel.dateUnitMap[unitEnum]}',
                          itemHeight: height));
                })));
  }

  BoxDecoration _buildTopMaskLayer(BuildContext context) {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          MXTheme.of(context).whiteColor,
          MXTheme.of(context).whiteColor.withOpacity(0)
        ]));
  }

  BoxDecoration _buildBottomMaskLayer(BuildContext context) {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
          MXTheme.of(context).whiteColor,
          MXTheme.of(context).whiteColor.withOpacity(0)
        ]));
  }

  Widget _buildPickerContainer(BuildContext context, Widget child) {
    double radius = MXTheme.of(context).radiusLarge;
    return Container(
      decoration: BoxDecoration(
          color: widget.datePickerParams.backgroundColor ??
              MXTheme.of(context).whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          )),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.datePickerParams.useSaftArea) {
      return _buildPickerContainer(
          context, SafeArea(child: _buildPickerBody(context)));
    } else {
      return _buildPickerContainer(context, _buildPickerBody(context));
    }
  }
}
