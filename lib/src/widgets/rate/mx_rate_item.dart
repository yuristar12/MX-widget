import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

typedef MXRateItemOnTap = void Function(DragDownDetails details, int index);

class MXRateItem extends StatelessWidget {
  const MXRateItem(
      {super.key,
      required this.index,
      this.useHalf = false,
      required this.value,
      required this.onTap,
      required this.size,
      this.customUnselectIcon,
      this.customSelectIcon,
      this.customSelectColor,
      this.useEvent = true,
      this.customUnSelectColor});

  final IconData? customUnselectIcon;
  final IconData? customSelectIcon;
  final Color? customSelectColor;

  final Color? customUnSelectColor;

  final int index;

  final bool useHalf;

  final double value;

  final double size;

  final MXRateItemOnTap onTap;

  final bool useEvent;

  bool get isPast {
    return value >= index;
  }

  bool get isRenderHalf {
    if (useHalf) {
      return value > index - 1;
    }

    return false;
  }

  double _getSize() {
    return size;
  }

  IconData _getIconData({bool isActivity = false}) {
    if (isPast || isActivity) {
      return customSelectIcon ?? Icons.star_sharp;
    } else {
      return customUnselectIcon ?? Icons.star_sharp;
    }
  }

  Color _getColor(BuildContext context, {bool isActivity = false}) {
    if (isPast || isActivity) {
      return customSelectColor ?? MXTheme.of(context).warnPrimaryColor;
    } else {
      return customUnSelectColor ?? MXTheme.of(context).infoPrimaryColor;
    }
  }

  Widget _buildNormaIcon(BuildContext context, double size) {
    return MXIcon(
      icon: _getIconData(),
      iconFontSize: size,
      useDefaultPadding: false,
      iconColor: _getColor(context),
    );
  }

  Widget _buildHaleIcon(BuildContext context, double size) {
    return Positioned(
        top: 0,
        left: 0,
        child: ClipRect(
          child: Align(
            widthFactor: 0.5,
            alignment: Alignment.centerLeft,
            child: MXIcon(
              icon: _getIconData(isActivity: true),
              iconFontSize: size,
              useDefaultPadding: false,
              iconColor: _getColor(context, isActivity: true),
            ),
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
    Widget child;
    double size = _getSize();
    List<Widget> children = [];

    children.add(_buildNormaIcon(context, size));

    if (isRenderHalf) {
      children.add(_buildHaleIcon(context, size));
    }

    child = SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: children,
      ),
    );

    if (useEvent) {
      return GestureDetector(
          onPanDown: (details) {
            onTap(details, index);
          },
          child: child);
    } else {
      return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
