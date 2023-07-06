import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../mx_widget.dart';

// ignore: must_be_immutable
class MXAuthCode extends StatefulWidget {
  MXAuthCode({
    super.key,
    this.backgroundColor,
    this.textStyle,
    this.useAutoFocus = true,
    required this.mxAuthCodeController,
  });

  Color? backgroundColor;

  TextStyle? textStyle;

  MXAuthCodeController mxAuthCodeController;

  bool useAutoFocus;

  @override
  State<MXAuthCode> createState() => MXAuthCodeState();
}

class MXAuthCodeState extends State<MXAuthCode> {
  FocusNode keyListenNode = FocusNode();

  bool onDeleteBeforeValueIsEmpty = true;

  @override
  void initState() {
    widget.mxAuthCodeController.state = this;
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    for (var i = 0; i < widget.mxAuthCodeController.focusNodes.length; i++) {
      Widget childrenItem = Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(
                right: i == widget.mxAuthCodeController.codeNum - 1 ? 0 : 8),
            child: MXInput(
              autofocus: widget.useAutoFocus && i == 0,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              textStyle: widget.textStyle ??
                  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MXTheme.of(context).fontTitleLarge!.size,
                      color: MXTheme.of(context).fontUsePrimaryColor),
              useBottomDividerLine: true,
              focusNode: widget.mxAuthCodeController.focusNodes[i],
              onChange: (value) {
                _onInputContentChange(value, i);
              },
              dividerColor: widget.mxAuthCodeController.isError
                  ? MXTheme.of(context).errorPrimaryColor
                  : MXTheme.of(context).fontUseDisabledColor,
              controller: widget.mxAuthCodeController.textControllers[i],
              typeEnum: MXInputTypeEnum.norma,
              formatEnum: MXInputFormatEnum.number,
            ),
          ));

      children.add(childrenItem);
    }

    return Container(
        color: widget.backgroundColor ?? MXTheme.of(context).whiteColor,
        child: Flex(
          direction: Axis.horizontal,
          children: children,
        ));
  }

  void _onInputContentChange(String value, int index) {
    widget.mxAuthCodeController
        .onInputContentChange(value, index, context, this);
  }

  void _onKeyByDelete() {
    if (widget.mxAuthCodeController.activityInputIndex != 0) {
      int preActivityInputIndex =
          widget.mxAuthCodeController.activityInputIndex - 1;

// 如果没有输入则需要清除上一个输入框的值
      if (onDeleteBeforeValueIsEmpty) {
        // 上一个值清空
        widget.mxAuthCodeController.textControllers[preActivityInputIndex]
            .clear();
      }

      // 聚焦上一个input
      widget.mxAuthCodeController.activityInputIndex -= 1;
      onDeleteBeforeValueIsEmpty = false;

      FocusScope.of(context).requestFocus(widget.mxAuthCodeController
          .focusNodes[widget.mxAuthCodeController.activityInputIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: keyListenNode,
      child: _buildBody(context),
      onKey: (value) {
        if (value.runtimeType == RawKeyDownEvent) {
          if (value.logicalKey == LogicalKeyboardKey.backspace) {
            int activityInputIndex =
                widget.mxAuthCodeController.activityInputIndex;

            if (activityInputIndex != 0) {
              var value = widget.mxAuthCodeController
                  .textControllers[activityInputIndex].text;
              if (value.isEmpty) {
                onDeleteBeforeValueIsEmpty = true;
              }
            }
          }
        }

        if (value.runtimeType == RawKeyUpEvent) {
          if (value.logicalKey == LogicalKeyboardKey.backspace) {
            _onKeyByDelete();
          }
        }
      },
    );
  }
}
