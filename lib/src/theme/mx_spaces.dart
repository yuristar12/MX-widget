import 'package:mx_widget/src/theme/mx_theme.dart';

/// widget与widget的间隔规范
extension MXSpaces on MXThemeConfig {
  double get space4 => spacesMap['space4'] ?? 4;
  double get space8 => spacesMap['space8'] ?? 8;
  double get space12 => spacesMap['space12'] ?? 12;
  double get space16 => spacesMap['space16'] ?? 16;
  double get space24 => spacesMap['space24'] ?? 24;
  double get space32 => spacesMap['space32'] ?? 32;
  double get space40 => spacesMap['space40'] ?? 40;
  double get space48 => spacesMap['space48'] ?? 48;
  double get space64 => spacesMap['space64'] ?? 64;
  double get space96 => spacesMap['space96'] ?? 96;
  double get space160 => spacesMap['space160'] ?? 160;
}
