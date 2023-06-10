import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/widgets/picker/mx_picker_select_item.dart';
import 'package:mx_widget/src/widgets/picker/optionsPicker/model/options_picker_model.dart';

const double titleHeight = 57;

///------------------------------------------------------------optionsPicker组件
///结构与时间选择器差别不大，存在冗余代码，可以优化。

class MXOptionsPicker extends StatefulWidget {
  const MXOptionsPicker(
      {super.key,
      required this.optionsPickerParams,
      required this.optionsPickerModel});

  final OptionsPickerParams optionsPickerParams;

  final OptionsPickerModel optionsPickerModel;

  @override
  State<MXOptionsPicker> createState() => _MXOptionsPickerState();
}

class _MXOptionsPickerState extends State<MXOptionsPicker> {
  late double pickerHeight;

  @override
  void initState() {
    pickerHeight = widget.optionsPickerParams.pickerHeight;
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
    return widget.optionsPickerParams.pickerSelectContainer ??
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
        widget.optionsPickerParams.onCancel!.call();
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
      widget.optionsPickerParams.text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: MXTheme.of(context).fontUsePrimaryColor,
          fontSize: MXTheme.of(context).fontBodyLarge!.size),
    ));

    children.add(GestureDetector(
      onTap: () {
        widget.optionsPickerParams.onConfirm?.call(_getConfirmValue());

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
    OptionsPickerModel optionsPickerModel = widget.optionsPickerModel;
    List<dynamic> valueList = [];
    String propertyValueString =
        optionsPickerModel.optionProperty![OptionsPropertyEnum.value]!;

    for (var i = 0; i < optionsPickerModel.valueIndexs.length; i++) {
      dynamic value = optionsPickerModel.valueIndexs[i];

      List<Map> optionsItem = optionsPickerModel.options[i];

      valueList.add(optionsItem[value][propertyValueString]);
    }

    return valueList;
  }

  Widget _buildListContainer(BuildContext context, double width) {
    OptionsPickerModel optionsPickerModel = widget.optionsPickerModel;

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
        i < widget.optionsPickerModel.scrollContollers.length;
        i++) {
      list.add(Expanded(child: _buildListItem(i)));
    }

    return list;
  }

  Widget _buildListItem(int index) {
    OptionsPickerModel optionsPickerModel = widget.optionsPickerModel;
    return ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: ListWheelScrollView.useDelegate(
            itemExtent:
                pickerHeight / widget.optionsPickerParams.pickerColumnNum,
            // 如果是周则禁用滑动
            physics: const FixedExtentScrollPhysics(),
            controller: optionsPickerModel.scrollContollers[index],
            onSelectedItemChanged: (value) {
              widget.optionsPickerModel.valueIndexs[index] = value;
            },
            childDelegate: ListWheelChildBuilderDelegate(
                childCount: optionsPickerModel.options[index].length,
                builder: (context, itemIndex) {
                  var height =
                      pickerHeight / widget.optionsPickerParams.pickerColumnNum;
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: height,
                      child: MXPickerSelectItem(
                          index: itemIndex,
                          fixedExtentScrollController:
                              optionsPickerModel.scrollContollers[index],
                          selectColumnCount:
                              widget.optionsPickerParams.pickerColumnNum,
                          text: _buildOptionsItemText(
                              optionsPickerModel.options[index], itemIndex),
                          itemHeight: height));
                })));
  }

  String _buildOptionsItemText(List<Map> optionsItem, int index) {
    String label =
        widget.optionsPickerModel.optionProperty![OptionsPropertyEnum.label]!;

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
          color: widget.optionsPickerParams.backgroundColor ??
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
    if (widget.optionsPickerParams.useSaftArea) {
      return _buildPickerContainer(
          context, SafeArea(child: _buildPickerBody(context)));
    } else {
      return _buildPickerContainer(context, _buildPickerBody(context));
    }
  }
}
