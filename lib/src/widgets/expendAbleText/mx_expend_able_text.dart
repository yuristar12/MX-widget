import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mx_widget/mx_widget.dart';

class MXExpendAbleText extends StatefulWidget {
  const MXExpendAbleText({
    super.key,
    this.textStyle,
    this.expendText,
    this.unExpendText,
    required this.text,
    this.maxLines = 1000,
    this.handleTextStyle,
  });

  final String text;

  final int? maxLines;

  final TextStyle? textStyle;

  final TextStyle? handleTextStyle;

  final String? expendText;

  final String? unExpendText;

  @override
  State<MXExpendAbleText> createState() => _MXExpendAbleTextState();
}

class _MXExpendAbleTextState extends State<MXExpendAbleText> {
  bool isExpend = false;

  bool hasEllipsis = false;

  GlobalKey textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  TextStyle _getTextStyle() {
    return widget.textStyle ??
        TextStyle(
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
        maxLines: isExpend ? widget.maxLines : 2,
        textDirection: TextDirection.ltr,
        ellipsis: 'EllipseText');
    tp.layout(maxWidth: maxWidth);

    if (tp.didExceedMaxLines) {
      hasEllipsis = true;
    } else {
      hasEllipsis = false;
    }
  }

  Widget _buildBody() {
    List<Widget> children = [];

    if (!isExpend && hasEllipsis) {
      children.add(Text(
        widget.text,
        key: textKey,
        overflow: TextOverflow.ellipsis,
        maxLines: isExpend ? widget.maxLines : 2,
        style: _getTextStyle(),
      ));
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
              child: MXText(
                data: '更多',
                style: _getHandleTextStyle(),
              ),
            ),
          )));
    } else if (isExpend) {
      // children.add(GestureDetector(
      //   onTap: () {
      //     isExpend = !isExpend;
      //     setState(() {});
      //   },
      //   child: Container(
      //     padding: EdgeInsets.only(
      //         left: MXTheme.of(context).space24,
      //         right: MXTheme.of(context).space8),
      //     child: MXText(
      //       data: '收起',
      //       style: _getHandleTextStyle(),
      //     ),
      //   ),
      // ));
    }

    return SizedBox(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: children,
      ),
    );
  }

  InlineSpan _buildHandleButton() {
    String text;

    if (isExpend) {
      text = widget.expendText ?? '收起';
    } else {
      text = widget.unExpendText ?? '更多';
    }

    // return GestureDetector(
    //   onTap: () {
    //     isExpend = !isExpend;
    //     setState(() {});
    //   },
    //   child: Container(
    //     padding: EdgeInsets.only(
    //         left: MXTheme.of(context).space24,
    //         right: MXTheme.of(context).space8),
    //     child: MXText(
    //       data: text,
    //       style: _getHandleTextStyle(),
    //     ),
    //   ),
    // );
  }

  Widget _buildExpendText() {
    return RichText(
      text: TextSpan(
          text: widget.text,
          style: _getTextStyle(),
          children: [_buildHandleButton()]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      _setHasEllipsis(constraints.maxWidth);
      return _buildBody();
    }));
  }
}
