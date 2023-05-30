import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/src/transformer_page_view/transformer_page_view.dart';

///-----------------------------------------------------------------轮播图特殊样式
/// 需要设置swiper的viewportFraction值根据情况设置，0-1 1不生效
/// [margin] 轮播图图片之间的间距如果需要生效
/// [fade] 轮播图除当前轮播的图片之外产生透明效果
/// [scale] 轮播图除当前轮播的图片之外产生缩放效果

class MXPagetransform extends PageTransformer {
  final double? margin;

  final double? fade;

  final double? scale;

  MXPagetransform.transToMargin({this.margin = 6.0})
      : fade = 1,
        scale = 1;

  MXPagetransform.transToScaleAndFade({this.scale = 0.8, this.fade = 1.0})
      : margin = 0;

  MXPagetransform({
    this.margin,
    this.fade,
    this.scale,
  });

  double _getRawValue(double position, double value) {
    return (1 - position.abs()) * (1 - value) + value;
  }

  @override
  Widget transform(Widget child, TransformInfo info) {
    Widget widget = child;

    if (scale != null) {
      widget = Transform.scale(
        scale: _getRawValue(info.position, scale!),
        child: widget,
      );
    }

    if (fade != null) {
      widget = Opacity(
        opacity: _getRawValue(info.position, fade!),
        child: widget,
      );
    }

    if (margin != null) {
      widget = Container(
        margin: EdgeInsets.only(left: margin!, right: margin!),
        child: widget,
      );
    }

    return widget;
  }
}
