import 'package:mx_widget/src/theme/font_type.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';

extension MXFonts on MXThemeConfig {
  /// 字体/行高
  /// 32/48
  MXFontStyle? get fontTitleLarge => fontsMap['fontTitleLarge'];

  /// 28/42
  MXFontStyle? get fontTitleMedium => fontsMap['fontTitleMedium'];

  /// 20/30
  MXFontStyle? get fontTitleSmall => fontsMap['fontTitleSmall'];

  /// 18/28
  MXFontStyle? get fontBodyLarge => fontsMap['fontBodyLarge'];

  /// 16/24
  MXFontStyle? get fontBodyMedium => fontsMap['fontBodyMedium'];

  /// 14/22
  MXFontStyle? get fontBodySmall => fontsMap['fontBodySmall'];

  /// 12/18
  MXFontStyle? get fontInfoLarge => fontsMap['fontInfoLarge'];

  /// 10/16
  MXFontStyle? get fontInfoSmall => fontsMap['fontInfoSmall'];
}
