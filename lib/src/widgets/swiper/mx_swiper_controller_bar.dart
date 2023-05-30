import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

///-------------------------------------------------------------------轮播图指示器
/// [margin] 指示器的外边距
/// [alignment] 指示器的位置类型为Alignment
/// [builder] 指示器的样式圆点/矩形/数字分别为MXSwiperPointControllerBar/
/// MXSwiperNumberControllerBar

class MXSwiperControllBar extends SwiperPlugin {
  MXSwiperControllBar(
      {required this.builder,
      this.alignment,
      this.margin = const EdgeInsets.all(10.0),
      this.key});

  /// [builder] 指示器的样式圆点/矩形/数字分别为MXSwiperPointControllerBar/
  /// MXSwiperNumberControllerBar
  final SwiperPlugin builder;

  /// [alignment] 指示器的位置类型为Alignment
  final Alignment? alignment;

  /// [margin] 指示器的外边距
  final EdgeInsetsGeometry? margin;

  final Key? key;

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    var alignment = this.alignment ??
        (config.scrollDirection == Axis.horizontal
            ? Alignment.bottomCenter
            : Alignment.centerRight);

    Widget child = Container(
      margin: margin,
      child: builder.build(context, config),
    );

    if (!config.outer) {
      child = Align(
        key: key,
        alignment: alignment,
        child: child,
      );
    }

    return child;
  }
}
