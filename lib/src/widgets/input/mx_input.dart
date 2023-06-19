import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/input/mx_input_body.dart';

const double verticalPadding = 8;
const double horizontalPadding = 14;

///--------------------input组件用于输入小段文字，如果需要输入长文本需改换成textarea组件
/// [labelText] 输入框左侧的文字内容
/// [rightWidget] 输入框右侧可以插入widget
/// [useRequire] 是否使用提示符，提醒需要输入
/// [description] 输入框下方的提示内容文字
/// [descriptionColor] 提示内容文字的颜色
/// [formatEnum] 限制input输入框的格式，暂时支持数字
/// [sizeEnum] 输入框的大小
/// [typeEnum] 输入框的样式类型
/// [disabled] input是否禁用（只读）
/// [maxLength] 最大可以输入的字符上限
/// [obscureText] 如果是密码输入框时使用。
/// [autofocus] 是否自动聚焦
/// [textStyle] 输入框文字的样式
/// [focusNode] 是否是聚焦元素节点
/// [textAlign] 输入框文字的排列方式
/// [cursorColor] 游标的颜色
/// [placeholder] 输入框内部无内容时的展位文字
/// [keyboardType] 限制输入的类型
/// [inputBackgroundColor] 输入框的背景颜色
/// [placeholderStyle]  占位内容文字的颜色
/// [decoration] 自定义输入框样式如存在，优先使用
/// [onChange]  control内内容改变时的回调方法
/// [onEditingComplete] 如设置后如果点击键盘的下一个则会取消下个聚焦的[focusNode]元素并且会执行相应的回调函数
/// [controller] input的controller用于获取input中的内容或者对input内容进行操作
/// [onSubmitted] 当点击键盘确认按钮触发的方法并且携带input内容作为形参传入
/// [contentPadding] input内内容的边距
/// [inputFormatters] input输入框的验证方式例如下面只能输入英文且不能超过六个字符。
/// FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
//   LengthLimitingTextInputFormatter(6),
// ],
// ignore: must_be_immutable
class MXInput extends StatelessWidget {
  final MXInputSizeEnum sizeEnum;

  final MXInputTypeEnum typeEnum;

  final bool disabled;

  final bool obscureText;

  final bool autofocus;

  final TextStyle? textStyle;

  final IconData? iconData;

  final FocusNode? focusNode;

  final TextAlign textAlign;

  final String? labelText;

  final Widget? rightWidget;

  final bool? useRequire;

  final String? description;

  final Color? descriptionColor;

  final int? maxLength;

  final Color? cursorColor;
  final String? placeholder;
  final TextInputType? keyboardType;
  final Color? inputBackgroundColor;
  final TextStyle? placeholderStyle;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChange;
  final VoidCallback? onEditingComplete;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsetsGeometry? contentPadding;

  final List<TextInputFormatter>? inputFormatters;

  final MXInputFormatEnum formatEnum;

  bool useBottomDividerLine;

  Color? dividerColor;

  MXInput({
    super.key,
    this.formatEnum = MXInputFormatEnum.norma,
    this.sizeEnum = MXInputSizeEnum.small,
    this.typeEnum = MXInputTypeEnum.norma,
    this.disabled = false,
    this.obscureText = false,
    this.autofocus = false,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.cursorColor,
    this.placeholder,
    this.keyboardType,
    this.inputBackgroundColor,
    this.placeholderStyle,
    this.decoration,
    this.onChange,
    this.onEditingComplete,
    this.controller,
    this.onSubmitted,
    this.contentPadding,
    this.labelText,
    this.useRequire,
    this.rightWidget,
    this.description,
    this.descriptionColor,
    this.inputFormatters,
    this.iconData,
    this.maxLength,
    this.useBottomDividerLine = false,
    this.dividerColor,
  }) : assert(() {
          if (labelText != null && labelText.length > 10) {
            throw FlutterError('使用input组件如果lableText存在字符数必须小于等于10');
          }
          return true;
        }());

  Widget _buildInputLeft(BuildContext context) {
    // 默认28是加上了两边的padding距离左右各个14
    double labelLeftWidth = horizontalPadding * 2;
    List<Widget> children = [];
    Widget label;

    // label文字的内容最大十个字符，否则排列不下，各个字符以16为标准大小一行5个字符也就是80
    // 如果存在icon则需要加上icon的大小24
    // 如果存在useRequire 需要加上14的大小
    if (iconData != null) {
      labelLeftWidth += 24;

      children.add(Row(
        children: [
          MXIcon(
            icon: iconData!,
            iconFontSize: 22,
            useDefaultPadding: false,
          ),
          Visibility(
              visible: labelText != null,
              child: const SizedBox(
                width: 8,
              ))
        ],
      ));
    }

    if (labelText != null) {
      double fontWidth = 0;

      if (labelText!.length > 5) {
        fontWidth = 80;
      } else {
        fontWidth = labelText!.length * 16;
      }

      labelLeftWidth += fontWidth;

      label = SizedBox(
        width: fontWidth,
        child: MXText(
          data: labelText!,
          maxLines: 2,
          font: MXTheme.of(context).fontBodyMedium!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: MXTheme.of(context).fontUsePrimaryColor,
          ),
        ),
      );

      children.add(label);
    }

