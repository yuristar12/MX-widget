import 'package:mx_widget/src/theme/mx_theme.dart';

/// 圆角规范
extension MXRadius on MXThemeConfig {
  /// 圆角大小 4
  double get radiusSmall => radiusMap['radiusSmall'] ?? 4;

  /// 圆角大小 4
  double get radiusDefault => radiusMap['radiusDefault'] ?? 4;

  /// 圆角大小 8
  double get radiusMedium => radiusMap['radiusMedium'] ?? 8;

  /// 圆角大小 16
  double get radiusLarge => radiusMap['radiusLarge'] ?? 16;

  /// 圆角大小 32
  double get radiusExtraLarge => radiusMap['radiusExtraLarge'] ?? 32;

  /// 圆角大小 9999
  double get radiusRound => radiusMap['radiusRound'] ?? 9999;
}
