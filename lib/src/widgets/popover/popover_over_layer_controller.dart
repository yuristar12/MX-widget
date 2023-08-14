import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/popover/mx_popover_model.dart';
import 'package:mx_widget/src/widgets/popover/mx_popover_wrap.dart';
import 'package:mx_widget/src/widgets/popover/popover_position.dart';

class PopoverOverLayerController {
  PopoverOverLayerController(
      {required this.context,
      required this.child,
      required this.position,
      this.popoverModel}) {
    init();
  }

  BuildContext context;

  PopoverPosition position;

  Widget child;

  bool isRender = false;

  OverlayState? _overlayState;

  OverlayEntry? _overlayEntry;

  MXPopoverModel? popoverModel;

  void init() {
    _overlayState = Overlay.of(context);
  }

  void setPosition(PopoverPosition position) {
    this.position = position;
  }

  void toRenderContent() {
    if (_overlayState != null) {
      _overlayEntry = OverlayEntry(builder: ((BuildContext context) {
        return MXPopoverWrap(
          showTriangle: popoverModel?.showTriangle ?? true,
          controller: this,
          renderChild: child,
          position: position,
        );
      }));
      _overlayState?.insert(_overlayEntry!);

      isRender = true;
    }
  }

  void toHiddenContent() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      isRender = false;
    }
  }

  /// 当popover组件销魂时需要清除所有数据
  void onRemove() {
    toHiddenContent();

    _overlayEntry = null;
    _overlayState = null;
  }
}
