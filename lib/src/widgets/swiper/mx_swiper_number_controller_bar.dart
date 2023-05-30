import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

class MXSwiperNumberControllerBar extends SwiperPlugin {
  // 指示器的宽度
  final double? width;
  // 指示器的高度
  final double? height;
  // 背景颜色
  final Color? backgroundColor;
  // 当前活动的颜色
  final Color? activityColor;
  // 文字颜色
  final Color? color;
  // 文字样式
  final TextStyle? textStyle;
  // 当前活动的文字样式
  final TextStyle? activityTextStyle;

  // 圆角
  final double? radius;

  final Key? key;

  MXSwiperNumberControllerBar(
      {this.width,
      this.height,
      this.radius,
      this.backgroundColor,
      this.activityColor,
      this.color,
      this.textStyle,
      this.key,
      this.activityTextStyle});

  TextStyle _getActivityTextStyle(BuildContext context) {
    TextStyle activityTextStyle = this.activityTextStyle ??
        TextStyle(
            color: MXTheme.of(context).whiteColor,
            fontSize: MXTheme.of(context).fontInfoLarge!.size);

    return activityTextStyle;
  }

  TextStyle _getTextStyle(BuildContext context) {
    TextStyle textStyle = this.textStyle ??
        TextStyle(
            color: MXTheme.of(context).whiteColor,
            fontSize: MXTheme.of(context).fontInfoLarge!.size);

    return textStyle;
  }

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    Widget child;

    if (config.scrollDirection == Axis.horizontal) {
      child = Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${config.activeIndex + 1}',
            style: _getActivityTextStyle(context),
          ),
          Text(
            "/",
            style: _getTextStyle(context),
          ),
          Text(
            '${config.itemCount}',
            style: _getTextStyle(context),
          )
        ],
      );
    } else {
      child = Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${config.activeIndex + 1}',
            style: _getActivityTextStyle(context),
          ),
          Text(
            "/",
            style: _getTextStyle(context),
          ),
          Text(
            '${config.itemCount}',
            style: _getTextStyle(context),
          )
        ],
      );
    }

    return Container(
      width: width ?? 72,
      height: height ?? 72,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color ?? const Color.fromARGB(65, 0, 0, 0),
          borderRadius: BorderRadius.circular(
              radius ?? MXTheme.of(context).radiusMedium)),
      child: child,
    );
  }
}
