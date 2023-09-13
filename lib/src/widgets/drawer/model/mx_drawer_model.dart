import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

typedef DrawerBuild = Widget Function(BuildContext context);

typedef DrawerOptionsClick = void Function(MXDrawerOptionsModel);

class MXDrawerModel {
  MXDrawerModel(
      {this.title,
      this.showOverlay = true,
      this.closeOnOverlayClick = true,
      this.footerBuilder,
      this.onClose,
      this.optionsClick,
      this.size,
      this.middleBuilder,
      this.options,
      this.placement = MXDrawerPlacementEnum.left})
      : assert(() {
          if (middleBuilder == null && options == null) {
            throw FlutterError('内容或者菜单必须存在一个');
          }
          return true;
        }());

  final String? title;

  final bool showOverlay;

  final bool closeOnOverlayClick;

  final VoidCallback? onClose;

  final DrawerBuild? footerBuilder;

  final DrawerBuild? middleBuilder;

  final DrawerOptionsClick? optionsClick;

  final MXDrawerPlacementEnum placement;

  final double? size;

  final List<MXDrawerOptionsModel>? options;
}
