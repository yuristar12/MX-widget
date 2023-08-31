import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXUploadMaskByError extends StatelessWidget {
  const MXUploadMaskByError({super.key});

  Widget _buildIcon(BuildContext context) {
    return MXIcon(
      iconFontSize: 24,
      icon: Icons.close_outlined,
      iconColor: MXTheme.of(context).whiteColor,
    );
  }

  Widget _buildText(BuildContext context) {
    return MXText(
      data: '上传失败',
      font: MXTheme.of(context).fontBodySmall,
      textColor: MXTheme.of(context).whiteColor,
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    children.add(_buildIcon(context));

    children.add(_buildText(context));

    return Positioned.fill(
        child: Container(
      color: MXTheme.of(context).mask1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
