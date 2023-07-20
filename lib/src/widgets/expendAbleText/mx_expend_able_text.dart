import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';

///------------------------------------------------------------文字多行自动收起组件
///
///[text]文字的内容
///[textStyle] 文字的样式
///[expendText] 需要对文字收起时的操作文案
///[unExpendText] 需要对文字展开时的操作文案
///[maxLines] 文字展开后最大显示的行数
///[handleTextStyle] 操作文案的文字样式
///[ellipseLines] 文字显示省略号的行数条件
///[useAnimation] 是否使用过渡动画
class MXExpendAbleText extends StatefulWidget {
  const MXExpendAbleText(
      {super.key,
      this.textStyle,
      this.expendText,
      this.unExpendText,
      required this.text,
      this.maxLines = 1000,
      this.handleTextStyle,
      this.ellipseLines = 2,
      this.useAnimation = true});

  ///[text]文字的内容
  final String text;

  ///[maxLines] 文字展开后最大显示的行数
  final int? maxLines;

  ///[textStyle] 文字的样式
  final TextStyle? textStyle;

  ///[handleTextStyle] 操作文案的文字样式
  final TextStyle? handleTextStyle;

  ///[expendText] 需要对文字收起时的操作文案
  final String? expendText;

  ///[unExpendText] 需要对文字展开时的操作文案
  final String? unExpendText;

  ///[useAnimation] 是否使用过渡动画
  final bool useAnimation;

  ///[ellipseLines] 文字显示省略号的行数条件
  final int ellipseLines;

  @override
  State<MXExpendAbleText> createState() => _MXExpendAbleTextState();
}

class _MXExpendAbleTextState extends State<MXExpendAbleText> {
  bool isExpend = false;

  bool hasEllipsis = false;

  @override
  void initState() {
    super.initState();
  }

  TextStyle _getTextStyle() {
    return widget.textStyle ??
        TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: MXTheme.of(context).fontBodySmall!.size,
            color: MXTheme.of(context).fontUsePrimaryColor);
  }

  TextStyle _getHandleTextStyle() {
    return widget.handleTextStyle ??
        TextStyle(
            fontSize: MXTheme.of(context).fontBodySmall!.size,
            color: MXTheme.of(context).brandPrimaryColor);
  }

  void _setHasEllipsis(double maxWidth) {
    final span = TextSpan(text: widget.text, style: _getTextStyle());

    final tp = TextPainter(
        text: span,
        maxLines: isExpend ? widget.maxLines : widget.ellipseLines,
        textDirection: TextDirection.ltr,
        ellipsis: 'EllipseText');
    tp.layout(maxWidth: maxWidth);

    if (tp.didExceedMaxLines) {
      hasEllipsis = true;
    } else {
      hasEllipsis = false;
    }
  }

  Widget _buildUnExpendText() {
    return Text(
      widget.text,
      overflow: TextOverflow.ellipsis,
      maxLines: isExpend ? widget.maxLines : widget.ellipseLines,
      style: _getTextStyle(),
    );
  }

  Widget _buildBody() {
    List<Widget> children = [];

    if (hasEllipsis || isExpend) {
      if (isExpend) {
        children.add(_buildExpendText());
      } else {
        children.add(_buildUnExpendText());
        children.add(Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                isExpend = !isExpend;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: MXTheme.of(context).space24,
                    right: MXTheme.of(context).space8),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.white70,
                  MXTheme.of(context).whiteColor
                ])),
                child: Text(
                  widget.unExpendText ?? '更多',
                  style: _getHandleTextStyle(),
                ),
              ),
            )));
      }
    } else {
      children.add(_buildUnExpendText());
    }

    return SizedBox(
      child: Stack(
        children: children,
      ),
    );
  }

  InlineSpan _buildHandleButton() {
    String text;

    text = widget.expendText ?? '收起';

    return WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: GestureDetector(
          onTap: () {
            isExpend = !isExpend;
            setState(() {});
          },
          child: Text(
            text,
            style: _getHandleTextStyle(),
          ),
        ));
  }

  Widget _buildExpendText() {
    return Text.rich(
      TextSpan(
        text: widget.text,
        style: _getTextStyle(),
        children: [_buildHandleButton()],
      ),
      style: _getTextStyle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      _setHasEllipsis(constraints.maxWidth);

      Widget child = _buildBody();

      if (widget.useAnimation) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: CurveUtil.curve_1(),
          child: _buildBody(),
        );
      } else {
        return child;
      }
    }));
  }
}
