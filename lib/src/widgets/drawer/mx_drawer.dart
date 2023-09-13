import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/drawer/mx_drawer_content.dart';

class MXDrawer {
  MXDrawer({required this.model});

  final MXDrawerModel model;

  Widget _buildDrawerContent() {
    return MXDrawerContent(
      model: model,
    );
  }

  void tovisibility(BuildContext context) {
    MXPopUpShowTypeEnum placement;

    if (model.placement == MXDrawerPlacementEnum.left) {
      placement = MXPopUpShowTypeEnum.toRight;
    } else {
      placement = MXPopUpShowTypeEnum.toLeft;
    }

    MXPopUp.MXpopUpByOther(
        context, (context) => _buildDrawerContent(), placement,
        modelClose: model.closeOnOverlayClick, onClose: model.onClose);
  }
}
