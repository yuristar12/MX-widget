import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mx_widget/src/theme/font_type.dart';
import 'package:mx_widget/src/theme/mx_colors.dart';
import 'package:mx_widget/src/theme/mx_fonts.dart';
import 'package:mx_widget/src/theme/mx_radius.dart';
import 'package:mx_widget/src/theme/mx_spaces.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';
import '../../config/global_enum.dart';

///-----------------------------------------------------------------------徽标组件
/// [badgeCount] 微标显示的数字
/// [text] 微标显示的内容文字 一般用于文字样式或者角标样式
/// [typeEnum] 微标样式 point/text/square/cornerMark/红点/文字样式/正方形形/角标
/// [sizeEnum] 微标大小 large/small/大/小
/// [radiusEnum] 微标圆角大小 large/small/大/小
/// [badgeColor] 微标颜色
/// [trapezoidX] 角标梯形横轴坐标
/// [trapezoidY] 角标梯形竖轴坐标

class MXBadge extends StatefulWidget {
  const MXBadge({
    super.key,
    this.text,
    this.badgeCount,
    this.badgeColor,
    this.trapezoidX = 32,
    this.trapezoidY = 12,
    this.typeEnum = MXBadgeTypeEnum.point,
    this.sizeEnum = MXBadgeSizeEnum.small,
    this.radiusEnum = MXBadgeRadiusEnum.small,
  });

  /// 微标显示的数字
  final int? badgeCount;

  /// 微标显示的内容文字 一般用于文字样式或者角标样式
  final String? text;

  /// 微标样式 point/text/square/cornerMark/红点/文字样式/正方形形/角标
  final MXBadgeTypeEnum typeEnum;

  /// 微标大小 large/small/大/小
  final MXBadgeSizeEnum sizeEnum;

  /// 微标圆角大小 large/small/大/小
  final MXBadgeRadiusEnum radiusEnum;

  /// 微标颜色
  final Color? badgeColor;

  /// 角标梯形x
  final double trapezoidX;

  /// 角标梯形y

  final double trapezoidY;

  @override
  State<MXBadge> createState() => _MXBadgeState();
}

class _MXBadgeState extends State<MXBadge> {
  String badgeCount = '';

  @override
  void initState() {
    super.initState();
    updateBadgeCount(widget.badgeCount);
  }

  /// 更新徽标内容
  void updateBadgeCount(int? rawBadgeCount) {
    if (rawBadgeCount != null) {
      setState(() {
        badgeCount = rawBadgeCount.toString();
      });
    }
  }

  @override
  void didUpdateWidget(covariant MXBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.badgeCount != oldWidget.badgeCount) {
      updateBadgeCount(widget.badgeCount);
    }
  }

  double _getBadgeRadius() {
    switch (widget.radiusEnum) {
      case MXBadgeRadiusEnum.large:
        return 8;
      case MXBadgeRadiusEnum.small:
        return 4;
    }
  }

  double _getBadgeSize() {
    switch (widget.sizeEnum) {
      case MXBadgeSizeEnum.large:
        return 20;
      case MXBadgeSizeEnum.small:
        return 16;
    }
  }

  FontStyle? _getFontStyle(BuildContext context) {
    switch (widget.sizeEnum) {
      case MXBadgeSizeEnum.large:
        return MXTheme.of(context).fontInfoLarge;
      case MXBadgeSizeEnum.small:
        return MXTheme.of(context).fontInfoSmall;
    }
  }

  Widget _getText(BuildContext context) {
    return Text(
      widget.text ?? badgeCount,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: MXTheme.of(context).whiteColor,
        fontSize: _getFontStyle(context)!.size,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildBadgeBody(BuildContext context) {
    switch (widget.typeEnum) {
      case MXBadgeTypeEnum.point:
        return Container(
          width: _getBadgeSize() / 2,
          height: _getBadgeSize() / 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(MXTheme.of(context).radiusExtraLarge),
              color:
                  widget.badgeColor ?? MXTheme.of(context).errorPrimaryColor),
        );

      case MXBadgeTypeEnum.text:
        return Container(
          width: badgeCount.length == 1 ? _getBadgeSize() : null,
          height: _getBadgeSize(),
          padding: badgeCount.length == 1
              ? null
              : EdgeInsets.only(
                  left: MXTheme.of(context).space4,
                  right: MXTheme.of(context).space4),
          decoration: BoxDecoration(
            color: widget.badgeColor ?? MXTheme.of(context).errorPrimaryColor,
            borderRadius:
                BorderRadius.circular(MXTheme.of(context).radiusExtraLarge),
          ),
          child: Center(child: _getText(context)),
        );

      case MXBadgeTypeEnum.square:
        return Container(
          width: badgeCount.length == 1 ? _getBadgeSize() : null,
          height: _getBadgeSize(),
          padding: EdgeInsets.only(
              left: MXTheme.of(context).space4,
              right: MXTheme.of(context).space4),
          decoration: BoxDecoration(
              color: widget.badgeColor ?? MXTheme.of(context).errorPrimaryColor,
              borderRadius: widget.sizeEnum == MXBadgeSizeEnum.large
                  ? BorderRadius.circular(MXTheme.of(context).radiusMedium)
                  : BorderRadius.circular(MXTheme.of(context).radiusDefault)),
          child: Center(
            child: _getText(context),
          ),
        );

      case MXBadgeTypeEnum.cornerMark:
        return ClipPath(
          clipper: trapezoidClip(widget.trapezoidX, widget.trapezoidY),
          child: Center(
            child: Container(
              alignment: Alignment.centerRight,
              color: MXTheme.of(context).errorPrimaryColor,
              width: widget.trapezoidX,
              height: widget.trapezoidX,
              child: Transform.rotate(
                angle: pi / 4,
                child: Padding(
                  padding: EdgeInsets.only(bottom: MXTheme.of(context).space12),
                  child: _getText(context),
                ),
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBadgeBody(context);
  }
}

// ignore: camel_case_types
class trapezoidClip extends CustomClipper<Path> {
  late double trapezoidX;

  late double trapezoidY;

  trapezoidClip(this.trapezoidX, this.trapezoidY);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(trapezoidX - trapezoidY, 0);
    path.lineTo(trapezoidX, trapezoidY);
    path.lineTo(trapezoidX, trapezoidX);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
