import 'package:mx_widget/src/export.dart';

class MXBottomNavBarItemBadgeConfig {
  MXBottomNavBarItemBadgeConfig(
      {required this.show, this.offsetX, this.offsetY, mxBadge})
      : mxBadge = mxBadge ??
            const MXBadge(
              typeEnum: MXBadgeTypeEnum.point,
            );
  final bool show;

  MXBadge? mxBadge;

  final double? offsetX;

  final double? offsetY;
}
