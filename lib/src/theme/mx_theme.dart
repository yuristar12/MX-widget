import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mx_widget/src/theme/font_type.dart';
import 'package:mx_widget/src/theme/mx_raw_theme.dart';
import 'package:mx_widget/src/util/string_util.dart';

class MXTheme extends StatelessWidget {
  const MXTheme({
    super.key,
    required this.themeConfig,
    required this.widget,
  });

  final Widget widget;

  final MXThemeConfig themeConfig;

  @override
  Widget build(BuildContext context) {
    var themeExtensions = [themeConfig];
    return Theme(data: ThemeData(extensions: themeExtensions), child: widget);
  }

  //  获取主题的配置
  static MXThemeConfig getThemeConfig() {
    return MXThemeConfig.cacheThemeConfig();
  }

  static MXThemeConfig of([BuildContext? context]) {
    try {
      if (context != null) {
        var data =
            Theme.of(context).extensions[MXThemeConfig] as MXThemeConfig?;
        return data ?? MXThemeConfig.cacheThemeConfig();
      }
    } catch (e) {
      return MXThemeConfig.cacheThemeConfig();
    }

    return MXThemeConfig.cacheThemeConfig();
  }
}

class MXThemeConfig extends ThemeExtension<MXThemeConfig> {
  static const String _themeName = 'rawThemeConfig';

  static MXThemeConfig? _cacheThemeConfig;

  /// 主题的名字
  late String name;

  /// 主题的样式
  late Map<String, Color> colorsMap;

  /// 间隔的样式
  late Map<String, double> spacesMap;

  /// 圆角的样式
  late Map<String, double> radiusMap;

  /// 文字的样式
  late Map<String, MXFontStyle> fontsMap;

  /// 文字的字体
  late Map<String, FontFamily> fontFamilyMap;

  /// 阴影
  late Map<String, List<BoxShadow>?> showdowsMap;

  MXThemeConfig(
      {required this.name,
      required this.colorsMap,
      required this.radiusMap,
      required this.spacesMap,
      required this.fontsMap,
      required this.fontFamilyMap,
      required this.showdowsMap});

  /// [customThemeConfig] 自定义的主题配置，须符合rawThemeConfig的数据格式（可选）
  static MXThemeConfig cacheThemeConfig(
      {Map<String, dynamic>? customThemeConfig}) {
    _cacheThemeConfig ??= _fromJSon(_themeName, MXRawTHeme.rawThemeConfig) ??
        _createEmpty((_themeName));

    /// 如果自定义主题的配置存在则替换默认的主题配置
    if (customThemeConfig != null) {
      _copyThemeConfigByCustom(
          _cacheThemeConfig as MXThemeConfig, customThemeConfig);
    }

    return _cacheThemeConfig!;
  }

  /// 拷贝自定义主题配置至主题配置中
  static _copyThemeConfigByCustom(
      MXThemeConfig cacheThemeConfig, Map<String, dynamic> customThemeConfig) {
    customThemeConfig.forEach((key, value) {
      switch (key) {
        case "color":
          Map<String, dynamic> customColorMap = customThemeConfig['color'];
          Map<String, Color> colorsMap = cacheThemeConfig.colorsMap;
          customColorMap.forEach((key, value) {
            if (colorsMap[key] != null) {
              colorsMap[key] = strintToColor(value);
            }
          });
          break;
        case "fonts":
          Map<String, MXFontStyle> customFontsMap = customThemeConfig['fonts'];
          Map<String, MXFontStyle> fontsMap = cacheThemeConfig.fontsMap;
          fontsMap.addAll(customFontsMap);
          break;
        case "fontFamily":
          Map<String, FontFamily> customFontFamilyMap =
              customThemeConfig['fontFamily'];
          Map<String, FontFamily> fontFamilyMap =
              cacheThemeConfig.fontFamilyMap;
          fontFamilyMap.addAll(customFontFamilyMap);
          break;

        default:
      }
    });
  }

  /// 创建空对象
  static MXThemeConfig _createEmpty(String name) {
    return MXThemeConfig(
        name: name,
        colorsMap: {},
        radiusMap: {},
        spacesMap: {},
        fontsMap: {},
        fontFamilyMap: {},
        showdowsMap: {});
  }

