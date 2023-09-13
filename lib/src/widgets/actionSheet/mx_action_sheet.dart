import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/actionSheet/mx_action_sheet_content_by_grid/mx_action_sheet_content_by_grid.dart';
import 'package:mx_widget/src/widgets/actionSheet/mx_action_sheet_content_by_list.dart';

typedef MXActionSheetConfirm = void Function(MXActionSheetListModel model);

class MXActionSheet {
  MXActionSheet({
    this.typeEnum = MXActionSheetTypeEnum.list,
    this.actionOptionsByList,
    this.closeText = '取消',
    this.actionSheetTitle,
    this.actionOptionsByGrid,
  });
  final MXActionSheetTypeEnum typeEnum;

  final String? actionSheetTitle;

  final String closeText;

  final List<MXActionSheetListModel>? actionOptionsByList;

  final List<MXActionSheetListModelByGrid>? actionOptionsByGrid;

  Widget _buildActionContent(
    BuildContext context, {
    required VoidCallback onClose,
    required MXActionSheetConfirm confirm,
  }) {
    Widget child;

    switch (typeEnum) {
      case MXActionSheetTypeEnum.list:
        child = MXActionSheetContentByList(
          actionList: actionOptionsByList!,
          closeText: closeText,
          onClose: onClose,
          confirm: (model) {
            confirm.call(model);
          },
        );
        break;
      case MXActionSheetTypeEnum.grid:
        child = MXActionSheetContentByGrid(
          modelList: actionOptionsByGrid!,
          closeText: closeText,
          onClose: onClose,
          onConfirm: (model) {
            confirm.call(model);
          },
        );

        break;
    }

    return child;
  }

  Widget? _buildActionSheetTitle(BuildContext context) {
    if (actionSheetTitle != null) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: MXTheme.of(context).infoColor1))),
        padding: EdgeInsets.symmetric(vertical: MXTheme.of(context).space12),
        child: Center(
          child: MXText(
            data: actionSheetTitle,
            font: MXTheme.of(context).fontBodySmall,
            textColor: MXTheme.of(context).fontUseSecondColors,
          ),
        ),
      );
    }
    return null;
  }

  /// 打开Action面板，并且waite结果
  void toAction(BuildContext context,
      {MXActionSheetConfirm? onConfirm, VoidCallback? onClose}) async {
    Widget? title = _buildActionSheetTitle(context);

    MXPopUp.MXpopUpByBottom(context,
        horizontalSpace: 0,
        modelClose: false,
        titleWidget: title,
        child: _buildActionContent(
          context,
          confirm: (model) {
            Navigator.pop(context);
            onConfirm?.call(model);
          },
          onClose: () {
            Navigator.pop(context);
            onClose?.call();
          },
        ));
  }
}
