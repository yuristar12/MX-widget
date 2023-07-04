import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';

const Duration popUpToLiveDuration = Duration(milliseconds: 200);

class MXPopUpRoute extends PopupRoute {
  MXPopUpRoute(
      {required this.builder,
      this.customModelColor,
      this.modelClose = true,
      this.modelLabel,
      this.showTypeEnum = MXPopUpShowTypeEnum.toBottom});

  final WidgetBuilder builder;

  final Color? customModelColor;

  final bool modelClose;

  final String? modelLabel;

  final MXPopUpShowTypeEnum showTypeEnum;

  @override
  Color? get barrierColor => customModelColor ?? MXTheme.getThemeConfig().mask1;

  @override
  bool get barrierDismissible => modelClose;

  @override
  String? get barrierLabel => modelLabel;

  @override
  Duration get transitionDuration => popUpToLiveDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (showTypeEnum == MXPopUpShowTypeEnum.toCenter) {
      return AnimatedScale(
          curve: CurveUtil.curve_1(),
          scale: animation.value,
          duration: popUpToLiveDuration,
          child: CustomSingleChildLayout(
            delegate: MXSingleChildLayoutDelegate(
                accelerateEasing.transform(animation.value), showTypeEnum),
            child: child,
          ));
    } else {
      return AnimatedBuilder(
          animation:
              CurvedAnimation(parent: animation, curve: CurveUtil.curve_1()),
          builder: (BuildContext context, child) {
            return CustomSingleChildLayout(
              delegate: MXSingleChildLayoutDelegate(
                  accelerateEasing.transform(animation.value), showTypeEnum),
              child: child,
            );
          },
          child: child);
    }
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder.call(context);
  }
}

class MXSingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  double animaValue;
  MXPopUpShowTypeEnum popUpShowTypeEnum;
  MXSingleChildLayoutDelegate(this.animaValue, this.popUpShowTypeEnum);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
        maxHeight: constraints.maxHeight, maxWidth: constraints.maxWidth);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double dx = 0.0;
    double dy = 0.0;

    switch (popUpShowTypeEnum) {
      case MXPopUpShowTypeEnum.toTop:
        dy = -(childSize.height - childSize.height * animaValue);
        break;
      case MXPopUpShowTypeEnum.toRight:
        dx = -(childSize.width - childSize.width * animaValue);
        break;
      case MXPopUpShowTypeEnum.toBottom:
        dy = (size.height - childSize.height * animaValue);
        break;
      case MXPopUpShowTypeEnum.toLeft:
        dx = (size.width - childSize.width * animaValue);
        break;
      case MXPopUpShowTypeEnum.toCenter:
        dx = (size.width - (childSize.width)) / 2;
        dy = (size.height - (childSize.height)) / 2;
        break;
    }

    return Offset(dx, dy);
  }

  @override
  bool shouldRelayout(covariant MXSingleChildLayoutDelegate oldDelegate) {
    return oldDelegate.animaValue != animaValue ||
        oldDelegate.popUpShowTypeEnum != popUpShowTypeEnum;
  }
}
