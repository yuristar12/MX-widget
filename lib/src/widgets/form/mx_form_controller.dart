import 'package:mx_widget/mx_widget.dart';

class MXFormController {
  MXFormController({this.rules});

  Map<String, List<MXFormRule>>? rules;

  MXFormState? state;

  Map<String, bool> errorMap = {};

  Map<String, MXFormItemModel>? modelMap;

  static bool _disabled = false;

  set disabled(bool value) {
    if (_disabled == value) return;
    _disabled = value;
    if (state != null) {
      state?.updateLayout();
    }
  }

  bool get disabled {
    return _disabled;
  }

  setState(MXFormState state) {
    this.state = state;
  }

  setModelMap(Map<String, MXFormItemModel> modelMap) {
    this.modelMap = modelMap;
  }

  /// 清空表单的值

  onReset({bool isCleanValidator = false}) {
    if (modelMap != null && state != null) {
      modelMap!.forEach((key, value) {
        modelMap![key]!.value = null;
      });
    }

    if (isCleanValidator) {
      onCleanAllValidator();
      return;
    }
    state?.updateLayout();
  }

  bool _checkRulesHasProps(String props) {
    if (rules != null) {
      return rules!.containsKey(props);
    }

    return false;
  }

  bool _checkValueRunTime(dynamic value) {
    if (value == null) return false;
    if (value.runtimeType == bool) {
      return value;
    } else if (value.runtimeType == List) {
      return value.isNotEmpty;
    } else if (value.runtimeType == Map) {
      return value.isNotEmpty;
    } else if (value.runtimeType == num) {
      return value > 0;
    }

    return true;
  }

  /// 校验整个表单

  onValidatorByAll() {
    if (modelMap != null) {
      modelMap?.forEach((key, value) {
        onValidatorByProps(key, isAll: true);
      });
      state?.updateLayout();
    }
  }

  /// 获取表单的值

  Map<String, dynamic> onGetFormValue() {
    Map<String, dynamic> value = {};

    if (modelMap != null) {
      modelMap?.forEach((key, mapValue) {
        value[key] = mapValue.value;
      });
    }

    return value;
  }

  /// 校验表单的某一项
  /// [props] 对应 [MXFormItemModel] 中的 [props]

  bool onValidatorByProps(String props, {bool isAll = false}) {
    if (_checkRulesHasProps(props)) {
      var ruleItem = rules![props];

      if (ruleItem != null) {
        int length = ruleItem.length;

        // true 代表验证通过

        MXFormRuleResult result = MXFormRuleResult(result: true);

        for (var i = 0; i < length; i++) {
          var item = ruleItem[i];

          if (item.required) {
            var value = modelMap![props]!.value;
            if (item.validator != null) {
              result = item.validator!.call(value);
            } else {
              result.result = _checkValueRunTime(value);
            }
          }

          if (!result.result) {
            // 这里有限获取自定义验证方法返回的message;
            if (result.message != null) {
              modelMap![props]!.errorMessage = result.message;
            } else {
              if (item.message != null) {
                modelMap![props]!.errorMessage = item.message;
              }
            }
            // 添加至纪录错误的map中
            errorMap[props] = true;
            break;
          }
        }
        // 如果验证都通过了需要从纪录错误的map中删除
        if (result.result) {
          if (errorMap.containsKey(props)) {
            errorMap.remove(props);
          }
        }

        if (!isAll) {
          state?.updateLayout();
        }
      }

      return true;
    }
    return true;
  }

  /// 清空表单的校验

  void onCleanAllValidator() {
    errorMap.clear();
    state?.updateLayout();
  }

  /// 清空表单某一项的校验
  /// [props] 对应 [MXFormItemModel] 中的 [props]
  void onCleanValidatorByProps(String props) {
    if (errorMap.containsKey(props)) {
      errorMap.remove(props);

      state?.updateLayout();
    }
  }
}
