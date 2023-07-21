import 'package:flutter/material.dart';

import '../../../mx_widget.dart';

class MXCascaderContentCellItem extends StatelessWidget {
  const MXCascaderContentCellItem({
    super.key,
    required this.model,
    required this.onTap,
    required this.isActivity,
  });

  final MXCascaderOptions model;

  final bool isActivity;

  final VoidCallback onTap;

  Widget _buildIcon(BuildContext context) {
    Color color = isActivity
        ? MXTheme.of(context).brandPrimaryColor
        : MXTheme.of(context).fontUseIconColor;

    return MXIcon(
      icon: Icons.check,
      useDefaultPadding: false,
      iconColor: color,
    );
  }

  Widget _buildText(BuildContext context) {
    Color color = isActivity
        ? MXTheme.of(context).brandPrimaryColor
        : MXTheme.of(context).fontUsePrimaryColor;

    return MXText(
      maxLines: 1,
      textColor: color,
      data: model.label,
      overflow: TextOverflow.ellipsis,
      font: MXTheme.of(context).fontBodyMedium,
      fontWeight: isActivity ? FontWeight.bold : FontWeight.w400,
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    if (isActivity) {
      children.add(_buildIcon(context));
      children.add(SizedBox(
        width: MXTheme.of(context).space8,
      ));
    }

    children.add(_buildText(context));

    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: children);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(MXTheme.of(context).space16),
        child: _buildBody(context),
      ),
    );
  }
}
