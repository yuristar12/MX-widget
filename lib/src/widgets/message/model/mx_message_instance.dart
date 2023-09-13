import 'package:flutter/widgets.dart';

class MXMessageInstance {
  MXMessageInstance();

  OverlayState? _overlayState;

  OverlayEntry? _overlayEntry;

  void _initOverlayState(BuildContext context) {
    _overlayState = Overlay.of(context);
  }

  void _destroy() {
    _overlayEntry = null;
    _overlayState = null;
  }

  void toCreateMessage(BuildContext context, Widget child,
      {double offsetY = 0}) {
    _initOverlayState(context);

    if (_overlayState != null) {
      _overlayEntry = OverlayEntry(builder: (BuildContext context) {
        double top = MediaQuery.of(context).padding.top + offsetY;

        return Stack(
          children: [Positioned(top: top, left: 0, child: child)],
        );
      });
      _overlayState?.insert(_overlayEntry!);
    }
  }

  void toDestroyMessage() {
    if (_overlayState != null) {
      _overlayEntry?.remove();
      _destroy();
    }
  }
}
