import 'package:flutter/material.dart';
import 'package:mx_widget/src/config/global_enum.dart';
import 'package:mx_widget/src/theme/mx_colors.dart';
import 'package:mx_widget/src/theme/mx_fonts.dart';
import 'package:mx_widget/src/theme/mx_spaces.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';
import 'package:mx_widget/src/widgets/icon/mx_icon.dart';
import 'package:mx_widget/src/widgets/switch/mx_switch_container.dart';

///----------------------------------------------------------------switch开关控件
/// [isOn] 是否打开
/// [disabled] 是否禁用
/// [offColor] 关闭时后呈现的颜色
/// [activityColor] 开启后呈现的颜色
/// [sizeEnum] switch的大小
/// [modeEnum] switch的样式fill/icon/text
/// [onChange] 状态改变后的回调函数

class MXSwitch extends StatefulWidget {
  const MXSwitch(
      {super.key,
      this.isOn = false,
      this.disabled = false,
      this.offColor,
      this.activityColor,
      this.sizeEnum = MXSwitchSizeEnum.medium,
      this.modeEnum = MXSwitchModeEnum.fill,
      this.onChange});

// switch 选中的颜色
  final Color? activityColor;

// switch 关闭的颜色
  final Color? offColor;

// switch 大小
  final MXSwitchSizeEnum sizeEnum;

// switch 状态
  final bool isOn;

// switch 是否禁用
  final bool disabled;

// switch 模式
  final MXSwitchModeEnum modeEnum;

  final MXSwitchOnChange? onChange;

  @override
  State<MXSwitch> createState() => _MXSwitchState();
}

class _MXSwitchState extends State<MXSwitch> {
  late bool isOn = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      isOn = widget.isOn;
    });
  }

  @override
  void didUpdateWidget(covariant MXSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isOn != widget.isOn) {
      onChange(widget.isOn);
    }
  }

  void onChange(bool value) {
    isOn = value;
    widget.onChange?.call(isOn);
    setState(() {});
  }

  Color _getActivityColor(BuildContext context) {
    return widget.activityColor ?? MXTheme.of(context).brandColor8;
  }

  Color _getOffColor(BuildContext context) {
    return widget.offColor ?? MXTheme.of(context).infoColor4;
  }

  double _getWidth() {
    double size;
    switch (widget.sizeEnum) {
      case MXSwitchSizeEnum.lager:
        size = 52;
        break;
      case MXSwitchSizeEnum.medium:
        size = 45;
        break;
      case MXSwitchSizeEnum.small:
        size = 39;
        break;
    }
    return size;
  }

  double _getHeight() {
    double size;
    switch (widget.sizeEnum) {
      case MXSwitchSizeEnum.lager:
        size = 32;
        break;
      case MXSwitchSizeEnum.medium:
        size = 28;
        break;
      case MXSwitchSizeEnum.small:
        size = 24;
        break;
    }
    return size;
  }

  Widget? _buildSwitchChild(BuildContext context) {
    Widget? child;

    switch (widget.modeEnum) {
      case MXSwitchModeEnum.fill:
        break;
      case MXSwitchModeEnum.text:
        child = Container(
          padding: EdgeInsets.only(left: MXTheme.of(context).space4 - 1),
          alignment: Alignment.centerLeft,
          child: Text(
            isOn ? '开' : "关",
            style: TextStyle(
                color:
                    isOn ? _getActivityColor(context) : _getOffColor(context),
                fontSize: MXTheme.of(context).fontBodySmall!.size),
          ),
        );
        break;
      case MXSwitchModeEnum.icon:
        child = Container(
            alignment: Alignment.centerLeft,
            child: MXIcon(
              iconFontSize: MXTheme.of(context).fontBodySmall!.size - 2,
              icon: isOn ? Icons.check_rounded : Icons.close_rounded,
            ));
        break;

      default:
    }

    return child;
  }

  Widget _buildSwitch(BuildContext context) {
    Widget current = MXSwitchContainer(
      value: isOn,
      onChanged: onChange,
      activeColor: _getActivityColor(context),
      trackColor: _getOffColor(context),
      thumbChild: _buildSwitchChild(context),
    );

    if (widget.disabled) {
      current = Opacity(
        opacity: 0.4,
        child: IgnorePointer(
          child: current,
        ),
      );
    }

    current = SizedBox(
      width: _getWidth(),
      height: _getHeight(),
      child: FittedBox(child: current),
    );

    return current;
  }

  @override
  Widget build(BuildContext context) {
    return _buildSwitch(context);
  }
}
