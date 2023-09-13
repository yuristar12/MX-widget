import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/string_util.dart';
import 'package:mx_widget/src/widgets/noticeBar/mx_notice_content_by_scroll.dart';

class MXNoticeBar extends StatelessWidget {
  MXNoticeBar({
    super.key,
    this.content,
    this.scrollDirection,
    this.prefixIcon,
    this.suffixIcon,
    this.link,
    this.onHref,
    this.contentList,
    this.suffixIconClick,
    this.theme = MXNoticeThemeEnum.primary,
  }) : assert(() {
          if (scrollDirection == MXNoticeBarScrollDirectionEnum.vertical &&
              contentList == null) {
            throw FlutterError('当滚动为垂直模式时，contentList必须传入');
          }
          return true;
        }());

  final MXNoticeThemeEnum theme;

  final String? content;

  final MXNoticeBarScrollDirectionEnum? scrollDirection;

  final IconData? prefixIcon;

  final IconData? suffixIcon;

  final String? link;

  final VoidCallback? suffixIconClick;

  final VoidCallback? onHref;

  final List<String>? contentList;

  Map _getColor(BuildContext context) {
    Map<String, Color> colorMap = {
      "primary": Colors.transparent,
      "plain": Colors.transparent,
    };
    MXThemeConfig config = MXTheme.of(context);
    switch (theme) {
      case MXNoticeThemeEnum.info:
        colorMap['primary'] = config.fontUsePrimaryColor;
        colorMap['plain'] = config.infoColor1;
        break;
      case MXNoticeThemeEnum.primary:
        colorMap['primary'] = config.brandPrimaryColor;
        colorMap['plain'] = config.brandColor1;
        break;
      case MXNoticeThemeEnum.success:
        colorMap['primary'] = config.successPrimaryColor;
        colorMap['plain'] = config.successColor1;
        break;
      case MXNoticeThemeEnum.error:
        colorMap['primary'] = config.errorPrimaryColor;
        colorMap['plain'] = config.errorColor1;
        break;
      case MXNoticeThemeEnum.waring:
        colorMap['primary'] = config.warnPrimaryColor;
        colorMap['plain'] = config.warnColor1;
        break;
    }

    return colorMap;
  }

  Widget _buildIcon(BuildContext context, IconData icon, Color color) {
    return MXIcon(
      icon: icon,
      iconColor: color,
      iconFontSize: 22,
      useDefaultPadding: false,
    );
  }

  Widget _buildLeft(BuildContext context, IconData icon, Color color) {
    List<Widget> children = [];

    children.add(_buildIcon(context, prefixIcon!, color));
    children.add(SizedBox(
      width: MXTheme.of(context).space4,
    ));

    Widget child = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );

    return child;
  }

  Widget _buildTitle(BuildContext context) {
    Widget child;
    TextStyle style = TextStyle(
      color: MXTheme.of(context).fontUsePrimaryColor,
      fontSize: MXTheme.of(context).fontBodySmall!.size,
    );

    return LayoutBuilder(builder: (context, constraints) {
      if (scrollDirection != null) {
        child = MXNoticeContentByScroll(
            width: constraints.maxWidth,
            content: content,
            contentList: contentList,
            scrollDirection: scrollDirection!);
      } else {
        if (link != null) {
          child = Text.rich(
            TextSpan(text: content, style: style, children: [
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MXTheme.of(context).space4),
                    child: MXLink(
                      useUnderLine: false,
                      size: MXLinkSizeEnum.medium,
                      content: link!,
                      onHref: () {
                        onHref?.call();
                      },
                    ),
                  ))
            ]),
            style: style,
          );
        } else {
          bool isLine = stringHasEllipsis(
              maxWidth: constraints.maxWidth, text: content!, style: style);
          child = MXText(
            isLine: !isLine,
            data: content,
            style: style,
          );
        }
      }

      return child;
    });
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];
    Map color = _getColor(context);

    if (prefixIcon != null) {
      children.add(_buildLeft(context, prefixIcon!, color['primary']));
    }

    children.add(
        Flexible(flex: 1, fit: FlexFit.tight, child: _buildTitle(context)));

    if (suffixIcon != null) {
      children.add(SizedBox(
        width: MXTheme.of(context).space4,
      ));
      Color color = MXTheme.of(context).fontUseIconColor;

      children.add(MXIcon(
        icon: suffixIcon!,
        iconColor: color,
        iconFontSize: 22,
        action: () {
          suffixIconClick?.call();
        },
        useDefaultPadding: false,
      ));
    }

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MXTheme.of(context).space12,
          horizontal: MXTheme.of(context).space16),
      decoration: BoxDecoration(color: color['plain']),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
