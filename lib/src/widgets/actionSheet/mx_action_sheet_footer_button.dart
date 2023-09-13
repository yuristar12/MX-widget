import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';

class MXActionSheetFooterButton extends StatelessWidget {
  const MXActionSheetFooterButton(
      {super.key, required this.closeText, required this.onClose});

  final String closeText;

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MXTheme.of(context).whiteColor,
      child: MXButton(
        customHeight: 56,
        text: closeText,
        customMargin: EdgeInsets.zero,
        sizeEnum: MXButtonSizeEnum.medium,
        typeEnum: MXButtonTypeEnum.text,
        themeEnum: MXButtonThemeEnum.info,
        afterClickButtonCallback: () {
          onClose.call();
        },
      ),
    );
  }
}
