import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/cascader/mx_cascader.dart';
import 'package:mx_widget/src/widgets/cascader/mx_cascader_anchor_item.dart';

import '../../../mx_widget.dart';

/// -----------------------------------------------------------Cascader 级联选择器
/// 用于多层级数据选择，主要为树形结构，可展示更多的数据。
/// [options] 树形结构的数据
/// [onChange]  值发生变更时触发
/// [onClose] 关闭抽屉时触发
/// [onPick] 单个选项被选中时触发
class MXCascaderController {
  MXCascaderController({
    this.onChange,
    this.onPick,
    this.onClose,
    required this.options,
  });

  /// [options] 树形结构的数据
  final List<MXCascaderOptions> options;

  /// [onChange]  值发生变更时触发
  final MXCascaderOnchange? onChange;

  /// [onPick] 单个选项被选中时触发

  final MXCascaderOnpick? onPick;

  /// [onClose] 关闭抽屉时触发
  final VoidCallback? onClose;

// 步骤的控制器
  static MXStepsController? _stepsController;

// cascader 的视图层
  static MXCascaderState? cascaderState;

// 记入需要渲染的列表
  static Map<int, List<MXCascaderOptions>>? _values;

  // 记入每次被点击的option
  static List<MXCascaderOptions> _optionList = [];

// 层级
  static int _activityIndex = 0;

// 缓存context
  static BuildContext? _context;

// 记录被选中的id
  String? id;

// 是否是步骤条选中

  String? _isStepItemClickId;

  static void _buildDefaultStepsController() {
    _stepsController = MXStepsController(stepsItems: [
      MXStepsItemModel(
        title: '选择选项',
        builder: (isActivity) {
          return MXCascaderAnchorItem(
              isLast: true,
              id: "0",
              onTap: (String id) {},
              title: "选择选项",
              isActivity: true);
        },
      ),
    ]);
  }

  Widget _buildCascader() {
    return MXCascader(
      controller: this,
      getMXCascaderState: (state) {
        cascaderState = state;
      },
    );
  }

  MXStepsController get stepsController {
    return _stepsController!;
  }

  int get activityIndex {
    return _activityIndex;
  }

  Map<int, List<MXCascaderOptions>>? get values {
    return _values;
  }

  set values(value) {
    values = value;
  }

  void toHiddenCascader() {
    if (_context != null) {
      Navigator.pop(_context!);
    }
  }

  void _beforeRender(BuildContext context) {
    _initParams();
    _context = context;
    _buildDefaultStepsController();
    _values?[0] = options;
  }

  void _initParams() {
    _values = {};
    _optionList = [];
    _activityIndex = 0;
    id = null;
    _isStepItemClickId = null;
  }

  void toRenderCascader(
      {required BuildContext context, String title = '地址选择', String? id}) {
    _beforeRender(context);

    // 如果传入了数据则需要回显
    // 先准备需要回显的数据
    if (id != null) {
      _reShowValues(id);
      this.id = id;
    }

    MXPopUp.MXpopUpByBottom(
      context,
      leftText: '',
      rightText: '取消',
      title: title,
      onClose: onClose,
      child: _buildCascader(),
      onRightCallback: () {
        toHiddenCascader();
      },
    );
  }

  void _addValue(MXCascaderOptions option) {
    if (option.children != null) {
      values?[_activityIndex] = option.children!;
    } else {
      _activityIndex -= 1;
    }
  }

  void onCellTap(MXCascaderOptions option) {
    if (option.value == id && option.children != null) {
      if (_activityIndex < _optionList.length) {
        _activityIndex += 1;
        if (_activityIndex <= _optionList.length - 1) {
          id = _optionList[_activityIndex].value;
          _isStepItemClickId = id;
        } else {
          _isStepItemClickId = null;
        }
        onPick?.call(option);
        updateLayout();
        return;
      }
      return;
    }

    id = option.value;
    _isStepItemClickId = null;

    if (option.children != null) {
      onPick?.call(option);
      _addOption(option);
      _addValue(option);
      updateLayout();
    } else {
      // 如果是最后一个则默认关闭
      toHiddenCascader();
      onChange?.call(id!, option);
    }
  }

