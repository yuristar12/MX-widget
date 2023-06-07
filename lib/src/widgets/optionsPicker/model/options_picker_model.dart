import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/config/global_enum.dart';

///-----------------------------------------------------optionsPicker组件数据模型
/// [options] 选项列表 例如[ [{"label":'选项一',"value":'1'},{"label":'选项二',"value":'2'},{"label":'选项三',"value":'3'},{"label":'选项四',"value":'4'}]];
/// [initialValue] 默认值数组 例如上方options的value ['3','4']
/// [optionProperty] options的单个optionsItem的Map中对应展示与选中的属性 默认为
// {
//       OptionsPropertyEnum.label: 'label',
//       OptionsPropertyEnum.value: "value"
//     };

class OptionsPickerModel {
  late List<List<Map>> options;
  late List<dynamic>? initialValue;
  late Map<OptionsPropertyEnum, String>? optionProperty;

  List<dynamic> valueIndexs = [];

  late List<FixedExtentScrollController> scrollContollers;

  OptionsPickerModel({
    this.initialValue,
    this.optionProperty,
    required this.options,
  }) {
    //  构造函数执行顺序
    initialParams();

    initialControllers();

    registerListener();
  }

// 初始化value值
  void initialParams() {
    optionProperty ??= {
      OptionsPropertyEnum.label: 'label',
      OptionsPropertyEnum.value: "value"
    };
    initialValue ??= [];
    for (int i = 0; i < options.length; i++) {
      List<Map> optionsItem = options[i];
// 如果存在默认值则需要到对应的下标
      if (i < initialValue!.length) {
        for (int j = 0; j < optionsItem.length; j++) {
          Map item = optionsItem[j];
          String property = optionProperty![OptionsPropertyEnum.value]!;
          if (item[property] == initialValue![i]) {
            valueIndexs.add(j);
            break;
          }
        }
      }
    }
    int subs = options.length - valueIndexs.length;
//  目的是如果没有初始化的值则自动选择第一个
    for (int i = 0; i < subs; i++) {
      valueIndexs.add(0);
    }
  }

  // 初始化控制器
  initialControllers() {
    scrollContollers = [];

    for (int i = 0; i < options.length; i++) {
      scrollContollers
          .add(FixedExtentScrollController(initialItem: valueIndexs[i]));
    }
  }

  // 添加控制器监听滚动的选择
  void registerListener() {
    for (int i = 0; i < scrollContollers.length; i++) {
      FixedExtentScrollController scrollControllerItem = scrollContollers[i];

      scrollControllerItem.addListener(() {
        valueIndexs[i] = scrollControllerItem.selectedItem;
      });
    }
  }
}
