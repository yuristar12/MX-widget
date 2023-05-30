import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/widgets/checkBox/mx_check_base_series.dart';

///--------------------------------------------------------------------单选框组件
/// [title] 主要文字内容
/// [desSub] 描述文字内容，布局在主文字下方
/// [iconSpace] icon与内容的间距
/// [iconBuilder] 自定义icon的weiget构建方法
/// [backgroundColor] 单选框的背景颜色
/// [iconSize] icon的大小默认为22
/// [disabled] 按钮是否处于禁用状态
/// [contentBuilder] 自定义内容的weiget构建方法
/// [checked] 初始化时的选中状态
/// [disabled] 单选框是否可以使用
/// [showDivide] 是否在下方渲染分割线
/// [titleMaxLine] 主要文字的渲染行数，超过则显示省略号
/// [desSubMaxLine] 次要文字的渲染行数，超过则显示省略号
/// [onCheckBoxValueChange] 当选中状态发生变更时的回调函数
/// [sizeEnum] 单选框的大小 lager/medium
/// [modeEnum] 单选框的模式 circle/square/card
/// [directionEnum] 单选框的排列方式，left/right

class MXCheckBox extends StatefulWidget {
  const MXCheckBox({
    super.key,
    this.id,
    this.title,
    this.desSub,
    this.iconSpace,
    this.iconBuilder,
    this.backgroundColor,
    this.iconSize = 22,
    this.contentBuilder,
    this.checked = false,
    this.disabled = false,
    this.showDivide = true,
    this.titleMaxLine = 1,
    this.desSubMaxLine = 1,
    this.onCheckBoxValueChange,
    this.sizeEnum = MXCheckBoxSizeEnum.lager,
    this.modeEnum = MXCheckBoxModeEnum.square,
    this.directionEnum = MXCheckBoxDirectionEnum.right,
  });

  final String? title;

  final String? desSub;

  final bool disabled;

  final bool checked;

  final String? id;

  final bool showDivide;

  final int titleMaxLine;

  final int desSubMaxLine;

  final MXCheckBoxSizeEnum sizeEnum;

  final MXCheckBoxModeEnum modeEnum;

  final double? iconSpace;

  final Color? backgroundColor;

  final MXCheckBoxDirectionEnum directionEnum;

  final IconBuilder? iconBuilder;

  final ContentBuilder? contentBuilder;

  final OnCheckBoxValueChange? onCheckBoxValueChange;

  final double iconSize;

  @override
  State<MXCheckBox> createState() => _MXCheckBoxState();
}

class _MXCheckBoxState extends State<MXCheckBox> {
  late bool checked;

  @override
  void initState() {
    super.initState();

    setState(() {
      checked = widget.checked;
    });
  }

  void onCheckChanged(bool value, MXCheckBoxBaseSeriesState? seriesState) {
    if (widget.disabled) {
      return;
    }
    setState(() {
      checked = value;
      if (seriesState != null && widget.id != null) {
        seriesState.toggleBySingle(widget.id!, checked,
            notify: true, useChange: true);
      }
      widget.onCheckBoxValueChange?.call(checked);
    });
  }

  Widget? _buildIcon(BuildContext context, bool isChecked,
      MXCheckBoxBaseSeriesState? seriesState) {
    Widget? current;
    IconData? icon;
    Color iconColor;

    var builder = widget.iconBuilder ?? seriesState?.widget.iconBuilder;

    if (builder != null) {
      return builder.call(context, isChecked);
    }

    switch (widget.modeEnum) {
      case MXCheckBoxModeEnum.circle:
        if (checked) {
          icon = Icons.check_circle;
        } else {
          icon = Icons.circle_outlined;
        }
        break;

      case MXCheckBoxModeEnum.square:
        if (checked) {
          icon = Icons.check_box;
        } else {
          icon = Icons.check_box_outline_blank;
        }
        break;

      case MXCheckBoxModeEnum.card:
        icon = null;
        break;
    }

    if (widget.disabled) {
      if (isChecked) {
        iconColor = MXTheme.of(context).brandDisabledColor;
      } else {
        iconColor = MXTheme.of(context).infoDisabledColor;
      }
    } else {
      if (isChecked) {
        iconColor = MXTheme.of(context).brandColor8;
      } else {
        iconColor = MXTheme.of(context).infoColor5;
      }
    }

    if (icon != null) {
      current = MXIcon(
        icon: icon,
        iconColor: iconColor,
        iconFontSize: widget.iconSize,
      );
    }

    return current;
  }

