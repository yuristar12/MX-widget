import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mx_widget/src/config/global_enum.dart';
import 'package:mx_widget/src/theme/mx_radius.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';
import 'package:mx_widget/src/widgets/image/image_widget.dart';

///----------------------------------------------------------------------图片组件
/// [width] 图片宽度
/// [height] 图片高度
/// [color] 图片背景颜色
/// [netUrl] 网络图片地址
/// [file] 文件格式的图片
/// [assetsUrl] 本地图片地址
/// [errorWidget] 图片加载错误的组件
/// [loadingWidget] 图片加载中的组件默认存在骨架屏
/// [customRadius] 图片自定义圆角只在roundSquare生效
/// [modeEnum] 图片展示的模式cut（裁切模式，图片大小超出容器大小只展示容器大小部分）/
/// cover（调整图片内容的大小以覆盖其容器）/circle（圆形图片fit依然是cover）
/// fitWidth（根据图片宽度自适应高度）
/// fitHeight（根据图片高度自适应宽度）/roundSquare（圆角图片）

class MXImage extends StatefulWidget {
  const MXImage(
      {super.key,
      this.width = 72,
      this.height = 72,
      this.color,
      this.netUrl,
      this.file,
      this.assetsUrl,
      this.errorWidget,
      this.loadingWidget,
      this.image,
      this.frameBuilder,
      this.loadingBuilder,
      this.errorWidgetBuilder,
      this.semanticLabel,
      this.excludeFromSemantics = false,
      this.opacity,
      this.colorBlendMode,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.centerSlice,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.isAntiAlias = false,
      this.filterQuality = FilterQuality.none,
      this.cacheWidth,
      this.cacheHeight,
      this.modeEnum = MXImageModeEnum.roundSquare,
      this.customRadius});

  final MXImageModeEnum modeEnum;

  final double width;
  final double height;
  final Color? color;

  final String? netUrl;
  final String? assetsUrl;

  final Widget? errorWidget;
  final Widget? loadingWidget;

  final File? file;

  final BorderRadiusGeometry? customRadius;

  /// 以下是fluuter原生的img组件需要的参数
  final ImageProvider? image;
  final ImageFrameBuilder? frameBuilder;
  final ImageLoadingBuilder? loadingBuilder;
  final ImageErrorWidgetBuilder? errorWidgetBuilder;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final bool isAntiAlias;
  final FilterQuality filterQuality;
  final int? cacheWidth;
  final int? cacheHeight;

  @override
  State<MXImage> createState() => _MXImageState();
}

class _MXImageState extends State<MXImage> {
  Widget _buildBaseImg(BuildContext context, BoxFit fit,
      {bool isNetUrl = false, bool isAssets = false, bool isFile = false}) {
    if (isNetUrl) {
      return ImageWidget.network(
        widget.netUrl,
        width: widget.width,
        height: widget.height,
        fit: fit,
        color: widget.color,
        errorWidget: widget.errorWidget,
        errorWidgetBuilder: widget.errorWidgetBuilder,
        loadingWidget: widget.loadingWidget,
        frameBuilder: widget.frameBuilder,
        semanticLabel: widget.semanticLabel,
        excludeFromSemantics: widget.excludeFromSemantics,
        opacity: widget.opacity,
        colorBlendMode: widget.colorBlendMode,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
        gaplessPlayback: widget.gaplessPlayback,
        filterQuality: widget.filterQuality,
        isAntiAlias: widget.isAntiAlias,
        cacheHeight: widget.cacheHeight,
        cacheWidth: widget.cacheWidth,
      );
    } else if (isAssets) {
      return ImageWidget.asset(
        widget.assetsUrl,
        width: widget.width,
        height: widget.height,
        fit: fit,
        color: widget.color,
        errorWidget: widget.errorWidget,
        errorWidgetBuilder: widget.errorWidgetBuilder,
        loadingWidget: widget.loadingWidget,
        frameBuilder: widget.frameBuilder,
        semanticLabel: widget.semanticLabel,
        excludeFromSemantics: widget.excludeFromSemantics,
        opacity: widget.opacity,
        colorBlendMode: widget.colorBlendMode,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
        gaplessPlayback: widget.gaplessPlayback,
        filterQuality: widget.filterQuality,
        isAntiAlias: widget.isAntiAlias,
        cacheHeight: widget.cacheHeight,
        cacheWidth: widget.cacheWidth,
      );
    } else {
      return Image.file(
        widget.file!,
        width: widget.width,
        height: widget.height,
        fit: fit,
        color: widget.color,
        frameBuilder: widget.frameBuilder,
        semanticLabel: widget.semanticLabel,
        errorBuilder: widget.errorWidgetBuilder,
        excludeFromSemantics: widget.excludeFromSemantics,
        opacity: widget.opacity,
        colorBlendMode: widget.colorBlendMode,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
        gaplessPlayback: widget.gaplessPlayback,
        filterQuality: widget.filterQuality,
        isAntiAlias: widget.isAntiAlias,
        cacheHeight: widget.cacheHeight,
        cacheWidth: widget.cacheWidth,
      );
    }
  }

