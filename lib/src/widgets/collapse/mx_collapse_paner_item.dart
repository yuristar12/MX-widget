import 'package:flutter/material.dart';

import '../../../mx_widget.dart';

class MXCollapsePanerItem extends StatelessWidget {
  const MXCollapsePanerItem(
      {super.key,
      this.padding,
      this.customColor,
      required this.model,
      required this.useBottomBorder,
      required this.collapseIcon,
      required this.noCollapseIcon,
      required this.isCollapse,
      required this.collapseItemClick});

  final double? padding;

  final Color? customColor;

  final MXCollapsePannerModel model;

  final bool useBottomBorder;

  final IconData collapseIcon;

  final IconData noCollapseIcon;

  final bool isCollapse;

  final VoidCallback collapseItemClick;

  Widget _buildTitle(BuildContext context) {
    Color fontColor = MXTheme.of(context).fontUseSecondColors;
    MXFontStyle fontSize = MXTheme.of(context).fontBodySmall!;
    MXCellModel cellModel = MXCellModel(
        useBorder: false,
        title: model.title,
        note: isCollapse ? model.collapseNotice : model.noCollapseNotice,
        rightIconWidget: MXIcon(
          icon: isCollapse ? collapseIcon : noCollapseIcon,
          useDefaultPadding: false,
          iconColor: fontColor,
          iconFontSize: fontSize.size,
        ));

    return MXCell(
      model: cellModel,
      padding: 0,
    );
  }

  Widget _buildPanner(BuildContext context) {
    Widget pannerWrap = const SizedBox();

    if (isCollapse) {
      if (model.mxCollapsePlacementEnum == MXCollapsePlacementEnum.bottom) {
        pannerWrap = Container(
          margin: EdgeInsets.only(top: padding!),
          padding: EdgeInsets.only(
              top: padding! + padding! / 2, bottom: padding! / 2),
          decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              border: Border(
                  top: BorderSide(
                      width: 1, color: MXTheme.of(context).infoPrimaryColor))),
          child: model.child,
        );
      } else {
        pannerWrap = Container(
          margin: EdgeInsets.only(bottom: padding!),
          padding: EdgeInsets.only(
              top: padding! / 2, bottom: padding! + padding! / 2),
          decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: MXTheme.of(context).infoPrimaryColor))),
          child: model.child,
        );
      }
    }

    return pannerWrap;
  }

  Widget _buildContent(BuildContext context) {
    List<Widget> child = [];
    if (model.mxCollapsePlacementEnum == MXCollapsePlacementEnum.bottom) {
      child.add(_buildTitle(context));
      child.add(_buildPanner(context));
    } else {
      child.add(_buildPanner(context));
      child.add(_buildTitle(context));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: child,
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    return customColor ?? MXTheme.of(context).whiteColor;
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding!),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: useBottomBorder
                        ? MXTheme.of(context).infoPrimaryColor
                        : Colors.transparent)),
            color: _getBackgroundColor(context)),
        child: _buildContent(context));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        collapseItemClick.call();
      },
      child: _buildBody(context),
    );
  }
}
