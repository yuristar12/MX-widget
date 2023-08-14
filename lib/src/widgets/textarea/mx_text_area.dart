import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/input/mx_input_body.dart';
import 'package:mx_widget/src/widgets/textarea/mx_text_area_indicator.dart';

class MXTextArea extends StatefulWidget {
  const MXTextArea(
      {super.key,
      this.label,
      this.autoHeight = false,
      this.maxLines = 5,
      this.maxLength,
      required this.controller,
      this.type = MXTextAreaTypeEnum.norma,
      this.size = MXTextAreaSizeEnum.medium,
      this.alignment = MXTextAreaAlignmentEnum.horizontal,
      this.autoFocus = false,
      this.focusNode,
      this.placeholder = '请输入内容',
      this.disabled = false,
      this.useIndicator = false,
      this.backgroundColor,
      this.textStyle,
      this.useBorder = false,
      this.onChange,
      this.onEditingComplete,
      this.onSubmitted,
      this.onMaxLengthCallback,
      this.space = 16});

  final String placeholder;

  final TextEditingController controller;

  final String? label;

  final bool autoHeight;

  final bool autoFocus;

  final FocusNode? focusNode;

  final MXTextAreaTypeEnum type;

  final MXTextAreaSizeEnum size;

  final TextStyle? textStyle;

  final bool disabled;

  final int maxLines;

  final int? maxLength;

  final MXTextAreaAlignmentEnum alignment;

  final Color? backgroundColor;

  final bool useIndicator;

  final bool useBorder;

  final ValueChanged<String>? onChange;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String>? onSubmitted;

  final VoidCallback? onMaxLengthCallback;

  final double space;

  @override
  State<MXTextArea> createState() => _MXTextAreaState();
}

class _MXTextAreaState extends State<MXTextArea> {
  int currentLength = 0;

  @override
  void initState() {
    if (widget.controller.text.isNotEmpty) {
      currentLength = widget.controller.text.length;
    }

    super.initState();
  }

  TextStyle _getTextStyle(BuildContext context) {
    return widget.textStyle ??
        TextStyle(
            fontSize: MXTheme.of(context).fontBodySmall!.size,
            color: MXTheme.of(context).fontUsePrimaryColor);
  }

  Color _getBackgroundColor(BuildContext context) {
    return widget.backgroundColor ?? MXTheme.of(context).whiteColor;
  }

  Widget _buildLabel(BuildContext context) {
    EdgeInsets margin;

    if (widget.alignment == MXTextAreaAlignmentEnum.vertical) {
      margin = EdgeInsets.only(
          left: widget.space, right: widget.space, top: widget.space);
    } else {
      margin = EdgeInsets.only(top: widget.space, left: widget.space);
    }

    return Container(
        margin: margin,
        child: MXText(
          data: widget.label,
          style: _getTextStyle(context),
        ));
  }

  Widget _buildTextContent(BuildContext context) {
    EdgeInsets margin;

    if (widget.alignment == MXTextAreaAlignmentEnum.vertical) {
      double vertical = widget.space / 2;

      margin = EdgeInsets.only(
          top: vertical,
          bottom: vertical,
          left: widget.space,
          right: widget.space);
    } else {
      margin = EdgeInsets.only(
          top: widget.space,
          bottom: widget.space,
          left: widget.space,
          right: widget.space);
    }

    Widget input = MXInputBody(
      inputBackgroundColor: _getBackgroundColor(context),
      textStyle: _getTextStyle(context),
      disabled: widget.disabled,
      autofocus: widget.autoFocus,
      focusNode: widget.focusNode,
      maxLines: widget.autoHeight ? null : widget.maxLines,
      keyboardType: widget.autoHeight ? TextInputType.multiline : null,
      maxLength: widget.maxLength,
      placeholder: widget.placeholder,
      countIndicator: MXTextAreaIndicator(
        currentLength: currentLength,
        maxLength: widget.maxLength,
      ),
      onChange: (value) {
        if (widget.useIndicator) {
          setState(() {
            currentLength = value.length;

            if (widget.onMaxLengthCallback != null) {
              if (currentLength == widget.maxLength) {
                widget.onMaxLengthCallback?.call();
              }
            }
          });
        }
        widget.onChange?.call(value);
      },
      onSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
      contentPadding: EdgeInsets.all(widget.useBorder ? widget.space / 2 : 0),
    );

    if (widget.autoFocus) {
      input = ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 65),
        child: input,
      );
    }

    Widget child;

    if (widget.useIndicator) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          input,
        ],
      );
    } else {
      child = input;
    }

    return Container(
      margin: margin,
      decoration: BoxDecoration(
          border: widget.useBorder
              ? Border.all(
                  width: 1,
                  color: MXTheme.of(context).infoPrimaryColor,
                )
              : null),
      child: child,
    );
  }

  Widget _buildBody(BuildContext context) {
    if (widget.label != null) {
      if (widget.alignment == MXTextAreaAlignmentEnum.horizontal) {
        return Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabel(context),
            Flexible(fit: FlexFit.tight, child: _buildTextContent(context))
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildLabel(context), _buildTextContent(context)],
        );
      }
    } else {
      return _buildTextContent(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getBackgroundColor(context),
      child: _buildBody(context),
    );
  }
}