  void _addOption(MXCascaderOptions option) {
    int flag = _optionList.indexWhere((element) {
      return element.value == option.value;
    });

    if (flag == -1) {
      if (_optionList.length <= _activityIndex) {
        _optionList.add(option);
        _activityIndex += 1;
      } else {
        // 需要判断下一个的父级是否等于option
        // 如果不是需要将之后的节点全部清除
        bool isCurrent = _checkNextNodeFatherIsCurrent(option);
        _optionList[_activityIndex] = option;
        if (!isCurrent) {
          _optionList.removeRange(_activityIndex + 1, _optionList.length);
        } else {
          _activityIndex += 1;
        }
      }
    }
  }

  bool _checkNextNodeFatherIsCurrent(MXCascaderOptions option) {
    int nextIndex = _activityIndex + 1;

    if (nextIndex <= _optionList.length - 1) {
      var node = _optionList[nextIndex];

      Map<String, dynamic>? nodes = _getReShowNode(options, node.value);

      if (nodes != null) {
        if (nodes['fatherNode'].value == option.value) {
          return true;
        }
        return false;
      }
    }
    return true;
  }

  void _updateStepsController() {
    int length = _optionList.length;
    if (length > 0) {
      List<MXStepsItemModel> stepsItems = [];

      for (var i = 0; i < length; i++) {
        MXCascaderOptions option = _optionList[i];
        bool hasChildren = option.children != null;
        stepsItems.add(_assemberAnchorItem(
            option,
            (_isStepItemClickId == option.value) ||
                (_isStepItemClickId == null &&
                    option.value == id &&
                    !hasChildren),
            i == length - 1));
        if (hasChildren && i == length - 1) {
          stepsItems.add(_assemberDefaultAnchorItem());
        }
      }
      _stepsController =
          MXStepsController(stepsItems: stepsItems, initValue: _activityIndex);
    }
  }

  void updateLayout() {
    // 同时更新steps的controller
    _updateStepsController();
    cascaderState?.onParamsUpdate();
  }

  MXStepsItemModel _assemberAnchorItem(
      MXCascaderOptions option, bool isActivity, bool isLast) {
    return MXStepsItemModel(
      title: option.label,
      builder: (innerActivity) {
        return MXCascaderAnchorItem(
            id: option.value,
            isLast: isLast,
            onTap: (String id) {
              _onStepItemTap(id);
            },
            title: option.label,
            isActivity: isActivity);
      },
    );
  }

  MXStepsItemModel _assemberDefaultAnchorItem() {
    return MXStepsItemModel(
      title: '选择选项',
      builder: (isActivity) {
        return MXCascaderAnchorItem(
            id: "0",
            onTap: (String id) {
              _activityIndex = _optionList.length;
              _isStepItemClickId = null;
              updateLayout();
            },
            title: "选择选项",
            isLast: true,
            isActivity: _isStepItemClickId == null);
      },
    );
  }

  void _onStepItemTap(String id) {
    final index = _optionList.indexWhere((element) => element.value == id);

    if (index > -1) {
      _activityIndex = index;

      this.id = _optionList[index].value;

      _isStepItemClickId = this.id;
      updateLayout();
    }
  }

  Map<String, dynamic>? _getReShowNode(List<MXCascaderOptions> list, String id,
      {MXCascaderOptions? fatherNode}) {
    for (var i = 0; i < list.length; i++) {
      var item = list[i];
      if (item.value == id) {
        return {
          "currentNode": item,
          "fatherNode": fatherNode,
        };
      }

      if (item.children != null) {
        var value = _getReShowNode(item.children!, id, fatherNode: item);
        if (value != null) {
          return value;
        }
      }
    }
    return null;
  }

  void _reShowValues(String id) {
    List<Map> values = [];
    Map<String, dynamic>? nodes = _getReShowNode(options, id);
    bool flag = true;
    if (nodes != null) {
      values.add(nodes);
      while (flag) {
        nodes = _getReShowNode(options, nodes!['fatherNode'].value);
        if (nodes!['fatherNode'] == null) {
          flag = false;
        }
        values.add(nodes);
      }
    }
    values = values.reversed.toList();

    for (var e in values) {
      MXCascaderOptions option = e['currentNode'];
      _addOption(option);
      _addValue(option);
    }
    _updateStepsController();
  }
}
