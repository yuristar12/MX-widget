import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';

class MXFabButton extends StatelessWidget {
  const MXFabButton({super.key, required this.model});

  final MXFabButtonModel model;

  Widget _buildButtonBody(BuildContext context) {
    MXButtonShapeEnum shapeEnum;

    if (model.text != null && model.icon != null) {
      shapeEnum = MXButtonShapeEnum.round;
    } else if (model.text == null && model.icon != null) {
      shapeEnum = MXButtonShapeEnum.circ;
    } else {
      shapeEnum = MXButtonShapeEnum.rect;
    }

    return Container(
        decoration: BoxDecoration(boxShadow: MXTheme.of(context).shadowTopList),
        child: MXButton(
          customHeight: model.customHeight,
          customWidth: model.customWidth,
          icon: model.icon,
          shape: shapeEnum,
          afterClickButtonCallback: model.afterClickButtonCallback,
          text: model.text ?? '',
          themeEnum: model.themeEnum,
        ));
  }

  Widget _getPosition(Widget button) {
    Widget child;

    double? padding = model.padding;

    if (model.aligiment == MXFabButtonAligimentEnum.bottomLeft) {
      child = Positioned(
        bottom: padding,
        left: padding,
        child: button,
      );
    } else if (model.aligiment == MXFabButtonAligimentEnum.bottomRight) {
      child = Positioned(bottom: padding, right: padding, child: button);
    } else if (model.aligiment == MXFabButtonAligimentEnum.topLeft) {
      child = Positioned(top: padding, left: padding, child: button);
    } else if (model.aligiment == MXFabButtonAligimentEnum.topRight) {
      child = Positioned(top: padding, right: padding, child: button);
    } else {
      MXFabButtonCustomPosition customPosition = model.customPosition!;
      child = Positioned(
          bottom: customPosition.bottom,
          right: customPosition.right,
          top: customPosition.top,
          left: customPosition.left,
          child: button);
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _buildButtonBody(context);

    return _getPosition(child);
  }
}
