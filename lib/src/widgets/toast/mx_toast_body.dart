import 'package:flutter/widgets.dart';
import 'package:mx_widget/src/export.dart';

class MXToastBody extends StatelessWidget {
  const MXToastBody(
      {super.key,
      this.iconData,
      this.iconWidget,
      required this.text,
      this.mxToastDirectionEnum = MXToastDirectionEnum.horizontal});

  final String text;
  final IconData? iconData;
  final Widget? iconWidget;
  final MXToastDirectionEnum mxToastDirectionEnum;

  List<Widget> _buildToastChildren(BuildContext context) {
    List<Widget> list = [];

    if (iconData != null || iconWidget != null) {
      if (iconWidget != null) {
        list.add(iconWidget!);
      } else {
        list.add(MXIcon(
          icon: iconData!,
          iconFontSize: 24,
          iconSizeEnum: MXIconSizeEnum.medium,
          iconColor: MXTheme.of(context).whiteColor,
        ));
      }
    }

    list.add(MXText(
      data: text,
      font: MXTheme.of(context).fontBodySmall,
      style: TextStyle(
        decoration: TextDecoration.none,
        color: MXTheme.of(context).whiteColor,
      ),
    ));

    return list;
  }

  Widget _buildToastBody(BuildContext context) {
    switch (mxToastDirectionEnum) {
      case MXToastDirectionEnum.horizontal:
        return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 191, maxHeight: 94),

            //  需要加上center 组件，否则body会全屏展示
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                    color: MXTheme.of(context).mask2,
                    borderRadius: BorderRadius.circular(
                        MXTheme.of(context).radiusDefault)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildToastChildren(context),
                ),
              ),
            ));

      case MXToastDirectionEnum.vertical:
        return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 134, maxHeight: 134),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                decoration: BoxDecoration(
                    color: MXTheme.of(context).mask2,
                    borderRadius: BorderRadius.circular(
                        MXTheme.of(context).radiusDefault)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildToastChildren(context),
                ),
              ),
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildToastBody(context);
  }
}
