import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

/// ---------------------------------------------------------------------表单控件
/// 用以收集、校验和提交数据，一般由输入框、单选框、复选框、选择器等控件组成。

class MXForm extends StatefulWidget {
  const MXForm({
    super.key,
    this.padding = 16,
    this.labelWidth = 80,
    required this.formList,
    required this.controller,
    this.type = MXFormTypeEnum.common,
    this.align = MXFormAlign.horizontal,
  });

  final double padding;

  final MXFormAlign align;

  final List<MXFormItemModel> formList;

  final MXFormController controller;

  final double labelWidth;

  final MXFormTypeEnum type;

  @override
  State<MXForm> createState() => MXFormState();
}

class MXFormState extends State<MXForm> {
  Map<String, MXFormItemModel> modelMap = {};

  @override
  void initState() {
    _assemblerMap();
    widget.controller.setModelMap(modelMap);
    widget.controller.setState(this);

    super.initState();
  }

  void _assemblerMap() {
    for (var element in widget.formList) {
      modelMap[element.props] = element;
    }
  }

  List<Widget> _getFormList() {
    List<Widget> children = [];

    int length = widget.formList.length;

    for (var i = 0; i < length; i++) {
      var model = widget.formList[i];

      bool errorFlag = widget.controller.errorMap.containsKey(model.props);

      children.add(MXFormItem(
        model: model,
        isError: errorFlag,
        align: widget.align,
        useBottomBorder: i != length - 1,
        labelWidth: widget.labelWidth,
        disabled: widget.controller.disabled,
      ));

      model.setFormController(widget.controller);
    }

    return children;
  }

  void updateLayout() {
    setState(() {});
  }

  Widget _buildBody() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: _getFormList());
  }

  BoxDecoration _buildFormWrapDecoration() {
    Color backgroundColor = MXTheme.of(context).whiteColor;

    switch (widget.type) {
      case MXFormTypeEnum.card:
        return BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(MXTheme.of(context).radiusMedium)),
            color: backgroundColor);
      case MXFormTypeEnum.common:
        return BoxDecoration(color: backgroundColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _buildBody();

    return Container(
      decoration: _buildFormWrapDecoration(),
      padding: EdgeInsets.symmetric(horizontal: widget.padding),
      child: child,
    );
  }
}