    if (useRequire != null) {
      labelLeftWidth += 14;

      children.add(Text('*',
          style: TextStyle(
              fontSize: MXTheme.of(context).fontBodySmall!.size,
              color: MXTheme.of(context).errorPrimaryColor)));
    }

    double padding = _getContentPadding(context);

    return Container(
      width: labelLeftWidth,
      padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: padding,
          top: padding),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children),
    );
  }

  Widget _buildInputRight(BuildContext context) {
    double padding = _getContentPadding(context);
    return Container(
      padding: EdgeInsets.only(
          right: horizontalPadding, bottom: padding, top: padding),
      child: rightWidget!,
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    return textStyle ??
        TextStyle(
          color: MXTheme.of(context).fontUsePrimaryColor,
          fontSize: sizeEnum == MXInputSizeEnum.lager
              ? MXTheme.of(context).fontBodyLarge!.size
              : MXTheme.of(context).fontBodyMedium!.size,
        );
  }

  Color _getCursorColor(BuildContext context) {
    return cursorColor ?? MXTheme.of(context).brandPrimaryColor;
  }

  Color _getBackgroundColor(BuildContext context) {
    return inputBackgroundColor ?? MXTheme.of(context).whiteColor;
  }

  TextStyle _getPlaceholderStyle(BuildContext context) {
    return placeholderStyle ??
        TextStyle(
            color: MXTheme.of(context).fontUseIconColor,
            fontSize: MXTheme.of(context).fontBodyMedium!.size);
  }

  double _getContentPadding(BuildContext context) {
    double space = 0;

    switch (sizeEnum) {
      case MXInputSizeEnum.lager:
        space = MXTheme.of(context).space12;
        break;
      case MXInputSizeEnum.small:
        space = MXTheme.of(context).space8;
        break;
    }

    return space;
  }

  TextStyle _getDescriptionStyle(BuildContext context) {
    return TextStyle(
        color: descriptionColor ?? MXTheme.of(context).fontUseSecondColors,
        fontSize: MXTheme.of(context).fontInfoLarge!.size);
  }

  Widget _buildInputCenter(BuildContext context) {
    List<Widget> children = [];

    children.add(
      MXInputBody(
        disabled: disabled,
        obscureText: obscureText,
        maxLines: typeEnum == MXInputTypeEnum.twoLine ? 2 : 1,
        autofocus: autofocus,
        textStyle: _getTextStyle(context),
        focusNode: focusNode,
        textAlign: textAlign,
        cursorColor: _getCursorColor(context),
        placeholder: placeholder,
        keyboardType: keyboardType,
        inputBackgroundColor: inputBackgroundColor,
        placeholderStyle: _getPlaceholderStyle(context),
        decoration: decoration,
        onChange: onChange,
        onEditingComplete: onEditingComplete,
        controller: controller,
        onSubmitted: onSubmitted,
        contentPadding: contentPadding ??
            EdgeInsets.only(
                top: _getContentPadding(context),
                bottom: _getContentPadding(context)),
        inputFormatters: _getFormatter(),
      ),
    );

    if (description != null) {
      children.add(Column(
        children: [
          Text(
            description!,
            style: _getDescriptionStyle(context),
          ),
          SizedBox(
            height: _getContentPadding(context),
          )
        ],
      ));
    }

    if (useBottomDividerLine) {
      children.add(MXDivideLine(
        height: 1,
        color: dividerColor ?? MXTheme.of(context).infoPrimaryColor,
      ));
    }

    return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.only(right: horizontalPadding),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children),
        ));
  }

  Widget _buildNormaInput(BuildContext context) {
    List<Widget> list = [];

    if (labelText != null || iconData != null || useRequire != null) {
      list.add(_buildInputLeft(context));
    } else {
      list.add(Container(
        padding: const EdgeInsets.only(right: horizontalPadding),
      ));
    }

    list.add(_buildInputCenter(context));

    if (rightWidget != null) {
      list.add(_buildInputRight(context));
    }

    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;

    if (description != null) {
      crossAxisAlignment = CrossAxisAlignment.start;
    }

    if (labelText != null) {
      if (labelText!.length > 5) {
        crossAxisAlignment = CrossAxisAlignment.start;
      }
    }

    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.start,
      children: list,
    );
  }

  List<TextInputFormatter>? _getFormatter() {
    List<TextInputFormatter> formatter = inputFormatters ?? [];

    // 判断是否有输入最大限制数量
    if (maxLength != null) {
      formatter.add(LengthLimitingTextInputFormatter(maxLength!));
    }

    if (formatEnum == MXInputFormatEnum.number) {
      formatter.add(FilteringTextInputFormatter.allow(RegExp('[0-9]')));
    }

    return formatter;
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (typeEnum) {
      case MXInputTypeEnum.norma:
        child = _buildNormaInput(context);
        break;
      case MXInputTypeEnum.twoLine:
        child = _buildNormaInput(context);
        break;
    }

    return Container(
      color: _getBackgroundColor(context),
      padding:
          const EdgeInsets.only(top: verticalPadding, bottom: verticalPadding),
      child: child,
    );
  }
}