  /// 构建图片模式为裁剪
  Widget buildCoverImg(BuildContext context) {
    if (widget.assetsUrl != null) {
      return _buildBaseImg(context, BoxFit.cover, isAssets: true);
    } else if (widget.netUrl != null) {
      return _buildBaseImg(context, BoxFit.cover, isNetUrl: true);
    } else if (widget.file != null) {
      return _buildBaseImg(context, BoxFit.cover, isFile: true);
    }
    return Container();
  }

  /// 构建图片高度自适应为裁剪
  Widget buildFitHeightImg(BuildContext context) {
    if (widget.assetsUrl != null) {
      return _buildBaseImg(context, BoxFit.fitHeight, isAssets: true);
    } else if (widget.netUrl != null) {
      return _buildBaseImg(context, BoxFit.fitHeight, isNetUrl: true);
    } else if (widget.file != null) {
      return _buildBaseImg(context, BoxFit.fitHeight, isFile: true);
    }
    return Container();
  }

  /// 构建图片宽度自适应为裁剪
  Widget buildFitWidthImg(BuildContext context) {
    if (widget.assetsUrl != null) {
      return _buildBaseImg(context, BoxFit.fitWidth, isAssets: true);
    } else if (widget.netUrl != null) {
      return _buildBaseImg(context, BoxFit.fitWidth, isNetUrl: true);
    } else if (widget.file != null) {
      return _buildBaseImg(context, BoxFit.fitWidth, isFile: true);
    }
    return Container();
  }

  /// 构建裁切图片
  Widget buildCutImg(BuildContext context) {
    if (widget.assetsUrl != null) {
      return _buildBaseImg(context, BoxFit.none, isAssets: true);
    } else if (widget.netUrl != null) {
      return _buildBaseImg(context, BoxFit.none, isNetUrl: true);
    } else if (widget.file != null) {
      return _buildBaseImg(context, BoxFit.none, isFile: true);
    }
    return Container();
  }

  /// 构建圆角图片
  Widget buildRoundSquareImg(BuildContext context) {
    Widget child;
    if (widget.assetsUrl != null) {
      child = _buildBaseImg(context, BoxFit.cover, isAssets: true);
    } else if (widget.netUrl != null) {
      child = _buildBaseImg(context, BoxFit.cover, isNetUrl: true);
    } else if (widget.file != null) {
      child = _buildBaseImg(context, BoxFit.cover, isFile: true);
    } else {
      child = Container();
    }

    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: widget.customRadius ??
              BorderRadius.all(
                  Radius.circular(MXTheme.of(context).radiusDefault))),
      child: child,
    );
  }

  /// 构建正圆图片
  Widget buildCircleImg(BuildContext context) {
    Widget child;
    if (widget.assetsUrl != null) {
      child = _buildBaseImg(context, BoxFit.cover, isAssets: true);
    } else if (widget.netUrl != null) {
      child = _buildBaseImg(context, BoxFit.cover, isNetUrl: true);
    } else if (widget.file != null) {
      child = _buildBaseImg(context, BoxFit.cover, isFile: true);
    } else {
      child = Container();
    }

    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    switch (widget.modeEnum) {
      case MXImageModeEnum.cover:
        imageWidget = buildCoverImg(context);
        break;
      case MXImageModeEnum.fitWidth:
        imageWidget = buildFitWidthImg(context);
        break;
      case MXImageModeEnum.fitHeight:
        imageWidget = buildFitHeightImg(context);
        break;
      case MXImageModeEnum.cut:
        imageWidget = buildCutImg(context);
        break;
      case MXImageModeEnum.roundSquare:
        imageWidget = buildRoundSquareImg(context);
        break;
      case MXImageModeEnum.circle:
        imageWidget = buildCircleImg(context);
        break;
    }
    return imageWidget;
  }
}
