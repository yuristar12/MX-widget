import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

class MXSwiperPointControllerBar extends SwiperPlugin {
  final Color? activityColor;

  final Color? color;

  final double? size;

  final double? activitySize;

  final double? space;

  final Key? key;

  final double? activityRadius;

  final int? animationDuration;

  MXSwiperPointControllerBar(
      {this.activityColor,
      this.color,
      this.size = 6,
      this.activitySize = 6,
      this.space = 4,
      this.key,
      this.activityRadius,
      this.animationDuration = 100});

  Color _getActivityColor(BuildContext context, SwiperPluginConfig config) {
    return activityColor ??
        (config.outer
            ? MXTheme.of(context).brandPrimaryColor
            : MXTheme.of(context).whiteColor);
  }

  Color _getColor(BuildContext context, SwiperPluginConfig config) {
    return color ??
        (config.outer
            ? MXTheme.of(context).infoColor3
            : MXTheme.of(context).whiteColor.withOpacity(0.55));
  }

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    int length = config.itemCount;
    Widget child;

    int activityIndex = config.activeIndex;

    List<Widget> list = [];

    for (int i = 0; i < length; i++) {
      var isAvtivity = activityIndex == i;

      var isRange = activityRadius != null && isAvtivity && activityRadius! > 0;

      list.add(Container(
        key: Key('controllBarPoint$i'),
        margin: EdgeInsets.all(space!),
        child: AnimatedContainer(
          duration: Duration(milliseconds: animationDuration!),
          width: isRange
              ? activityRadius
              : isAvtivity
                  ? activitySize
                  : size,
          height: isAvtivity ? activitySize : size,
          decoration: BoxDecoration(
            color: isAvtivity
                ? _getActivityColor(context, config)
                : _getColor(context, config),
            borderRadius: BorderRadius.circular(size! / 2),
          ),
        ),
      ));
    }

    if (config.scrollDirection == Axis.horizontal) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      child = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
    return child;
  }
}
