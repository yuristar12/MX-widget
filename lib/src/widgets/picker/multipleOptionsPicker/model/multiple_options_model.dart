import 'package:flutter/cupertino.dart';

import '../../../../config/global_enum.dart';

class MultipleOptionsModel {
  late List<Map> options;

  late List<dynamic>? initialValue;

  late Map<MultipleOptionsPropertyEnum, String>? optionProperty;

  /// 记录选中的下标
  List<dynamic> valueIndexs = [];

  late List<FixedExtentScrollController> scrollContollers;

  late List presentDataList = [];

  MultipleOptionsModel({
    this.initialValue,
    this.optionProperty,
    required this.options,
  }) {
    //  构造函数执行顺序
    initialParams();

    // 初始化选择的值
    initValue();

    // 初始化controller列表
    initController();
  }

  initialParams() {
    optionProperty ??= {
      MultipleOptionsPropertyEnum.label: 'label',
      MultipleOptionsPropertyEnum.value: 'value',
      MultipleOptionsPropertyEnum.children: 'children',
    };
  }

  initValue() {
    if (initialValue != null) {
      for (var i = 0; i < initialValue!.length; i++) {
        if (i == 0) {
          int index = findDataByValue(options, initialValue![i]);
          if (index >= 0) {
            valueIndexs.add(index);
            presentDataList.add(options);
          } else {
            index = 0;
            valueIndexs.add(0);
            presentDataList.add(options);
            // 传入了数据但是并没有找到则代表之后的数据也查询不了
            break;
          }
        } else {
          Map data = presentDataList[i - 1][valueIndexs[i - 1]];
          dynamic children =
              optionProperty![MultipleOptionsPropertyEnum.children];
          if (data[children] != null) {
            int index = findDataByValue(data[children], initialValue![i]);
            if (index >= 0) {
              valueIndexs.add(index);
              presentDataList.add(data[children]);
            } else {
              index = 0;
              valueIndexs.add(0);
              presentDataList.add(data[children]);
              // 传入了数据但是并没有找到则代表之后的数据也查询不了
              break;
            }
          }
        }
      }

      findDataNext(presentDataList[presentDataList.length - 1]
          [valueIndexs[valueIndexs.length - 1]]);
    } else {
      // 默认全部选择第一个
      valueIndexs.add(0);
      presentDataList.add(options);
      findDataNext(presentDataList[presentDataList.length - 1]
          [valueIndexs[valueIndexs.length - 1]]);
    }
  }

  int findDataByValue(List data, dynamic value) {
    dynamic valueStr = optionProperty![MultipleOptionsPropertyEnum.value];

    int index = -1;

    for (var i = 0; i < data.length; i++) {
      Map item = data[i];
      if (item[valueStr] == value) {
        index = i;
        break;
      }
    }

    return index;
  }

// 递归查找至最后的层级
  findDataNext(Map data) {
    dynamic children = optionProperty![MultipleOptionsPropertyEnum.children];
    if (data[children] != null) {
      valueIndexs.add(0);
      presentDataList.add(data[children]);
      findDataNext(presentDataList[presentDataList.length - 1]
          [valueIndexs[valueIndexs.length - 1]]);
    }
  }

  void initController() {
    scrollContollers = [];

    for (var i = 0; i < valueIndexs.length; i++) {
      scrollContollers
          .add(FixedExtentScrollController(initialItem: valueIndexs[i]));
    }
  }

//
  void registerListener() {
    for (var i = 0; i < valueIndexs.length; i++) {
      FixedExtentScrollController scrollControllerItem = scrollContollers[i];
      scrollControllerItem.addListener(() {
        valueIndexs[i] = scrollControllerItem.selectedItem;
      });
    }
  }

  void onSelectValueChange(int index, int selectIndex) {
    int length = valueIndexs.length;
    valueIndexs.removeRange(index + 1, length);

    presentDataList.removeRange(index + 1, length);

    scrollContollers.removeRange(index + 1, length);

    findDataNext(presentDataList[presentDataList.length - 1][selectIndex]);

    initController();
  }
}
