import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

///----------------------------------------------------------底部导航的每个Item组件

class MXBottomNavBarItem extends StatelessWidget {
  MXBottomNavBarItem({
    super.key,
    this.onTap,
    required this.width,
    required this.height,
    required this.itemNum,
    required this.isSelect,
    required this.navBarTypeEnum,
    required this.navBarShapeEnum,
    required this.navBarItemConfig,
    required this.navBarItemTypeEnum,
  });

  MXBottomNavBarTypeEnum navBarTypeEnum;
  MXBottomNavBarShapeEnum navBarShapeEnum;

  MXBottomNavBarItemTypeEnum navBarItemTypeEnum;
  MXBottomNavBarItemConfig navBarItemConfig;

  double width;
  double height;

  bool isSelect;

  GestureTapCallback? onTap;

  int itemNum;

  Widget _buildText(BuildContext context) {
    String text = '';
    double fontSize;

    switch (navBarTypeEnum) {
      case MXBottomNavBarTypeEnum.text:
        text = navBarItemConfig.mxBottomNavBarTextConfig!.text!;
        fontSize = MXTheme.of(context).fontBodyLarge!.size;
        break;
      case MXBottomNavBarTypeEnum.iconText:
        text = navBarItemConfig.mxBottomNavBarIconTextConfig!.text!;
        fontSize = MXTheme.of(context).fontInfoLarge!.size;
        break;
      default:
        text = '';
        fontSize = MXTheme.of(context).fontBodySmall!.size;
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: isSelect
              ? MXTheme.of(context).brandColor8
              : MXTheme.of(context).fontUsePrimaryColor,
          fontWeight: isSelect ? FontWeight.bold : FontWeight.w500,
          fontSize: fontSize),
    );
  }

  Widget _buildBody(BuildContext context) {
    bool showBackground =
        navBarItemTypeEnum == MXBottomNavBarItemTypeEnum.extrude && isSelect;

    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
                visible: showBackground,
                child: Container(
                  width: width - MXTheme.of(context).space16,
                  decoration: BoxDecoration(
                      color: MXTheme.of(context).brandColor2,
                      borderRadius:
                          BorderRadius.circular(MXTheme.of(context).space24)),
                )),
            Container(
              padding: EdgeInsets.all(
                  navBarTypeEnum == MXBottomNavBarTypeEnum.iconText
                      ? 0
                      : MXTheme.of(context).space4),
              child: _buildNavBarItem(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    Widget widget;

    var type;

    switch (navBarTypeEnum) {
      case MXBottomNavBarTypeEnum.icon:
        type = navBarItemConfig.mxBottomNavBarIconConfig;
        break;
      case MXBottomNavBarTypeEnum.iconText:
        type = navBarItemConfig.mxBottomNavBarIconTextConfig;
        break;
    }

    if (type != null) {
      if (isSelect) {
        widget = type!.selectIcon ??
            MXIcon(
              useDefaultPadding: false,
              icon: Icons.apps_rounded,
              iconFontSize: 24.0,
              iconColor: MXTheme.of(context).brandColor8,
            );
      } else {
        widget = type!.unSelectIcon ??
            MXIcon(
              useDefaultPadding: false,
              icon: Icons.apps_rounded,
              iconFontSize: 24.0,
              iconColor: MXTheme.of(context).fontUsePrimaryColor,
            );
      }
    } else {
      widget = Container();
    }

    return widget;
  }

  Widget _buildBadge() {
    if (navBarItemConfig.mxBottomNavBarItemBadgeConfig != null) {
      return navBarItemConfig.mxBottomNavBarItemBadgeConfig!.show
          ? navBarItemConfig.mxBottomNavBarItemBadgeConfig!.mxBadge!
          : Container();
    }
    return Container();
  }

  Widget _buildNavBarItem(BuildContext context) {
    Widget child;

    switch (navBarTypeEnum) {
      case MXBottomNavBarTypeEnum.icon:
        child = _buildIcon(context);
        break;
      case MXBottomNavBarTypeEnum.text:
        child = _buildText(context);
        break;
      case MXBottomNavBarTypeEnum.iconText:
        child = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildIcon(context), _buildText(context)],
        );
        break;
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
            right:
                navBarItemConfig.mxBottomNavBarItemBadgeConfig?.offsetX ?? -6,
            top: navBarItemConfig.mxBottomNavBarItemBadgeConfig?.offsetX ?? -4,
            child: _buildBadge())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
