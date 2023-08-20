import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class UseMXCalendarByPopup {
  static toRender({
    required BuildContext context,
    required MXCalendarController controller,
    String title = '选择日期',
    VoidCallback? onClose,
    VoidCallback? onConfirm,
    bool modelClose = false,
    MXButton? customConfirmButton,
  }) {
    MXPopUp.MXpopUpByBottom(
      context,
      title: title,
      modelClose: modelClose,
      rightWidget: MXIcon(
        icon: Icons.close_sharp,
        iconSizeEnum: MXIconSizeEnum.large,
        action: () {
          if (onClose != null) {
            onClose.call();
          }

          Navigator.pop(context);
        },
      ),
      footerText: '确认',
      footerWidget: customConfirmButton,
      child: MXCalendar(controller: controller),
      onFooterCallback: () {
        if (onConfirm != null) {
          onConfirm.call();
        }

        Navigator.pop(context);
      },
    );
  }
}
