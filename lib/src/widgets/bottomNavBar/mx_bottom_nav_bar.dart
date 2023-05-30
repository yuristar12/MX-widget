import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/widgets/bottomNavBar/mx_bottom_nav_bar_item.dart';

class MXBottomNavBar extends StatefulWidget {
  const MXBottomNavBar({
    super.key,
    required this.bottomNavBarTypeEnum,
    required this.bottomNavBarShapeEnum,
    required this.bottomNavBarItemTypeEnum,
    required this.bottomNavBarItemList,
    this.bottomNavBarHeight = 56,
    this.useDivide = true,
    this.divideColor,
    this.useTopBorder,
    this.topBorder,
    this.onTap,
    this.defaultActiviteIndex,
    this.useSafeArea = false,
  });

  final MXBottomNavBarTypeEnum bottomNavBarTypeEnum;
  final MXBottomNavBarShapeEnum bottomNavBarShapeEnum;
  final MXBottomNavBarItemTypeEnum bottomNavBarItemTypeEnum;

  final List<MXBottomNavBarItemConfig> bottomNavBarItemList;

  final double bottomNavBarHeight;

  final bool? useDivide;

  final Color? divideColor;

  final bool? useTopBorder;

  final BorderSide? topBorder;

  final MXBottomNavOnChange? onTap;

  final int? defaultActiviteIndex;

  final bool useSafeArea;

  @override
  State<MXBottomNavBar> createState() => _MXBottomNavBarState();
}

class _MXBottomNavBarState extends State<MXBottomNavBar> {
  int activityIndex = 0;

  void onBottomNavItemClick(int index) {
    if (activityIndex == index) return;
    activityIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.defaultActiviteIndex != null) {
      activityIndex = widget.defaultActiviteIndex!;
      setState(() {});
    }
  }

  Widget _buildBottomNavBarBody(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext content, BoxConstraints constraints) {
      bool isRound =
          widget.bottomNavBarShapeEnum == MXBottomNavBarShapeEnum.round;
      double width =
          double.parse(constraints.biggest.width.toStringAsFixed(1)) -
              MXTheme.of(content).space4 / 2;

      if (isRound) {
        width -= 32;
      }

      double itemWidth = width / widget.bottomNavBarItemList.length - 1;

      return Container(
          alignment: Alignment.center,
          height: widget.bottomNavBarHeight,
          margin: isRound
              ? EdgeInsets.symmetric(horizontal: MXTheme.of(content).space16)
              : null,
          decoration: BoxDecoration(
              color: MXTheme.of(content).whiteColor,
              borderRadius: isRound
                  ? BorderRadius.circular(MXTheme.of(content).space64)
                  : null,
              border: (widget.useTopBorder == true && !isRound)
                  ? Border(
                      top: widget.topBorder ??
                          BorderSide(
                              width: 1, color: MXTheme.of(content).infoColor3))
                  : null),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    List.generate(widget.bottomNavBarItemList.length, (index) {
                  return _buildItem(content, index, itemWidth);
                }),
              ),
              _buildDivideLine(content),
            ],
          ));
    });
  }

  Widget _buildItem(BuildContext context, int index, double width) {
    MXBottomNavBarItemConfig itemConfig = widget.bottomNavBarItemList[index];

    return Container(
      width: width,
      alignment: Alignment.center,
      height: widget.bottomNavBarHeight,
      padding: EdgeInsets.symmetric(vertical: (MXTheme.of(context).space8) - 2),
      child: MXBottomNavBarItem(
          navBarItemConfig: itemConfig,
          navBarItemTypeEnum: widget.bottomNavBarItemTypeEnum,
          navBarShapeEnum: widget.bottomNavBarShapeEnum,
          navBarTypeEnum: widget.bottomNavBarTypeEnum,
          width: width,
          height: widget.bottomNavBarHeight,
          onTap: () {
            onBottomNavItemClick(index);
            widget.onTap?.call(index);
          },
          itemNum: widget.bottomNavBarItemList.length,
          isSelect: activityIndex == index),
    );
  }

  Widget _buildDivideLine(BuildContext context) {
    if (widget.useDivide == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            List.generate(widget.bottomNavBarItemList.length - 1, (index) {
          return MXDivideLine(
            width: 1,
            height: widget.bottomNavBarHeight / 2,
            color: widget.divideColor ?? MXTheme.of(context).infoColor3,
          );
        }),
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _buildBottomNavBarBody(context);

    if (widget.useSafeArea) {
      return Container(
        color: MXTheme.of(context).whiteColor,
        child: SafeArea(child: child),
      );
    } else {
      return child;
    }
  }
}