  Widget _buildSubTitle(BuildContext context) {
    if (widget.desSub != null) {
      FontStyle? fontStyle = widget.sizeEnum == MXCheckBoxSizeEnum.lager
          ? MXTheme.of(context).fontBodySmall
          : MXTheme.of(context).fontInfoLarge;

      return Text(
        widget.desSub!,
        maxLines: widget.desSubMaxLine,
        style: TextStyle(
          color: widget.disabled
              ? MXTheme.of(context).fontUseDisabledColor
              : MXTheme.of(context).infoColor6,
          fontSize: fontStyle!.size,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return Container();
  }

  EdgeInsets _getPadding() {
    double space;
    switch (widget.sizeEnum) {
      case MXCheckBoxSizeEnum.lager:
        space = MXTheme.of(context).space16;
        break;
      case MXCheckBoxSizeEnum.small:
        space = MXTheme.of(context).space12;
        break;
    }

    return EdgeInsets.only(top: space, bottom: space);
  }

  Widget _buildContent(
      BuildContext context, MXCheckBoxBaseSeriesState? seriesState) {
    // 获取icon
    Widget? icon = _buildIcon(context, checked, seriesState);

    // 获取文字内容

    Widget? text = _getContent(context, checked, seriesState);
    Widget content;

    if (text != null) {
      double spaceByleft = (MXTheme.of(context).space16 +
          (icon != null
              ? ((widget.iconBuilder != null ||
                          seriesState?.widget.iconBuilder != null)
                      ? 0
                      : MXTheme.of(context).space8) +
                  widget.iconSize
              : 0) +
          (widget.iconSpace ?? MXTheme.of(context).space8));
      switch (widget.directionEnum) {
        case MXCheckBoxDirectionEnum.left:
          content = Stack(alignment: Alignment.bottomCenter, children: [
            Padding(
              padding: _getPadding(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: MXTheme.of(context).space16),
                        child: icon,
                      ),
                      SizedBox(
                        width: widget.iconSpace ?? MXTheme.of(context).space8,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: MXTheme.of(context).space16),
                          child: text,
                        ),
                      )
                    ],
                  ),
                  Visibility(
                      child: Padding(
                    padding: EdgeInsets.only(
                        top: MXTheme.of(context).space4,
                        left: spaceByleft,
                        right: MXTheme.of(context).space16),
                    child: _buildSubTitle(context),
                  ))
                ],
              ),
            ),
            Visibility(
                visible: widget.showDivide &&
                    widget.modeEnum != MXCheckBoxModeEnum.card,
                child:
                    MXDivideLine(margin: EdgeInsets.only(left: spaceByleft))),
          ]);

          break;

        case MXCheckBoxDirectionEnum.right:
          content = Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                  padding: _getPadding(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width -
                                spaceByleft -
                                16,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: MXTheme.of(context).space16),
                              child: text,
                            ),
                          ),
                          SizedBox(
                            width:
                                widget.iconSpace ?? MXTheme.of(context).space8,
                          ),
                          widget.modeEnum == MXCheckBoxModeEnum.card
                              ? const SizedBox()
                              : Padding(
                                  padding: EdgeInsets.only(
                                      right: MXTheme.of(context).space16),
                                  child: icon,
                                ),
                        ],
                      ),
                      Visibility(
                          visible: widget.desSub != null ? false : true,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MXTheme.of(context).space4,
                              left: MXTheme.of(context).space16,
                            ),
                            child: _buildSubTitle(context),
                          ))
                    ],
                  )),
              Visibility(
                  visible: widget.showDivide,
                  child: MXDivideLine(
                      margin:
                          EdgeInsets.only(right: MXTheme.of(context).space16)))
            ],
          );
          break;
      }

      content = GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: content,
        onTap: () {
          onCheckChanged(!checked, seriesState);
        },
      );

      return Container(
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
            border: widget.modeEnum == MXCheckBoxModeEnum.card
                ? Border.all(
                    width: 1.5,
                    color: checked
                        ? MXTheme.of(context).brandColor8
                        : Colors.transparent)
                : null,
            color: widget.backgroundColor ?? MXTheme.of(context).whiteColor,
            borderRadius: widget.modeEnum == MXCheckBoxModeEnum.card
                ? BorderRadius.all(
                    Radius.circular(MXTheme.of(context).radiusMedium))
                : null),
        child: Stack(children: [
          content,
          Positioned(
              top: 0,
              left: 0,
              child: widget.modeEnum == MXCheckBoxModeEnum.card && checked
                  ? RadioCornerIcon(
                      length: 34, radius: MXTheme.of(context).radiusMedium)
                  : Container())
        ]),
      );
    }

    return Container();
  }

  /// 主要渲染title文字内容
  Widget? _getContent(BuildContext context, bool isChecked,
      MXCheckBoxBaseSeriesState? seriesState) {
    Widget? current;

// 如果存在传入的自定义内容则执行自定义builder内容

    var builder = widget.contentBuilder ?? seriesState?.widget.contentBuilder;

    if (builder != null) {
      current = builder.call(context, isChecked);
    }

// 默认的内容
    if (current == null) {
      if (widget.title != null) {
        FontStyle? font = widget.sizeEnum == MXCheckBoxSizeEnum.lager
            ? MXTheme.of(context).fontBodyMedium
            : MXTheme.of(context).fontBodySmall;

        current = Text(
          widget.title!,
          maxLines: widget.titleMaxLine,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: font!.size,
              color: widget.disabled
                  ? MXTheme.of(context).fontUseDisabledColor
                  : MXTheme.of(context).fontUsePrimaryColor),
        );
      }
    }

    return current;
  }

  @override
  Widget build(BuildContext context) {
    final MXCheckBoxBaseSeriesState? seriesState =
        MXCheckBoxBaseSeriesInherited.of(context)?.state;
    final id = widget.id;

    if (seriesState != null && id != null) {
      var stateByChecked = seriesState.getCheckBoxById(id);

      if (stateByChecked != null) {
        checked = stateByChecked;
      } else {
        seriesState.registerCheckBoxById(id, checked);
      }
    }

    return _buildContent(context, seriesState);
  }
}

class RadioCornerIcon extends StatelessWidget {
  final double length;
  final double radius;

  const RadioCornerIcon({Key? key, required this.length, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: length,
      height: length,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomPaint(
            painter: RadioCorner(
                length: length,
                radius: radius,
                fillColor: MXTheme.of(context).brandColor8),
          ),
          const Positioned(
              top: 0,
              left: 0,
              child: MXIcon(
                icon: Icons.check_rounded,
                iconFontSize: 16,
                iconColor: Colors.white,
              ))
        ],
      ),
    );
  }
}

class RadioCorner extends CustomPainter {
  final double length;
  final double radius;
  final Color fillColor;

  RadioCorner(
      {required this.length, required this.radius, required this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..color = fillColor
      ..style = PaintingStyle.fill;
    var rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    var pi = 3.14;
    var path = Path();
    path.moveTo(0, radius);
    path.addArc(
      rect,
      180 * (pi / 180.0),
      90 * (pi / 180.0),
    );
    path.moveTo(radius - 4, 0);
    path.lineTo(length, 0);
    path.lineTo(0, length);
    path.lineTo(0, radius - 4);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
