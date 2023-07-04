import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/input/mx_input_body.dart';

import '../../../mx_widget.dart';

///-----------------------------------------------------------------数字步骤计数器
/// [disabled] 禁用步骤器
/// [initValue] 初始化的value
/// [stepperSizeEnum] 步骤器的大小
/// [stepperThemeEnum] 步骤器的样式
/// [controller] 文本控制器用于获取步骤器的值
/// [max] 最大值
/// [step] 每次递增的值默认为1
/// [min] 最小值
/// [onChangeCallback] 改变时的回调方法
/// [inputWidth] 用于单独设置input框的宽度
class MXStepper extends StatefulWidget {
  const MXStepper(
      {super.key,
      this.disabled = false,
      this.initValue = 0,
      this.stepperSizeEnum = MXStepperSizeEnum.small,
      this.stepperThemeEnum = MXStepperThemeEnum.fill,
      required this.controller,
      this.max = 999,
      this.step = 1,
      this.min = 0,
      this.onChangeCallback,
      this.inputWidth});

  final bool disabled;

  final int? initValue;

  final double? inputWidth;

  final int step;

  final MXStepperSizeEnum stepperSizeEnum;

  final MXStepperThemeEnum stepperThemeEnum;

  final TextEditingController controller;

  final MXStepperOnChangeCallback? onChangeCallback;

  final int max;
  final int min;

  @override
  State<MXStepper> createState() => _MXStepperState();
}

class _MXStepperState extends State<MXStepper> {
  bool subsDisabled = false;

  bool addDisabled = false;

  @override
  void didUpdateWidget(covariant MXStepper oldWidget) {
    if (oldWidget.disabled != widget.disabled) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    int? initValue = widget.initValue;
    if (initValue != null) {
      if (initValue <= widget.min) {
        subsDisabled = true;
        widget.controller.value = TextEditingValue(text: widget.min.toString());
      } else if (initValue >= widget.max) {
        addDisabled = true;
        widget.controller.value = TextEditingValue(text: widget.max.toString());
      } else {
        widget.controller.value = TextEditingValue(text: initValue.toString());
      }
    }

    super.initState();
  }

  double _getIconSize() {
    switch (widget.stepperSizeEnum) {
      case MXStepperSizeEnum.medium:
        return 28;
      case MXStepperSizeEnum.small:
        return 26;
      case MXStepperSizeEnum.mini:
        return 22;
    }
  }

  double _getInputWidth() {
    return widget.inputWidth ?? _getIconSize() * 2;
  }

  double _getSpace() {
    return 4;
  }

  double _getBodyWidth() {
    double space = _getSpace() * 2;
    double inputWidth = _getInputWidth();
    double iconSize = _getIconSize() * 2;
    return space + inputWidth + iconSize;
  }

  double _getFontSize() {
    switch (widget.stepperSizeEnum) {
      case MXStepperSizeEnum.medium:
        return 18;
      case MXStepperSizeEnum.small:
        return 16;
      case MXStepperSizeEnum.mini:
        return 12;
    }
  }

  Color _getFontColor(bool disabled) {
    return disabled
        ? MXTheme.of(context).fontUseDisabledColor
        : MXTheme.of(context).fontUsePrimaryColor;
  }

  Color _getBackColor(bool disabled) {
    if (disabled) {
      return MXTheme.of(context).infoDisabledColor;
    } else {
      return widget.stepperThemeEnum == MXStepperThemeEnum.fill
          ? MXTheme.of(context).infoPrimaryColor
          : Colors.transparent;
    }
  }

  Widget _buildHandleLeft() {
    Widget child =
        _buildHandleIcon(Icons.remove, false, subsDisabled || widget.disabled);

    child = GestureDetector(
      onTap: () {
        if (widget.disabled || subsDisabled) return;

        int value = int.parse(widget.controller.value.text);
        value -= widget.step;
        _onSubStep(value);
      },
      child: child,
    );

    return child;
  }

  void _onSubStep(int value) {
    if (value <= widget.min) {
      value = widget.min;
      setState(() {
        subsDisabled = true;
      });
    }

    if (addDisabled) {
      setState(() {
        addDisabled = false;
      });
    }

    _setInputValue(value);
  }

  void _setInputValue(int value) {
    widget.controller.value = TextEditingValue(text: value.toString());

    widget.onChangeCallback?.call(value);
  }

  Widget _buildInput() {
    Color textColor = _getFontColor(widget.disabled);
    return Container(
        color: _getBackColor(widget.disabled),
        width: _getInputWidth(),
        height: _getIconSize(),
        child: Center(
          child: MXInputBody(
            maxLines: 1,
            onTapOutCallback: () {
              _onInputChange(widget.controller.value.text);
            },
            onEditingComplete: () {
              _onInputChange(widget.controller.value.text);
            },
            textAlign: TextAlign.center,
            textStyle: TextStyle(fontSize: _getFontSize(), color: textColor),
            cursorColor: textColor,
            disabled: widget.disabled,
            controller: widget.controller,
            keyboardType: TextInputType.number,
          ),
        ));
  }

  void _onInputChange(value) {
    if (value.isNotEmpty) {
      int change = int.parse(value);

      if (change <= widget.min) {
        _onSubStep(change);
      } else if (change >= widget.max) {
        _onAddStepper(change);
      } else {
        _setInputValue(change);
      }
    }
  }

  Widget _buildHandleRight() {
    Widget child =
        _buildHandleIcon(Icons.add, true, addDisabled || widget.disabled);

    child = GestureDetector(
      onTap: () {
        if (widget.disabled || addDisabled) return;

        int value = int.parse(widget.controller.value.text);
        value += widget.step;
        _onAddStepper(value);
      },
      child: child,
    );

    return child;
  }

  void _onAddStepper(int value) {
    if (value >= widget.max) {
      value = widget.max;
      setState(() {
        addDisabled = true;
      });
    }

    if (subsDisabled) {
      setState(() {
        subsDisabled = false;
      });
    }

    _setInputValue(value);
  }

  Widget _buildHandleIcon(IconData iconData, bool isRight, bool disabled) {
    double size = _getIconSize();
    double radius = MXTheme.of(context).radiusDefault;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: _getBackColor(disabled),
          borderRadius: isRight
              ? BorderRadius.only(
                  topRight: Radius.circular(radius),
                  bottomRight: Radius.circular(radius))
              : BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  bottomLeft: Radius.circular(radius))),
      child: Center(
        child: MXIcon(
          icon: iconData,
          iconColor: _getFontColor(disabled),
          useDefaultPadding: false,
          iconFontSize: _getFontSize(),
        ),
      ),
    );
  }

  Widget _buildStepperBody() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: widget.stepperThemeEnum == MXStepperThemeEnum.bord
                  ? MXTheme.of(context).fontUseSecondColors
                  : Colors.transparent,
              width: 1)),
      width: _getBodyWidth(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildHandleLeft(), _buildInput(), _buildHandleRight()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildStepperBody();
  }
}
