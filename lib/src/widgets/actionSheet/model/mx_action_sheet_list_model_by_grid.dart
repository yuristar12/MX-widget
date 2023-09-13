import 'package:mx_widget/mx_widget.dart';

class MXActionSheetListModelByGrid extends MXActionSheetListModel {
  MXActionSheetListModelByGrid({
    required super.label,
    required super.value,
    super.icon,
    this.netImgUrl,
    super.badge,
    this.disabled = false,
  });

  final String? netImgUrl;

  final bool disabled;
}
