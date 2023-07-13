import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

final paddingSpace = MXTheme.getThemeConfig().space16;

const double radiusSize = 18;

const double activityLineHeight = 14;

class MXSideBarItem extends StatelessWidget {
  const MXSideBarItem(
      {super.key,
      required this.model,
      required this.isActivity,
      required this.index,
      required this.listLength,
      required this.onTap});

  final MXSideBarItemModel model;

  final bool isActivity;

  final int index;

  final int listLength;

  final VoidCallback onTap;

  bool get _isFirst {
    return index == 0;
  }

  Widget _buildIcon(BuildContext context) {
    return MXIcon(
      useDefaultPadding: false,
      icon: model.icon!,
      iconFontSize: 18,
      iconColor: isActivity
          ? MXTheme.of(context).brandPrimaryColor
          : MXTheme.of(context).fontUseIconColor,
    );
  }

  Widget _buildContent(BuildContext context) {
    List<Widget> children = [];

    if (model.icon != null) {
      children.add(_buildIcon(context));
      children.add(SizedBox(
        width: paddingSpace / 4,
      ));
    }

    children.add(_buildTitle(context));

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 103),
      child: Container(
        margin: EdgeInsets.all(paddingSpace),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return MXText(
        maxLines: 1,
        data: model.title,
        overflow: TextOverflow.ellipsis,
        font: MXTheme.of(context).fontBodyMedium,
        textColor: isActivity
            ? MXTheme.of(context).brandPrimaryColor
            : MXTheme.of(context).fontUsePrimaryColor,
        fontWeight: isActivity ? FontWeight.bold : FontWeight.w300);
  }

  Widget _buildActivityRadiusByTopRight(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: Transform.translate(
          offset: const Offset(0, -radiusSize),
          child: Container(
            width: radiusSize,
            height: radiusSize,
            decoration: BoxDecoration(
              color: MXTheme.of(context).whiteColor,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: radiusSize,
                    height: radiusSize,
                    decoration: BoxDecoration(
                        color: MXTheme.of(context).infoColor1,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(radiusSize / 2))),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildActivityRadiusByBottomRight(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Transform.translate(
          offset: const Offset(0, radiusSize),
          child: Container(
            width: radiusSize,
            height: radiusSize,
            decoration: BoxDecoration(
              color: MXTheme.of(context).whiteColor,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: radiusSize,
                    height: radiusSize,
                    decoration: BoxDecoration(
                        color: MXTheme.of(context).infoColor1,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(radiusSize / 2))),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildActivityLine(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MXTheme.of(context).radiusMedium),
          color: MXTheme.of(context).brandPrimaryColor,
        ),
        height: activityLineHeight,
      ),
    );
  }

  Widget _buildPositionContent(BuildContext context) {
    List<Widget> children = [];

    children.add(_buildActivityLine(context));

    if (!_isFirst) {
      children.add(_buildActivityRadiusByTopRight(context));
    }

    children.add(_buildActivityRadiusByBottomRight(context));

    return Positioned.fill(
        child: Stack(
      children: children,
    ));
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    if (isActivity) {
      children.add(_buildPositionContent(context));
    }

    children.add(_buildContent(context));

    return Container(
        color: isActivity ? MXTheme.of(context).whiteColor : Colors.transparent,
        child: Stack(children: children));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _buildBody(context),
    );
  }
}
