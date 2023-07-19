import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';
import 'package:mx_widget/src/widgets/button/mx_button_style.dart';

///------------------------------------------------------------------按钮组件
/// [text] 文字内容
/// [themeEnum] 按钮主题色 品牌色/错误色/警告色/成功色
/// [afterClickButtonCallback] 点击按钮执行的回调方法
/// [afterOnLonePressButtonCallback] 长按按钮执行的回调方法
/// [slot] 按钮的插槽类型为Weight 当设置插槽后无法再继续设置默认icon与自定义icon组件
/// [icon] 使用组件自带的icon组件
/// [disabled] 按钮是否处于禁用状态
/// [customIconWidget] 自定义icon组件
/// [typeEnum] 按钮的类型 填充/文字/外框线
/// [shape] 椭圆/矩形带圆角/圆形
/// [sizeEnum] 按钮的尺寸 大/中/小/迷你
/// [loading] 按钮的loading状态
class MXButton extends StatefulWidget {
  const MXButton(
      {super.key,
      required this.text,
      required this.themeEnum,
      this.slot,
      this.icon,
      this.customWidth,
      this.disabled = false,
      this.customIconWidget,
      this.afterClickButtonCallback,
      this.afterOnLonePressButtonCallback,
      this.shape = MXButtonShapeEnum.rect,
      this.typeEnum = MXButtonTypeEnum.fill,
      this.sizeEnum = MXButtonSizeEnum.medium,
      this.loading = false,
      this.customMargin,
      this.textStyle,
      this.customHeight,
      this.isLine = false});

  /// 按钮文字内容
  final String text;

  /// 按钮插槽。
  final Widget? slot;

  final TextStyle? textStyle;

  /// 按钮类型
  final MXButtonTypeEnum typeEnum;

  /// 按钮尺寸
  final MXButtonSizeEnum sizeEnum;

  /// 按钮主题
  final MXButtonThemeEnum themeEnum;

  /// 按钮的形状
  final MXButtonShapeEnum shape;

  /// 是否禁用按钮
  final bool disabled;

  /// 点击后的方法 (短按)
  final ButtonEvent? afterClickButtonCallback;

  /// 点击后的方法 (长按)
  final ButtonEvent? afterOnLonePressButtonCallback;

  /// 使用组件自带的icon组件
  final IconData? icon;

  /// 自定义的icon组件
  final Widget? customIconWidget;

  /// 自定义按钮的margin距离
  final EdgeInsets? customMargin;

  /// loading状态
  final bool loading;

  /// 自定义高度
  final double? customHeight;

  /// 自定义宽度
  final double? customWidth;

  /// 是否独占一行
  final bool isLine;

  @override
  State<MXButton> createState() => _MXButtonState();
}

class _MXButtonState extends State<MXButton> {
  // 按钮的状态
  MXButtonStatusEnum statusEnum = MXButtonStatusEnum.normal;

  // 用于缓存的样式
  MXButtonStyle? cacheClickStyle;
  // 用于缓存的样式
  MXButtonStyle? cacheDisabledStyle;

  MXButtonStyle? cacheNormalStyle;

  @override

  /// 初始化的时候需要判断按钮是否是处于禁用状态
  void initState() {
    super.initState();
    if (widget.disabled || widget.loading) {
      statusEnum = MXButtonStatusEnum.disabled;
    }
  }

