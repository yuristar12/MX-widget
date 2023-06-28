import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

class MXToast {
  static Timer? _timer;

  static OverlayEntry? _overlayEntry;

  static OverlayState? _overlayState;

  static bool show = false;

// 默认的显示的时长
  // ignore: prefer_final_fields
  static Duration _defaultDuration = const Duration(milliseconds: 3000);

  void _initOverLayState(BuildContext? context, OverlayState? state) {
    if (context == null && state == null) {
      return;
    }

    if (show) {
      hidden();
    }

    if (context != null) {
      _overlayState = Overlay.of(context);
      show = true;
      return;
    }

    if (state != null) {
      _overlayState = state;
      show = true;
      return;
    }
  }

  void _insertOverlay(Widget child) {
    if (_overlayEntry == null && _overlayState != null) {
      _overlayEntry = OverlayEntry(builder: (BuildContext context) {
        return AnimatedOpacity(
            opacity: show ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: child);
      });
      if (_overlayState != null) {
        _overlayState?.insert(_overlayEntry!);
      }
    }
  }

  void startDown(
    Duration? duration,
  ) {
    _timer = Timer(duration ?? _defaultDuration, () {
      hidden();
    });
  }

  void hidden() {
    _timer?.cancel();
    _timer = null;
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
    }

    _overlayEntry = null;
    show = false;
  }

  void toastByText(BuildContext? context, String text,
      {Duration? duration,
      OverlayState? state,
      MXToastDirectionEnum directionEnum = MXToastDirectionEnum.horizontal}) {
    _initOverLayState(context, state);

    _insertOverlay(
      MXToastBody(
        text: text,
        mxToastDirectionEnum: directionEnum,
      ),
    );

    startDown(duration);
  }

  void toastBySuccess(BuildContext? context, String text,
      {Duration? duration,
      OverlayState? state,
      MXToastDirectionEnum directionEnum = MXToastDirectionEnum.horizontal}) {
    _initOverLayState(context, state);

    _insertOverlay(
      MXToastBody(
        iconData: Icons.check_circle_outline,
        text: text,
        mxToastDirectionEnum: directionEnum,
      ),
    );
    startDown(duration);
  }

  void toastByError(BuildContext? context, String text,
      {Duration? duration,
      OverlayState? state,
      MXToastDirectionEnum directionEnum = MXToastDirectionEnum.horizontal}) {
    _initOverLayState(context, state);

    _insertOverlay(
      MXToastBody(
        iconData: Icons.close_outlined,
        text: text,
        mxToastDirectionEnum: directionEnum,
      ),
    );
    startDown(duration);
  }

  MXToast toastByLoading(BuildContext? context,
      {String text = '正在加载中。。。',
      OverlayState? state,
      MXToastDirectionEnum directionEnum = MXToastDirectionEnum.vertical}) {
    _initOverLayState(context, state);

    _insertOverlay(
      MXToastBody(
        iconWidget: _buildLoadingWidget(context, directionEnum),
        text: text,
        mxToastDirectionEnum: directionEnum,
      ),
    );

    return this;
  }
}

_buildLoadingWidget(BuildContext? context, MXToastDirectionEnum directionEnum) {
  if (directionEnum == MXToastDirectionEnum.horizontal) {
    return Row(
      children: [
        MXCircleLoading(
          size: 18,
          circleColor: MXTheme.of(context).whiteColor,
        ),
        SizedBox(
          width: MXTheme.of(context).space12,
        )
      ],
    );
  } else if (directionEnum == MXToastDirectionEnum.vertical) {
    return Column(
      children: [
        MXCircleLoading(
          size: 18,
          circleColor: MXTheme.of(context).whiteColor,
        ),
        SizedBox(
          height: MXTheme.of(context).space12,
        )
      ],
    );
  }
}
