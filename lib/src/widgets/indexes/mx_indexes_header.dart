import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

typedef MXIndexesOnUpdateFloating = void Function(MXIndexesModel modelItem);

class MXIndexesHeader extends SliverPersistentHeaderDelegate {
  MXIndexesHeader({
    required this.modelItem,
    required this.controller,
    required this.onUpdateFloating,
  });

  final MXIndexesController controller;

  final MXIndexesModel modelItem;

  final MXIndexesOnUpdateFloating onUpdateFloating;

  bool isFloating = false;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    MXThemeConfig mxThemeConfig = MXTheme.of(context);

    Widget childe;

    isFloating = shrinkOffset > 0;

    childe = Container(
        child: controller.headerBuilder != null
            ? controller.headerBuilder!.call(modelItem)
            : Container(
                alignment: Alignment.centerLeft,
                height: controller.headerHeight,
                color: mxThemeConfig.infoPrimaryColor,
                padding: EdgeInsets.symmetric(
                    horizontal: mxThemeConfig.space16,
                    vertical: mxThemeConfig.space4),
                child: MXText(
                  fontWeight: FontWeight.bold,
                  data: modelItem.index,
                  font: mxThemeConfig.fontBodySmall,
                  textColor: isFloating
                      ? mxThemeConfig.brandPrimaryColor
                      : mxThemeConfig.fontUsePrimaryColor,
                ),
              ));

    return childe;
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => controller.headerHeight;

  @override
  bool shouldRebuild(covariant MXIndexesHeader oldDelegate) {
    return false;
  }
}
