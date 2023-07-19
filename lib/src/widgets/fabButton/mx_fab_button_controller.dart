import 'package:flutter/widgets.dart';
import 'package:mx_widget/src/widgets/fabButton/mx_fab_button.dart';
import 'package:mx_widget/src/widgets/fabButton/mx_fab_button_model.dart';

/// ----------------------------------------------------------------悬浮按钮控制器
/// 用来显示及隐藏当前页面的悬浮按钮
/// [context] 上下文
/// [state] 类型overlayState
/// [model] button按钮的模型层
/// [immediatelyRender] 是否立即渲染，注意⚠️如果是在initState方法中使用会报错。

class MXFabButtonController {
  MXFabButtonController({
    this.state,
    this.context,
    required this.model,
    this.immediatelyRender = false,
  }) : assert(() {
          if (state == null && context == null) {
            throw FlutterError('state或者content必须传入一个');
          }

          return true;
        }()) {
    if (immediatelyRender) {
      show();
    }
  }

  /// [state] 类型overlayState
  final OverlayState? state;

  /// [context] 上下文
  final BuildContext? context;

  /// [model] button按钮的模型层
  final MXFabButtonModel model;

  /// [immediatelyRender] 是否立即渲染，注意⚠️如果是在initState方法中使用会报错。
  final bool immediatelyRender;

  bool isInit = false;

  static OverlayEntry? _overlayEntry;
  static OverlayState? _overlayState;

  void _render() {
    _initOverLayState();
  }

  void _renderEntry() {
    _overlayEntry ??= OverlayEntry(builder: ((BuildContext context) {
      return Stack(
        children: [_buildFabButton()],
      );
    }));

    _overlayState?.insert(_overlayEntry!);
  }

  Widget _buildFabButton() {
    return MXFabButton(model: model);
  }

  void _initOverLayState() {
    if (state != null) {
      _overlayState = state;
    } else if (context != null) {
      _overlayState = Overlay.of(context!);
    }

    isInit = true;
  }

  void show() {
    if (!isInit) {
      _render();
    }

    _renderEntry();
  }

  void hidden() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
    }
  }
}
