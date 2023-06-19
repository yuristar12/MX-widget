import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mx_widget/src/theme/mx_colors.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';

///---------------------------------input组件内部使用的组件，简化了原生input需要的参数
/// [disabled] input是否禁用（只读）
/// [obscureText] 如果是密码输入框时使用。
/// [maxLength] 最大可输入限制
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

class MXInputBody extends StatelessWidget {
  const MXInputBody({
    super.key,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.disabled = false,
    this.maxLength,
    this.onChange,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.inputFormatters,
    this.onEditingComplete,
    this.onSubmitted,
    this.cursorColor,
    this.decoration,
    this.placeholder,
    this.maxLines = 1,
    this.placeholderStyle,
    this.inputBackgroundColor,
    this.contentPadding = EdgeInsetsDirectional.zero,
    this.keyboardType,
  });

  final bool disabled;
  final bool obscureText;
  final int? maxLength;
  final bool autofocus;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final Color? cursorColor;
  final String? placeholder;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Color? inputBackgroundColor;
  final TextStyle? placeholderStyle;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChange;
  final VoidCallback? onEditingComplete;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsetsGeometry contentPadding;

  final List<TextInputFormatter>? inputFormatters;

  Widget _buildBody(BuildContext context) {
    return TextField(
      readOnly: disabled,
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      onChanged: onChange,
      style: textStyle,
      maxLines: maxLines,
      keyboardType: keyboardType,
      autofocus: autofocus,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      cursorColor: cursorColor ?? MXTheme.of(context).brandPrimaryColor,
      decoration: decoration ?? _getDecoration(context),
    );
  }

  InputDecoration _getDecoration(BuildContext context) {
    return InputDecoration(
      isCollapsed: true,
      hintText: placeholder,
      hintStyle: placeholderStyle,
      fillColor: inputBackgroundColor,
      contentPadding: contentPadding,
      border: InputBorder.none,
      filled: inputBackgroundColor != null,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