  /// [name] 主题名字
  /// [themeJson] 转成字符串的json数据
  static MXThemeConfig? _fromJSon(String name, String themeJson) {
    if (themeJson.isEmpty) return null;

    final Map themeConfig = json.decode(themeJson);

    if (themeConfig.containsKey(name)) {
      final theme = _createEmpty(name);
      Map<String, dynamic> currentTheme = themeConfig[name];

      // 设置颜色
      Map<String, dynamic>? colorsMap = currentTheme['color'];
      // 循环赋值
      colorsMap?.forEach((key, value) {
        theme.colorsMap[key] = strintToColor(value);
      });

      // 设置文字尺寸
      Map<String, dynamic>? fontsMap = currentTheme['fonts'];
      // 循环赋值
      fontsMap?.forEach((key, value) {
        theme.fontsMap[key] =
            MXFontStyle(size: value['size'], lineHeight: value['lineHeight']);
      });
      // 设置文字字体
      Map<String, dynamic>? fontFamilyMap = currentTheme['fontFamily'];
      // 循环赋值
      fontFamilyMap?.forEach((key, value) {
        theme.fontFamilyMap[key] = FontFamily(fontFamily: value['type']);
      });

      // 设置间距
      Map<String, dynamic>? spacesMap = currentTheme['spaces'];
      // 循环赋值
      spacesMap?.forEach((key, value) {
        theme.spacesMap[key] = value.toDouble();
      });

      /// 设置阴影
      Map<String, dynamic>? shadowMap = currentTheme['shadow'];
      // 循环赋值
      shadowMap?.forEach((key, value) {
        var list = <BoxShadow>[];
        for (var element in (value as List)) {
          list.add(BoxShadow(
            color: strintToColor(element['color']),
            blurRadius: element['blurRadius'].toDouble(),
            spreadRadius: element['spreadRadius'].toDouble(),
            offset: Offset(element['offset']?['x'].toDouble() ?? 0,
                element['offset']?['y'].toDouble() ?? 0),
          ));
        }
        theme.showdowsMap[key] = list;
      });

      return theme;
    }
    return null;
  }

  @override
  ThemeExtension<MXThemeConfig> copyWith({
    String? name,
    Map<String, Color>? colorsMap,
    Map<String, double>? radiusMap,
    Map<String, double>? spacesMap,
    Map<String, MXFontStyle>? fontsMap,
    Map<String, List<BoxShadow>>? showdowsMap,
    Map<String, FontFamily>? fontFamilyMap,
  }) {
    var result = MXThemeConfig(
        name: name ?? _themeName,
        colorsMap: _copyConfigItem<Color>(this.colorsMap, colorsMap),
        radiusMap: _copyConfigItem<double>(this.radiusMap, radiusMap),
        spacesMap: _copyConfigItem<double>(this.spacesMap, spacesMap),
        fontsMap: _copyConfigItem<MXFontStyle>(this.fontsMap, fontsMap),
        showdowsMap:
            _copyConfigItem<List<BoxShadow>?>(this.showdowsMap, showdowsMap),
        fontFamilyMap:
            _copyConfigItem<FontFamily>(this.fontFamilyMap, fontFamilyMap));

    return result;
  }

  static Map<String, T> _copyConfigItem<T>(
      Map<String, T> resource, Map<String, T>? needAddMap) {
    var map = <String, T>{};

    resource.forEach((key, value) {
      map[key] = value;
    });

    if (needAddMap != null) {
      map.addAll(needAddMap);
    }

    return map;
  }

  @override
  ThemeExtension<MXThemeConfig> lerp(
      covariant ThemeExtension? other, double t) {
    if (other is! MXThemeConfig) {
      return this;
    }
    return MXThemeConfig(
        name: other.name,
        colorsMap: other.colorsMap,
        radiusMap: other.radiusMap,
        spacesMap: other.spacesMap,
        fontsMap: other.fontsMap,
        fontFamilyMap: other.fontFamilyMap,
        showdowsMap: other.showdowsMap);
  }
}
