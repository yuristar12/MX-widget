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
          iconFontSize: 32,
          useDefaultPadding: false,
          iconSizeEnum: MXIconSizeEnum.medium,
          iconColor: MXTheme.of(context).whiteColor,
        ));
      }
    }

    MXFontStyle fontStyle = MXTheme.of(context).fontBodySmall!;

    TextStyle textStyle = TextStyle(
        decoration: TextDecoration.none,
        color: MXTheme.of(context).whiteColor,
        fontSize: fontStyle.size,
        fontWeight: FontWeight.w400);

    Widget textWidget;

    if (mxToastDirectionEnum == MXToastDirectionEnum.horizontal) {
      textWidget = Container(
          margin: const EdgeInsets.only(left: 8),
          child: MXText(
            data: text,
            font: fontStyle,
            style: textStyle,
          ));
    } else {
      textWidget = Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            text,
            maxLines: 4,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ));
    }

    list.add(textWidget);

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
        return Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 182, maxHeight: 182),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
                color: MXTheme.of(context).mask2,
                borderRadius:
                    BorderRadius.circular(MXTheme.of(context).radiusMedium)),
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
