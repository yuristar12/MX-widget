import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';
import 'package:mx_widget/src/widgets/progress/mx_progress_circ_painter.dart';

class MXProgress extends StatefulWidget {
  MXProgress(
      {super.key,
      this.label,
      this.customRadius,
      this.customUnderColor,
      required this.controller,
      this.successColor,
      this.theme = MXProgressThemeEnum.primary,
      this.gradient,
      this.height,
      this.type = MXProgressTypeEnum.line,
      this.strokeWidth = 6,
      this.circSize = 110})
      : assert(() {
          if (type == MXProgressTypeEnum.circ && strokeWidth > circSize) {
            throw FlutterError('线框宽度不能超过整体大小');
          }
          return true;
        }());

  final Widget? label;
  final Color? customUnderColor;

  final MXProgressController controller;

  final double? customRadius;

  final Color? successColor;

  final MXProgressThemeEnum theme;

  final LinearGradient? gradient;

  final double? height;

  final MXProgressTypeEnum? type;

  final double strokeWidth;

  final double circSize;

  @override
  State<MXProgress> createState() => MXProgressState();
}

class MXProgressState extends State<MXProgress> {
  @override
  void initState() {
    widget.controller.setProgressState(this);

    super.initState();
  }

  void onValueChange() {
    setState(() {});
  }

  Widget _buildBody() {
    if (widget.type == MXProgressTypeEnum.line) {
      return _buildLineBody();
    } else {
      return _buildCircBody();
    }
  }

  Widget _buildLabel() {
    if (widget.type == MXProgressTypeEnum.circ) {
      return Container(
          child: widget.label ??
              MXText(
                isNumber: true,
                data: '${widget.controller.value}%',
                font: MXTheme.of(context).fontTitleSmall,
                fontWeight: FontWeight.bold,
                textColor: MXTheme.of(context).fontUseSecondColors,
              ));
    } else {
      return Container(
          margin: EdgeInsets.only(left: MXTheme.of(context).space8),
          child: widget.label ??
              MXText(
                isNumber: true,
                data: '${widget.controller.value}%',
                font: MXTheme.of(context).fontBodySmall,
                textColor: MXTheme.of(context).fontUseSecondColors,
              ));
    }
  }

  Widget _buildProgressBar(double maxWidth) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: CurveUtil.curve_1(),
        transform:
            Matrix4.diagonal3Values(widget.controller.value / 100, 1.0, 1.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 4),
          child: Container(
            height: widget.height,
            width: maxWidth,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              color: _getProgressBarColor(),
            ),
          ),
        ));
  }

  Color _getProgressBarColor() {
    Color color;

    if (widget.controller.isSuccess) {
      color = widget.successColor ?? MXTheme.of(context).successPrimaryColor;
    } else {
      switch (widget.theme) {
        case MXProgressThemeEnum.primary:
          color = MXTheme.of(context).brandPrimaryColor;
          break;
        case MXProgressThemeEnum.success:
          color = MXTheme.of(context).successPrimaryColor;
          break;
        case MXProgressThemeEnum.error:
          color = MXTheme.of(context).errorPrimaryColor;
          break;
        case MXProgressThemeEnum.warn:
          color = MXTheme.of(context).warnPrimaryColor;
          break;
      }
    }

    return color;
  }

  Widget _buildProgressWrap() {
    return Expanded(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(
                widget.customRadius ?? MXTheme.of(context).radiusDefault),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: 4,
                decoration: BoxDecoration(
                  color: widget.customUnderColor ??
                      MXTheme.of(context).infoPrimaryColor,
                ),
                child: Stack(
                  children: [_buildProgressBar(constraints.maxWidth)],
                ),
              );
            })));
  }

  Widget _buildLineBody() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildProgressWrap(), _buildLabel()],
    );
  }

  Widget _buildCircBody() {
    double wrapSize = widget.circSize;

    return SizedBox(
      width: wrapSize,
      height: wrapSize,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                width: wrapSize,
                height: wrapSize,
                child: CustomPaint(
                  painter: MXProgressCircPainter(
                      useRound: false,
                      radiuValue: pi * 2,
                      strokeWidth: widget.strokeWidth,
                      color: widget.customUnderColor ??
                          MXTheme.of(context).infoPrimaryColor),
                ),
              )),
          Positioned(
              top: 0,
              left: 0,
              child: Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  width: wrapSize,
                  height: wrapSize,
                  child: CustomPaint(
                    painter: MXProgressCircPainter(
                        useRound: true,
                        gradient: widget.gradient,
                        radiuValue: pi * 2 / (100 / widget.controller.value),
                        strokeWidth: widget.strokeWidth,
                        color: _getProgressBarColor()),
                  ),
                ),
              )),
          Positioned(
              child: Center(
            child: _buildLabel(),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
