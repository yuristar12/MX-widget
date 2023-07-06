import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mx_widget/mx_widget.dart';
import 'dart:ui' as ui show TextHeightBehavior;

import '../../util/platform_util.dart';

// ignore: must_be_immutable
///----------------------------------------------------------------------文字组件
///使用该组件能让中文在android机中强制居中
//ignore: must_be_immutable
class MXText extends StatelessWidget {
  MXText(
      {super.key,
      this.data,
      this.font,
      this.isNumber = false,
      this.fontWeight,
      this.fontFamily,
      this.textColor,
      this.backgroundColor,
      this.package = 'mx_widget',
      this.isTextThrough = false,
      this.lineThroughColor,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior,
      this.textSpan,
      this.forceVerticalCenter = true,
      this.isLine = true});

  final MXFontStyle? font;

  ///是否居中，如果是则采用居中算法的字体，但是该方法会导致文字无法换行

  final bool isLine;

  /// 是否是数字类型，采用将使用字体为DIN显示数字类型
  final bool isNumber;

  /// 字体粗细
  final FontWeight? fontWeight;

  /// 字体ttf
  final FontFamily? fontFamily;

  /// 文本颜色
  Color? textColor;

  /// 背景颜色
  final Color? backgroundColor;

  /// 项目字体包名
  final String? package;

  /// 是否是横线穿过样式(删除线)
  final bool? isTextThrough;

  /// 删除线颜色，对应TestStyle的decorationColor
  Color? lineThroughColor;

  /// 自定义的TextStyle，其中指定的属性，将覆盖扩展的外层属性
  final TextStyle? style;

  /// 以下系统text属性，释义请参考系统[Text]中注释
  final dynamic data;

  final StrutStyle? strutStyle;

  final TextAlign? textAlign;

  final TextDirection? textDirection;

  final Locale? locale;

  final bool? softWrap;

  final TextOverflow? overflow;

  final double? textScaleFactor;

  final int? maxLines;

  final String? semanticsLabel;

  final TextWidthBasis? textWidthBasis;

  final ui.TextHeightBehavior? textHeightBehavior;

  final InlineSpan? textSpan;

  final bool forceVerticalCenter;

  @override
  Widget build(BuildContext context) {
    textColor ??= MXTheme.of(context).fontUsePrimaryColor;
    lineThroughColor ??= MXTheme.of(context).whiteColor;

    var config = getConfiguration(context);
    var paddingConfig = config?.paddingConfig;

    var textFont = font ??
        MXTheme.of(context).fontBodyMedium ??
        MXFontStyle(size: 16, lineHeight: 24);
    var fontSize = style?.fontSize ?? textFont.size;
    var height = style?.height ?? textFont.heightRate;

    paddingConfig ??= TextPaddingConfig.getDefaultConfig();
    var showHeight = min(paddingConfig.heightRate, height);
    Widget child = _getRawText(
        context: context, textStyle: getTextStyle(context, height: showHeight));
    if (isLine && !isNumber) {
      child = Container(
          color: style?.backgroundColor ?? backgroundColor,
          height: fontSize * height,
          padding: paddingConfig.getPadding(data, fontSize, height),
          child: child);
    } else if (isNumber) {
      child = _getRawText(
          context: context,
          textStyle: getTextStyle(context,
              height: showHeight, fontfamily: 'DINMedium'));
    }

    return child;
  }

  TextConfiguration? getConfiguration(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TextConfiguration>();
  }

  TextStyle? getTextStyle(
    BuildContext? context, {
    double? height,
    Color? backgroundColor,
    String? fontfamily,
  }) {
    var textFont = font ??
        MXTheme.of(context).fontBodyLarge ??
        MXFontStyle(size: 16, lineHeight: 24);
    return TextStyle(
      inherit: style?.inherit ?? true,
      color: style?.color ?? textColor,
      backgroundColor: backgroundColor,
      fontSize: style?.fontSize ?? textFont.size,
      fontWeight: style?.fontWeight ?? fontWeight ?? textFont.fontWeight,
      fontStyle: style?.fontStyle,
      letterSpacing: style?.letterSpacing,
      wordSpacing: style?.wordSpacing,
      textBaseline: style?.textBaseline,
      height: height ?? style?.height ?? textFont.heightRate,
      leadingDistribution: style?.leadingDistribution,
      locale: style?.locale,
      foreground: style?.foreground,
      background: style?.background,
      shadows: style?.shadows,
      fontFeatures: style?.fontFeatures,
      decoration: style?.decoration ??
          (isTextThrough! ? TextDecoration.lineThrough : TextDecoration.none),
      decorationColor: style?.decorationColor ?? lineThroughColor,
      decorationStyle: style?.decorationStyle,
      decorationThickness: style?.decorationThickness,
      debugLabel: style?.debugLabel,
      fontFamily: style?.fontFamily ?? fontfamily ?? fontFamily?.fontFamily,
      fontFamilyFallback: style?.fontFamilyFallback,
      package: package,
    );
  }

  /// 获取系统原始Text，以便使用到只能接收系统Text组件的地方
  /// 转化为系统原始Text后，将失去padding和background属性
  Text getRawText({BuildContext? context}) {
    return _getRawText(context: context, backgroundColor: backgroundColor);
  }

  Text _getRawText(
      {BuildContext? context, TextStyle? textStyle, Color? backgroundColor}) {
    return Text(
      data,
      key: key,
      style:
          textStyle ?? getTextStyle(context, backgroundColor: backgroundColor),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}

class TextConfiguration extends InheritedWidget {
  /// forceVerticalCenter=true时，内置padding配置
  final TextPaddingConfig? paddingConfig;

  const TextConfiguration({this.paddingConfig, Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant TextConfiguration oldWidget) {
    return paddingConfig != oldWidget.paddingConfig;
  }
}

/// 算法来自TDesign Flutter
/// 通过Padding自定义Text居中算法
class TextPaddingConfig {
  static TextPaddingConfig? _defaultConfig;

  /// 获取默认配置
  static TextPaddingConfig getDefaultConfig() {
    _defaultConfig ??= TextPaddingConfig();
    return _defaultConfig!;
  }

  /// 获取padding
  EdgeInsetsGeometry getPadding(String data, double fontSize, double height) {
    var paddingFont = fontSize * paddingRate;
    num paddingLeading;
    if (height < heightRate) {
      paddingLeading = 0;
    } else {
      if (PlatformUtil.ios || PlatformUtil.android) {
        paddingLeading = (height * 0.5 - paddingExtraRate) * fontSize;
      } else {
        paddingLeading = 0;
      }
    }
    var paddingTop = paddingFont + paddingLeading;
    if (paddingTop < 0) {
      paddingTop = 0;
    }
    return EdgeInsets.only(top: paddingTop);
  }

  /// 以多个汉字测量计算的平均值,Android为Pixel 4模拟器，iOS为iphone 8 plus 模拟器
  double get paddingRate => PlatformUtil.web
      ? 3 / 8
      : PlatformUtil.android
          ? -7 / 128
          : 0;

  /// 以多个汉字测量计算的平均值,Android为Pixel 4模拟器，iOS为iphone 8 plus 模拟器
  double get paddingExtraRate => PlatformUtil.android ? 115 / 256 : 97 / 240;

  /// height比率，因为设置1时，Android文字可能显示不全，默认为1.1
  double get heightRate => PlatformUtil.android ? 1.1 : 1;
}
