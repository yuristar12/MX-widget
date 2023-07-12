import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXTextAreaIndicator extends StatelessWidget {
  const MXTextAreaIndicator(
      {super.key, required this.currentLength, this.maxLength});

  final int currentLength;
  final int? maxLength;

  TextStyle _buildTextStyle(BuildContext context) {
    return TextStyle(
        fontSize: MXTheme.of(context).fontInfoLarge!.size,
        color: MXTheme.of(context).fontUseSecondColors);
  }

  Widget _buildText(String text, BuildContext context) {
    return MXText(
      data: text,
      style: _buildTextStyle(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(_buildText(currentLength.toString(), context));

    if (maxLength != null) {
      children.add(_buildText('/', context));
      children.add(_buildText(maxLength.toString(), context));
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children));
  }
}
