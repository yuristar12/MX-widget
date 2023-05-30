import 'package:mx_widget/src/theme/font_type.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';

extension MXFonts on MXThemeConfig {
  /// 字体/行高
  /// 32/48
  FontStyle? get fontTitleLarge => fontsMap['fontTitleLarge'];

  /// 28/42
  FontStyle? get fontTitleMedium => fontsMap['fontTitleMedium'];

  /// 20/30
  FontStyle? get fontTitleSmall => fontsMap['fontTitleSmall'];

  /// 18/28
  FontStyle? get fontBodyLarge => fontsMap['fontBodyLarge'];

  /// 16/24
  FontStyle? get fontBodyMedium => fontsMap['fontBodyMedium'];

  /// 14/22
  FontStyle? get fontBodySmall => fontsMap['fontBodySmall'];

  /// 12/18
  FontStyle? get fontInfoLarge => fontsMap['fontInfoLarge'];

  /// 10/16
  FontStyle? get fontInfoSmall => fontsMap['fontInfoSmall'];
}
