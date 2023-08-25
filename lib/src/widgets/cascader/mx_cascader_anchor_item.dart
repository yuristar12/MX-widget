import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

final double bottomPadding = MXTheme.getThemeConfig().space24;

typedef MXCascaderAnchorItemOntap = void Function(String id);

class MXCascaderAnchorItem extends StatelessWidget {
  const MXCascaderAnchorItem({
    super.key,
    required this.id,
    required this.onTap,
    required this.title,
    required this.isLast,
    required this.isActivity,
  });

  final String id;
  final String title;
  final bool isActivity;

  final bool isLast;

  final MXCascaderAnchorItemOntap onTap;

  Widget _buildTitle(BuildContext context) {
    Color color = isActivity
        ? MXTheme.of(context).brandPrimaryColor
        : MXTheme.of(context).fontUsePrimaryColor;

    return MXText(
      data: title,
      maxLines: 1,
      textColor: color,
      fontWeight: isActivity ? FontWeight.bold : FontWeight.w400,
      font: MXTheme.of(context).fontBodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildIcon(BuildContext context) {
    return const MXIcon(
      useDefaultPadding: false,
      icon: Icons.keyboard_arrow_right,
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    children.add(_buildTitle(context));
    children.add(_buildIcon(context));
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call(id);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: isLast ? 0 : bottomPadding),
        child: _buildBody(context),
      ),
    );
  }
}
