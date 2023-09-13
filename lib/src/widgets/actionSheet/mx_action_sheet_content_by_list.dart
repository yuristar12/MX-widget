import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/actionSheet/mx_action_sheet_content_by_list_item.dart';
import 'package:mx_widget/src/widgets/actionSheet/mx_action_sheet_footer_button.dart';

const double maxHeight = 560;

class MXActionSheetContentByList extends StatelessWidget {
  const MXActionSheetContentByList(
      {super.key,
      required this.actionList,
      required this.closeText,
      required this.onClose,
      required this.confirm});

  final List<MXActionSheetListModel> actionList;

  final String closeText;

  final VoidCallback onClose;

  final MXActionSheetConfirm confirm;

  Widget _buildOptionsList() {
    List<Widget> children = [];

    for (var i = 0; i < actionList.length; i++) {
      MXActionSheetListModel model = actionList[i];

      children.add(MXActionSheetContentByListItem(
          optionClick: optionClick,
          model: model,
          isLast: i == actionList.length - 1));
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }

  void optionClick(MXActionSheetListModel model) {
    confirm.call(model);
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];
    children.add(_buildOptionsList());

    children.add(Container(
      color: Colors.transparent,
      height: MXTheme.of(context).space8,
    ));

    children
        .add(MXActionSheetFooterButton(closeText: closeText, onClose: onClose));
    return Column(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MXTheme.of(context).infoPrimaryColor,
      child: _buildBody(context),
    );
  }
}