  @override
  void didUpdateWidget(covariant MXButton oldWidget) {
    if (widget.disabled || widget.loading) {
      statusEnum = MXButtonStatusEnum.disabled;
    } else {
      statusEnum = MXButtonStatusEnum.normal;
    }

    if (widget.typeEnum != oldWidget.typeEnum ||
        widget.themeEnum != oldWidget.themeEnum) {}

    setState(() {
      cacheNormalStyle = null;
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return buildButtonBody();
  }

  Widget buildButtonBody() {
    Widget buttonWrap = Container(
      width: _width(),
      height: _height(),
      padding: _padding(context),
      margin: _margin(context),
      decoration: BoxDecoration(
          color: buttonStyle.backgroundColor,
          border: _border(context),
          borderRadius: BorderRadius.all(_radius(context))),
      alignment: Alignment.center,
      child: buildButtonChild(context),
    );

    if (widget.disabled || widget.loading) {
      return buttonWrap;
    }

    return GestureDetector(
      onTap: widget.afterClickButtonCallback,
      onLongPress: widget.afterOnLonePressButtonCallback,
      child: buttonWrap,
      onTapDown: (details) {
        if (widget.disabled || widget.loading) return;
        setState(() {
          statusEnum = MXButtonStatusEnum.click;
        });
      },
      onTapUp: (details) {
        if (widget.disabled || widget.loading) return;
        setState(() {
          statusEnum = MXButtonStatusEnum.normal;
        });
      },
      onTapCancel: () {
        if (widget.disabled || widget.loading) return;
        setState(() {
          statusEnum = MXButtonStatusEnum.normal;
        });
      },
    );
  }

  Widget buildButtonChild(BuildContext context) {
    List<Widget> childrenList = [];

    childrenList.add(_font(context));

    if (widget.slot != null) {
      childrenList.insert(0, widget.slot!);
    } else {
      Widget? icon = _getIcon();
      if (icon != null) {
        childrenList.insert(0, _getIcon()!);
      }
    }

    if (childrenList.length > 1 && widget.shape != MXButtonShapeEnum.circ) {
      childrenList.insert(1, _getSpace(context));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: childrenList,
    );
  }

  MXButtonStyle _getButtonStyleByButtonType() {
    switch (widget.typeEnum) {
      case MXButtonTypeEnum.fill:
        return MXButtonStyle.getFillStyleByTheme(
            context, widget.themeEnum, statusEnum);
      case MXButtonTypeEnum.plain:
        return MXButtonStyle.getPlainStyleByTheme(
            context, widget.themeEnum, statusEnum);
      case MXButtonTypeEnum.outline:
        return MXButtonStyle.getOutlineStyleByTheme(
            context, widget.themeEnum, statusEnum);
      case MXButtonTypeEnum.text:
        return MXButtonStyle.getTextStyleByTheme(
            context, widget.themeEnum, statusEnum, widget.typeEnum);

      case MXButtonTypeEnum.plainText:
        return MXButtonStyle.getTextStyleByTheme(
            context, widget.themeEnum, statusEnum, widget.typeEnum);
    }
  }

  EdgeInsets _padding(BuildContext context) {
    // 如果按钮的形状是圆形或者正方形的话需要居中处理
    var isCenter = widget.shape == MXButtonShapeEnum.circ ||
        widget.shape == MXButtonShapeEnum.square;

    double horizontal;
    double vertical;
    double baseNum;

    switch (widget.sizeEnum) {
      case MXButtonSizeEnum.large:
        baseNum = MXTheme.of(context).space16;
        horizontal = isCenter ? baseNum - 4 : baseNum + 4;
        vertical = baseNum - 4;
        break;
      case MXButtonSizeEnum.medium:
        baseNum = MXTheme.of(context).space16;
        horizontal = isCenter ? baseNum / 2 : baseNum;
        vertical = baseNum / 2;

        break;
      case MXButtonSizeEnum.small:
        baseNum = MXTheme.of(context).space12;
        horizontal = isCenter ? 5 : baseNum;
        vertical = 5;

        break;
      case MXButtonSizeEnum.mini:
        baseNum = MXTheme.of(context).space8;
        horizontal = isCenter ? 3 : baseNum;
        vertical = 3;
        break;
    }

    return EdgeInsets.only(
        left: horizontal, right: horizontal, top: vertical, bottom: vertical);
  }

  EdgeInsets _margin(BuildContext context) {
    return widget.customMargin ?? EdgeInsets.all(MXTheme.of(context).space16);
  }

  /// 按钮的icon图标
  Widget? _getIcon() {
    if (widget.customIconWidget != null) {
      return widget.customIconWidget!;
    } else if (widget.icon != null || widget.loading) {
      // 如果loading状态与icon同时存在优先loading生效
      double size = _fontSize(context).size;
      if (widget.loading) {
        return MXCircleLoading(
          size: size,
          circleColor: MXTheme.of(context).whiteColor,
        );
      }

      return MXIcon(
        useDefaultPadding: false,
        icon: widget.icon!,
        iconColor: buttonStyle.textColor,
        iconFontSize: size,
      );
    }
    return null;
  }

  /// 按钮的间隔
  Widget _getSpace(BuildContext context) {
    return SizedBox(width: MXTheme.of(context).space8);
  }

  /// 按钮的文字
  Widget _font(BuildContext context) {
    return MXText(
      forceVerticalCenter: true,
      data: widget.text,
      font: _fontSize(context),
      style: _fontStyle(context),
    );
  }

  /// 文字的样式
  TextStyle _fontStyle(BuildContext context) {
    // 需要判断是否文字内容为数字

    return widget.textStyle ??
        TextStyle(color: buttonStyle.textColor, fontWeight: FontWeight.bold);
  }

  MXFontStyle _fontSize(BuildContext context) {
    var sizeEnum = widget.sizeEnum;
    switch (sizeEnum) {
      case MXButtonSizeEnum.large:
        return MXTheme.of(context).fontBodyMedium!;
      case MXButtonSizeEnum.medium:
        return MXTheme.of(context).fontBodyMedium!;
      case MXButtonSizeEnum.small:
        return MXTheme.of(context).fontBodySmall!;
      case MXButtonSizeEnum.mini:
        return MXTheme.of(context).fontBodySmall!;
    }
  }

  double? _width() {
    if (widget.customWidth != null) {
      return widget.customWidth;
    }
    var sizeEnum = widget.sizeEnum;

    if (!widget.isLine &&
        (widget.shape == MXButtonShapeEnum.circ ||
            widget.shape == MXButtonShapeEnum.square)) {
      switch (sizeEnum) {
        case MXButtonSizeEnum.large:
          return 50;
        case MXButtonSizeEnum.medium:
          return 44;
        case MXButtonSizeEnum.small:
          return 32;
        case MXButtonSizeEnum.mini:
          return 24;
      }
    }
    return null;
  }

  Radius _radius(BuildContext context) {
    switch (widget.shape) {
      case MXButtonShapeEnum.rect:
      case MXButtonShapeEnum.square:
        return Radius.circular(MXTheme.of(context).radiusMedium - 2);
      case MXButtonShapeEnum.round:
      case MXButtonShapeEnum.circ:
        return Radius.circular(MXTheme.of(context).radiusRound);
    }
  }

  Border? _border(BuildContext context) {
    if (buttonStyle.borderColor != null && buttonStyle.borderWidth != null) {
      return Border.all(
          color: buttonStyle.borderColor!, width: buttonStyle.borderWidth!);
    }
    return null;
  }

  double? _height() {
    if (widget.shape == MXButtonShapeEnum.circ) {
      return _width();
    }
    if (widget.customHeight != null) {
      return widget.customHeight;
    }
    var sizeEnum = widget.sizeEnum;

    switch (sizeEnum) {
      case MXButtonSizeEnum.large:
        return 48;
      case MXButtonSizeEnum.medium:
        return 40;
      case MXButtonSizeEnum.small:
        return 30;
      case MXButtonSizeEnum.mini:
        return 22;
    }
  }

  /// 设置按钮的主题样式
  MXButtonStyle get buttonStyle {
    switch (statusEnum) {
      case MXButtonStatusEnum.normal:
        return _normalStyle;
      case MXButtonStatusEnum.click:
        return _clickStyle;
      case MXButtonStatusEnum.disabled:
        return _disabledStyle;
    }
  }

  MXButtonStyle get _normalStyle {
    if (cacheNormalStyle != null) {
      return cacheNormalStyle!;
    }

    cacheNormalStyle = _getButtonStyleByButtonType();
    return cacheNormalStyle!;
  }

  MXButtonStyle get _clickStyle {
    if (cacheClickStyle != null) {
      return cacheClickStyle!;
    }

    cacheClickStyle = _getButtonStyleByButtonType();
    return cacheClickStyle!;
  }

  MXButtonStyle get _disabledStyle {
    if (cacheDisabledStyle != null) {
      return cacheDisabledStyle!;
    }

    cacheDisabledStyle = _getButtonStyleByButtonType();
    return cacheDisabledStyle!;
  }
}
