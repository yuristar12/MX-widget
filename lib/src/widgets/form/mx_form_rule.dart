import 'package:mx_widget/src/widgets/form/mx_form_rule_result.dart';

typedef MXFormRuleValidator = MXFormRuleResult Function(dynamic value);

class MXFormRule {
  MXFormRule({
    this.message = '请输入正确数据',
    this.validator,
    required this.required,
  });

  final bool required;

  final String? message;

  final MXFormRuleValidator? validator;
}
