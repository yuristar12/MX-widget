import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class DropDownMenuToastWrap {
  static OverlayEntry? _overlayEntry;

  static OverlayState? _overlayState;

  static bool show = false;

  static bool isTop = false;

  static BuildContext? renderContext;

  static double? height;

  static Offset? offset;

  static double? selfHeight;

  static double? width;

  void onRender(
      {required BuildContext context,
      required Widget child,
      required Offset position,
      required double renderWidth,
      required double renderSelfHeight,
      required double renderHeight}) {
    _overlayState = Overlay.of(context);

    width = renderWidth;
    renderContext = context;
    height = renderHeight;
    offset = position;
    selfHeight = renderSelfHeight;

    _insertOverlay(child);
  }

  static double _getRenderWidgetHeight() {
    double mediaHeight = MediaQuery.of(renderContext!).size.height;

    double isBottomHeight = height!;

    double isTopHeight = offset!.dy;

    double canRenderBottomSize = mediaHeight - offset!.dy - selfHeight!;

    if (isBottomHeight <= canRenderBottomSize || height! <= isTopHeight) {
      // 优先渲染在下方
      if (isBottomHeight <= canRenderBottomSize) {
        isTop = false;
        return canRenderBottomSize;
      }
      // 渲染上方的容器大小
      else {
        isTop = true;
        return isTopHeight;
      }
    } else {
      throw FlutterError("请修改renderHeight,确保屏幕能正确渲染部件");
    }
  }

  void onHiden() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
    }
    _overlayEntry = null;
  }

  bool hasClickRange(Offset position) {
    double dy = position.dy;

    if (isTop) {
      if (dy > (offset!.dy + selfHeight!)) {
        return false;
      } else {
        return true;
      }
    } else {
      if (dy < offset!.dy) {
        return false;
      } else {
        return true;
      }
    }
  }

  static void _insertOverlay(Widget child) {
    _overlayEntry = OverlayEntry(builder: (BuildContext context) {
      double height = _getRenderWidgetHeight();
      return _buildOvertlayWrap(child, height);
    });

    _overlayState?.insert(_overlayEntry!);
  }

  static Widget _buildOvertlayWrap(Widget child, double renderHeight) {
    double top = 0;

    if (isTop) {
      top = 0;
    } else {
      top = (offset!.dy + selfHeight!);
    }

    return Stack(
      children: [
        Positioned(
            left: 0,
            top: top,
            child: Container(
                width: width,
                height: renderHeight,
                color: MXTheme.getThemeConfig().mask1,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: height!),
                            child: SizedBox(
                              width: width,
                              child: child,
                            )))
                  ],
                )))
      ],
    );
  }
}
