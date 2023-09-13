import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';

class MXLink extends StatelessWidget {
  const MXLink(
      {super.key,
      this.onHref,
      this.prefixIcon,
      this.suffixIcon,
      this.disabled = false,
      required this.content,
      this.useUnderLine = false,
      this.theme = MXLinkThemeEnum.info,
      this.size = MXLinkSizeEnum.small});

  final MXLinkThemeEnum theme;
  final MXLinkSizeEnum size;
  final String content;
  final VoidCallback? onHref;
  final bool disabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool useUnderLine;

  Color _getColor(BuildContext context) {
    Color color;
    switch (theme) {
      case MXLinkThemeEnum.error:
        color = MXTheme.of(context).errorPrimaryColor;
        break;
      case MXLinkThemeEnum.info:
        color = MXTheme.of(context).brandPrimaryColor;
        break;
      case MXLinkThemeEnum.waring:
        color = MXTheme.of(context).warnPrimaryColor;
        break;
      case MXLinkThemeEnum.success:
        color = MXTheme.of(context).successPrimaryColor;
        break;
    }
    return color;
  }

  MXFontStyle _getFontSize(BuildContext context) {
    MXFontStyle style;

    switch (size) {
      case MXLinkSizeEnum.large:
        style = MXTheme.of(context).fontBodyMedium!;
        break;
      case MXLinkSizeEnum.medium:
        style = MXTheme.of(context).fontBodySmall!;
        break;
      case MXLinkSizeEnum.small:
        style = MXTheme.of(context).fontInfoLarge!;
        break;
    }

    return style;
  }

  Widget _getIcon(IconData icon, double size, Color color) {
    return MXIcon(
      icon: icon,
      useDefaultPadding: false,
      iconColor: color,
      iconFontSize: size,
    );
  }

  Widget _buildContent(Color color, MXFontStyle fontStyle) {
    return MXText(
      data: content,
      font: fontStyle,
      textColor: color,
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget child;
    List<Widget> children = [];
    Color color = _getColor(context);
    MXFontStyle fontStyle = _getFontSize(context);

    if (prefixIcon != null) {
      children.add(_getIcon(prefixIcon!, fontStyle.size, color));
      children.add(SizedBox(
        width: MXTheme.of(context).space4,
      ));
    }

    children.add(_buildContent(color, fontStyle));

    if (suffixIcon != null) {
      children.add(SizedBox(
        width: MXTheme.of(context).space4,
      ));
      children.add(_getIcon(suffixIcon!, fontStyle.size, color));
    }

    child = GestureDetector(
      onTap: onHref,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );

    if (useUnderLine) {
      child = Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: color, width: 1))),
        child: child,
      );
    }

    if (disabled) {
      child = Opacity(
        opacity: 0.4,
        child: IgnorePointer(
          child: child,
        ),
      );
    }

    return child;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
