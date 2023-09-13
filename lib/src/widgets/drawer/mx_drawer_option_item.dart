import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXDrawerOptionItem extends StatelessWidget {
  const MXDrawerOptionItem({
    super.key,
    this.onClick,
    required this.model,
    this.useBottomBorder = false,
  });

  final MXDrawerOptionsModel model;

  final bool useBottomBorder;

  final DrawerOptionsClick? onClick;

  Widget _buildIcon(BuildContext context) {
    return MXIcon(
      icon: model.icon!,
      useDefaultPadding: false,
      iconColor: MXTheme.of(context).fontUseSecondColors,
      iconFontSize: 22,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return MXText(
      maxLines: 1,
      fontWeight: FontWeight.w500,
      data: model.title,
      overflow: TextOverflow.ellipsis,
      font: MXTheme.of(context).fontBodyMedium,
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    if (model.icon != null) {
      children.add(_buildIcon(context));
      children.add(SizedBox(
        width: MXTheme.of(context).space8,
      ));
    }

    children.add(_buildTitle(context));

    MainAxisAlignment mainAxisAlignment;

    switch (model.placement) {
      case MXDrawerOptionItemPlacementEnum.left:
        mainAxisAlignment = MainAxisAlignment.start;
        break;
      case MXDrawerOptionItemPlacementEnum.center:
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case MXDrawerOptionItemPlacementEnum.right:
        mainAxisAlignment = MainAxisAlignment.end;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: MXTheme.of(context).space16),
      decoration: BoxDecoration(
          border: Border(
              bottom: useBottomBorder
                  ? BorderSide(width: 1, color: MXTheme.of(context).infoColor1)
                  : BorderSide.none)),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _buildBody(context);

    if (onClick != null && !model.disabled) {
      child = GestureDetector(
        onTap: () {
          onClick?.call(model);
        },
        child: child,
      );
    } else if (model.disabled) {
      child = Opacity(
        opacity: 0.4,
        child: child,
      );
    }

    return child;
  }
}
