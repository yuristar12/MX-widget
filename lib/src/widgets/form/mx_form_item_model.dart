import 'package:mx_widget/mx_widget.dart';

class MXFormItemModel {
  MXFormItemModel({
    required this.props,
    this.help,
    this.require = false,
    this.initValue,
    required this.label,
    required this.builder,
    this.contentAlign = MXFormPositionAlign.end,
    this.labelAlign = MXFormPositionAlign.start,
  }) {
    if (initValue != null) {
      value = initValue;
    }
  }

  final dynamic initValue;

  final String label;

  final String props;

  final String? help;

  final bool require;

  final MXFormPositionAlign contentAlign;

  final MXFormPositionAlign labelAlign;

  final MXFormItemBuilder builder;

  String? errorMessage;

  dynamic _value;

  MXFormController? formController;

  set value(dynamic value) {
    if (_value == value) return;

    _value = value;

    // 调用校验的方法
    if (formController != null) {
      formController!.onValidatorByProps(props);
    }
  }

  dynamic get value {
    return _value;
  }

  /// 设置控制器
  setFormController(MXFormController controller) {
    formController = controller;
  }
}
