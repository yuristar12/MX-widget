import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/countDown/mx_count_down_%20millisecond.dart';

import 'mx_count_down_model.dart';

///-------------------------------------------------------------------倒计时组件
/// [autoStare] 是否自动开始倒计时
/// [controller] 用于控制倒计时，暂停或者恢复倒计时
/// [backgroundColor] 自定义的背景颜色只有当shape不为plain才成立
/// [useUnit] 是否开启中文单位替换默认的：
/// [size] 倒计时大小 mini/medium/lager
/// [shape] 倒计时样式 rect/cirl/plain
/// [format] 倒计时的格式单位 ddhhmmss/ddhhmmsss/hhmmss/hhmmsss 最后携带sss将开启毫秒渲染

class MXCountDown extends StatefulWidget {
  const MXCountDown(
      {super.key,
      this.autoStare = true,
      required this.controller,
      this.backgroundColor,
      this.useUnit = false,
      this.size = MXCountDownSizeEnum.medium,
      this.shape = MXCountDownShapeEnum.plain,
      this.format = MXCountDownFormatEnum.hhmmss});

  final bool autoStare;

  final MXCountDownController controller;

  final MXCountDownFormatEnum format;

  final MXCountDownSizeEnum size;

  final MXCountDownShapeEnum shape;

  final Color? backgroundColor;

  final bool useUnit;

  @override
  State<MXCountDown> createState() => MXCountDownState();
}

class MXCountDownState extends State<MXCountDown> {
  MXFontStyle? _fontSize;

  double? _size;

  @override
  void initState() {
    super.initState();

    widget.controller.setState(this);

    if (widget.autoStare) {
      widget.controller.startDown();
    }
  }

  @override
  void dispose() {
    widget.controller.overTimer();
    super.dispose();
  }

  Color _getFontColor() {
    if (widget.shape == MXCountDownShapeEnum.plain) {
      return MXTheme.of(context).fontUsePrimaryColor;
    } else if (widget.shape == MXCountDownShapeEnum.reverse) {
      return widget.backgroundColor ?? MXTheme.of(context).errorPrimaryColor;
    }

    return MXTheme.of(context).whiteColor;
  }

  Widget _buildUnit({String? val = ":"}) {
    Color fontColor = MXTheme.of(context).fontUsePrimaryColor;
    if (widget.shape == MXCountDownShapeEnum.plain) {
      return Text(
        val!,
        style: TextStyle(fontSize: fontSize.size, color: fontColor),
      );
    }

    if (!widget.useUnit) {
      fontColor = MXTheme.of(context).errorPrimaryColor;
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          val!,
          style: TextStyle(fontSize: fontSize.size, color: fontColor),
        ));
  }

  /// shape 类型为plain 类型
  List<Widget> _buildPlainCountDown() {
    List<Widget> list = [];
    MXCountDownModel model = widget.controller.model!;
    list.add(_buildNumber(model.hour));
    list.add(_buildUnit());
    list.add(_buildNumber(model.minute));
    list.add(_buildUnit());
    list.add(_buildNumber(model.second));

    if (widget.format == MXCountDownFormatEnum.ddhhmmss ||
        widget.format == MXCountDownFormatEnum.ddhhmmsss) {
      list.insert(0, _buildNumber(model.day));
      list.insert(1, _buildUnit());
    }

    String formatStr = widget.format.toString();

    if (formatStr.contains('sss') && !widget.controller.isPause) {
      list.add(_buildUnit());

      /// 需要渲染毫秒级
      list.add(MXCountDownMillsecond(
        fontStyle: _getFontSize(),
        color: _getFontColor(),
      ));
    }

    return list;
  }

  Widget _buildFillWrap(Widget child) {
    Color backgroundColor;

    BorderRadiusGeometry? borderRadius;

    if (widget.shape == MXCountDownShapeEnum.reverse) {
      backgroundColor = Colors.transparent;
    } else {
      backgroundColor =
          widget.backgroundColor ?? MXTheme.of(context).errorPrimaryColor;
      borderRadius = BorderRadius.circular(
          widget.shape == MXCountDownShapeEnum.circ
              ? MXTheme.of(context).radiusRound
              : MXTheme.of(context).radiusDefault);
    }

    return Container(
      width: size,
      height: size,
      decoration:
          BoxDecoration(borderRadius: borderRadius, color: backgroundColor),
      child: Center(
        child: child,
      ),
    );
  }

  /// shape 类型为circ与rect
  List<Widget> _buildFillCountDown() {
    List<Widget> list = [];
    bool useUnit = widget.useUnit;
    MXCountDownModel model = widget.controller.model!;
    list.add(_buildFillWrap(_buildNumber(model.hour)));
    list.add(_buildUnit(val: useUnit ? '时' : ':'));
    list.add(_buildFillWrap(_buildNumber(model.minute)));
    list.add(_buildUnit(val: useUnit ? '分' : ':'));
    list.add(_buildFillWrap(_buildNumber(model.second)));
    if (widget.useUnit) {
      list.add(_buildUnit(val: '秒'));
    }

    if (widget.format == MXCountDownFormatEnum.ddhhmmss ||
        widget.format == MXCountDownFormatEnum.ddhhmmsss) {
      list.insert(0, _buildFillWrap(_buildNumber(model.day)));
      list.insert(1, _buildUnit(val: useUnit ? '天' : ':'));
    }
    String formatStr = widget.format.toString();

    if (formatStr.contains('sss') && !widget.controller.isPause) {
      if (!widget.useUnit) {
        list.add(_buildUnit());
      }

      /// 需要渲染毫秒级
      list.add(_buildFillWrap(MXCountDownMillsecond(
        fontStyle: _getFontSize(),
        color: _getFontColor(),
      )));
    }

    return list;
  }

  Widget _buildNumber(dynamic value) {
    return MXText(
      isLine: false,
      isNumber: true,
      font: fontSize,
      data: value.toString(),
      textColor: _getFontColor(),
    );
  }

  Widget _buildBody() {
    List<Widget> children = [];
    if (widget.shape == MXCountDownShapeEnum.plain) {
      children = _buildPlainCountDown();
    } else {
      children = _buildFillCountDown();
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  void onTimeChange() {
    setState(() {});
  }

  MXFontStyle get fontSize {
    _fontSize ??= _getFontSize();
    return _fontSize!;
  }

  double get size {
    _size ??= _getSize();
    return _size!;
  }

  MXFontStyle _getFontSize() {
    switch (widget.size) {
      case MXCountDownSizeEnum.lager:
        return MXTheme.of(context).fontBodyLarge!;
      case MXCountDownSizeEnum.medium:
        return MXTheme.of(context).fontBodyMedium!;
      case MXCountDownSizeEnum.mini:
        return MXTheme.of(context).fontBodySmall!;
    }
  }

  double _getSize() {
    switch (widget.size) {
      case MXCountDownSizeEnum.lager:
        return 30;
      case MXCountDownSizeEnum.medium:
        return 26;
      case MXCountDownSizeEnum.mini:
        return 22;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(),
    );
  }
}
