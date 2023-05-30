import 'package:flutter/material.dart';
import 'package:mx_widget/src/theme/mx_colors.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';
import 'package:mx_widget/src/widgets/icon/mx_icon.dart';
import 'package:mx_widget/src/widgets/skeleton/mx_skeleton.dart';

/// ------------------------------------------------------------------重写图片组件
/// [width] 图片组件的宽度
/// [height] 图片组件的高度
/// [netUrl] 网络图片的链接 注意网络与本地的URL不能同时存在
/// [assetsUrl] 本地图片的链接 注意网络与本地的URL不能同时存在
/// [fit] 图片展示的样式
/// [color] 图片的背景颜色
class ImageWidget extends StatefulWidget {
  const ImageWidget(
      {super.key,
      this.width,
      this.height,
      this.color,
      required this.image,
      this.frameBuilder,
      this.loadingBuilder,
      this.errorWidgetBuilder,
      this.semanticLabel,
      this.excludeFromSemantics = false,
      this.opacity,
      this.colorBlendMode,
      this.fit,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.centerSlice,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.isAntiAlias = false,
      this.filterQuality = FilterQuality.low,
      this.netUrl,
      this.assetsUrl,
      this.errorWidget,
      this.loadingWidget,
      this.cacheWidth,
      this.cacheHeight});

  final double? width;
  final double? height;
  final Color? color;

  final String? netUrl;
  final String? assetsUrl;

  final Widget? errorWidget;
  final Widget? loadingWidget;

  /// 以下是fluuter原生的img组件需要的参数
  final ImageProvider image;
  final ImageFrameBuilder? frameBuilder;
  final ImageLoadingBuilder? loadingBuilder;
  final ImageErrorWidgetBuilder? errorWidgetBuilder;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final bool isAntiAlias;
  final FilterQuality filterQuality;
  final int? cacheWidth;
  final int? cacheHeight;

  ImageWidget.network(this.netUrl,
      {Key? key,
      required this.width,
      required this.height,
      double scale = 1.0,
      this.errorWidget,
      this.fit = BoxFit.none,
      this.loadingWidget,
      this.frameBuilder,
      this.loadingBuilder,
      this.errorWidgetBuilder,
      this.semanticLabel,
      this.excludeFromSemantics = false,
      this.color,
      this.opacity,
      this.colorBlendMode,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.centerSlice,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.filterQuality = FilterQuality.low,
      this.isAntiAlias = false,
      Map<String, String>? headers,
      this.cacheWidth,
      this.assetsUrl,
      this.cacheHeight})
      : image = ResizeImage.resizeIfNeeded(cacheWidth, cacheHeight,
            NetworkImage(netUrl ?? '', scale: scale, headers: headers)),
        assert(cacheWidth == null || cacheWidth > 0),
        assert(cacheHeight == null || cacheHeight > 0),
        super(key: key);

  ImageWidget.asset(
    this.assetsUrl, {
    Key? key,
    AssetBundle? bundle,
    this.frameBuilder,
    this.errorWidgetBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    double? scale,
    required this.width,
    required this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit = BoxFit.none,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    String? package,
    this.filterQuality = FilterQuality.low,
    this.cacheWidth,
    this.cacheHeight,
    this.netUrl,
    this.errorWidget,
    this.loadingWidget,
  })  : image = ResizeImage.resizeIfNeeded(
          cacheWidth,
          cacheHeight,
          scale != null
              ? ExactAssetImage(assetsUrl ?? '',
                  bundle: bundle, scale: scale, package: package)
              : AssetImage(assetsUrl ?? '', bundle: bundle, package: package),
        ),
        loadingBuilder = null,
        assert(cacheWidth == null || cacheWidth > 0),
        assert(cacheHeight == null || cacheHeight > 0),
        super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  late Image _image;

  bool isError = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // 初始化判断图片资源是否是本地还是网络资源

    if (widget.netUrl != null) {
      _image = Image.network(
        widget.netUrl ?? '',
        width: widget.width,
        height: widget.width,
        color: widget.color,
        frameBuilder: widget.frameBuilder,
        loadingBuilder: widget.loadingBuilder,
        errorBuilder: widget.errorWidgetBuilder,
        semanticLabel: widget.semanticLabel,
        excludeFromSemantics: widget.excludeFromSemantics,
        opacity: widget.opacity,
        colorBlendMode: widget.colorBlendMode,
        fit: widget.fit,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
        gaplessPlayback: widget.gaplessPlayback,
        isAntiAlias: widget.isAntiAlias,
        filterQuality: widget.filterQuality,
      );
    } else if (widget.assetsUrl != null) {
      _image = Image.asset(
        widget.assetsUrl ?? '',
        width: widget.width,
        height: widget.width,
        color: widget.color,
        frameBuilder: widget.frameBuilder,
        errorBuilder: widget.errorWidgetBuilder,
        semanticLabel: widget.semanticLabel,
        excludeFromSemantics: widget.excludeFromSemantics,
        opacity: widget.opacity,
        colorBlendMode: widget.colorBlendMode,
        fit: widget.fit,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
        gaplessPlayback: widget.gaplessPlayback,
        isAntiAlias: widget.isAntiAlias,
        filterQuality: widget.filterQuality,
      );
    }

    // 监听图片的加载状态

    var resolve = _image.image.resolve(const ImageConfiguration());
    // 监听图片的加载状态
    resolve.addListener(ImageStreamListener(
      (image, synchronousCall) {
        if (mounted) {
          setState(() {
            isError = false;
            isLoading = false;
          });
        }
      },
      onChunk: (event) {
        if (!isLoading) {
          if (mounted) {
            setState(() {
              isError = false;
              isLoading = true;
            });
          }
        }
      },
      onError: (exception, stackTrace) {
        if (!isError) {
          setState(() {
            isError = true;
            isLoading = false;
          });
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    // 如果图片是加载状态则加载骨架屏或者传入的加载组件
    if (!isError && isLoading) {
      return Container(
          alignment: widget.alignment,
          color: widget.color ?? MXTheme.of(context).infoColor3,
          // 骨架屏组件
          child: widget.loadingWidget ??
              MXSkeleton(percentageWidth: 1, height: widget.height ?? 30));
    }

    // 图片裂开状态
    if (isError && !isLoading) {
      return Container(
          alignment: widget.alignment,
          color: widget.color ?? MXTheme.of(context).infoColor3,
          // 错误的icon组件
          child: widget.errorWidget ??
              const MXIcon(icon: Icons.image_not_supported));
    }
    // 如果两者都没有状态则渲染正常的图片组件
    if (!isError && !isLoading) {
      return _image;
    }
    return Container();
  }
}
