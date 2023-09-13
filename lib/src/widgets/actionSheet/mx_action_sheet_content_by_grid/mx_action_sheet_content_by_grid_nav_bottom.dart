import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';

class MXActionSheetContentByGridNavBottom extends StatelessWidget {
  const MXActionSheetContentByGridNavBottom(
      {super.key, required this.activityIndex, required this.totalNum});

  final int activityIndex;
  final int totalNum;

  Widget _buildNavItem(
      BuildContext context, MXThemeConfig config, bool isActivity) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.only(right: config.space8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(config.radiusRound),
          color:
              isActivity ? config.brandPrimaryColor : config.infoPrimaryColor),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];
    MXThemeConfig config = MXTheme.of(context);

    for (var i = 0; i < totalNum; i++) {
      children.add(_buildNavItem(context, config, i == activityIndex));
    }

    return Container(
      padding: EdgeInsets.only(bottom: config.space16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
