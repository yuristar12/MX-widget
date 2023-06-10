import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/widgets/picker/multipleOptionsPicker/model/multiple_options_model.dart';
import 'package:mx_widget/src/widgets/picker/mx_picker_select_item.dart';

const double titleHeight = 57;

///----------------------------------------------MultipleoptionsPicker多级联动组件
///结构与时间选择器差别不大，存在冗余代码，可以优化。

class MXMultipleOptionsPicker extends StatefulWidget {
  const MXMultipleOptionsPicker(
      {super.key,
      required this.multiplePickerParams,
      required this.multipleOptionsModel});

  final MultiplePickerParams multiplePickerParams;

  final MultipleOptionsModel multipleOptionsModel;

  @override
  State<MXMultipleOptionsPicker> createState() =>
      _MXMultipleOptionsPickerState();
}

class _MXMultipleOptionsPickerState extends State<MXMultipleOptionsPicker> {
  late double pickerHeight;

  @override
  void initState() {
    pickerHeight = widget.multiplePickerParams.pickerHeight;
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
    return widget.multiplePickerParams.pickerSelectContainer ??
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
        widget.multiplePickerParams.onCancel!.call();
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
      widget.multiplePickerParams.text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: MXTheme.of(context).fontUsePrimaryColor,
          fontSize: MXTheme.of(context).fontBodyLarge!.size),
    ));

    children.add(GestureDetector(
      onTap: () {
        _getConfirmValue();
        widget.multiplePickerParams.onConfirm?.call(_getConfirmValue());

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

  List<dynamic> _getConfirmValue() {
    List<dynamic> indexList = [];
    List<dynamic> values = [];

    dynamic listItem;

    MultipleOptionsModel multipleOptionsModel = widget.multipleOptionsModel;

    String valueStr = multipleOptionsModel
        .optionProperty![MultipleOptionsPropertyEnum.value]!;
    String children = multipleOptionsModel
        .optionProperty![MultipleOptionsPropertyEnum.children]!;

    for (var i = 0; i < multipleOptionsModel.scrollContollers.length; i++) {
      FixedExtentScrollController fixedExtentScrollController =
          multipleOptionsModel.scrollContollers[i];

      indexList.add(fixedExtentScrollController.selectedItem);
    }

    for (var i = 0; i < indexList.length; i++) {
      int listIndex = indexList[i];

      if (i == 0) {
        listItem = multipleOptionsModel.options[listIndex];
        values.add(listItem[valueStr]);
        listItem = listItem[children];
      } else {
        values.add(listItem[listIndex][valueStr]);
        listItem = listItem[listIndex][children];
      }
    }

    return values;
  }

  Widget _buildListContainer(BuildContext context, double width) {
    return Container(
      width: width,
      height: pickerHeight,
      padding: EdgeInsets.only(
          left: MXTheme.of(context).space16,
          right: MXTheme.of(context).space16),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildList()),
    );
  }

  List<Widget> _buildList() {
    List<Widget> list = [];

    for (int i = 0;
        i < widget.multipleOptionsModel.scrollContollers.length;
        i++) {
      list.add(Expanded(child: _buildListItem(i)));
    }

    return list;
  }

  Widget _buildListItem(int index) {
    MultipleOptionsModel multipleOptionsModel = widget.multipleOptionsModel;
    return ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: ListWheelScrollView.useDelegate(
            itemExtent:
                pickerHeight / widget.multiplePickerParams.pickerColumnNum,
            physics: const FixedExtentScrollPhysics(),
            controller: multipleOptionsModel.scrollContollers[index],
            onSelectedItemChanged: (value) {
              multipleOptionsModel.onSelectValueChange(index, value);

              setState(() {
                pickerHeight = pickerHeight - Random().nextDouble() / 100000000;
              });
            },
            childDelegate: ListWheelChildBuilderDelegate(
                childCount: multipleOptionsModel.presentDataList[index].length,
                builder: (context, itemIndex) {
                  var height = pickerHeight /
                      widget.multiplePickerParams.pickerColumnNum;
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: height,
                      child: MXPickerSelectItem(
                          index: itemIndex,
                          fixedExtentScrollController:
                              multipleOptionsModel.scrollContollers[index],
                          selectColumnCount:
                              widget.multiplePickerParams.pickerColumnNum,
                          text: _buildOptionsItemText(
                              multipleOptionsModel.presentDataList[index],
                              itemIndex),
                          itemHeight: height));
                })));
  }

  String _buildOptionsItemText(List<Map> optionsItem, int index) {
    String label = widget.multipleOptionsModel
        .optionProperty![MultipleOptionsPropertyEnum.label]!;

    return optionsItem[index][label].toString();
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
          color: widget.multiplePickerParams.backgroundColor ??
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
    if (widget.multiplePickerParams.useSaftArea) {
      return _buildPickerContainer(
          context, SafeArea(child: _buildPickerBody(context)));
    } else {
      return _buildPickerContainer(context, _buildPickerBody(context));
    }
  }
}
