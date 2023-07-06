import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXResult extends StatelessWidget {
  const MXResult(
      {super.key,
      this.typeEnum = MXResultTypeEnum.success,
      this.description,
      this.title,
      this.icon,
      this.netUrl,
      this.assetUrl,
      this.assetsSize = 80,
      this.pluginWidget});

  final MXResultTypeEnum typeEnum;

  final String? description;

  final String? title;

  final IconData? icon;

  final String? netUrl;

  final String? assetUrl;

  final double assetsSize;

  final Widget? pluginWidget;

  Color _getIconColor(BuildContext context) {
    switch (typeEnum) {
      case MXResultTypeEnum.primary:
        return MXTheme.of(context).brandPrimaryColor;
      case MXResultTypeEnum.success:
        return MXTheme.of(context).successPrimaryColor;
      case MXResultTypeEnum.error:
        return MXTheme.of(context).errorPrimaryColor;
      case MXResultTypeEnum.warn:
        return MXTheme.of(context).warnPrimaryColor;
    }
  }

  Widget _buildIcon(BuildContext context) {
    IconData _icon;

    if (icon != null) {
      _icon = icon!;
    } else {
      switch (typeEnum) {
        case MXResultTypeEnum.primary:
          _icon = Icons.check_circle_outline_outlined;
          break;
        case MXResultTypeEnum.success:
          _icon = Icons.check_circle_outline_outlined;
          break;
        case MXResultTypeEnum.error:
          _icon = Icons.highlight_off_sharp;
          break;
        case MXResultTypeEnum.warn:
          _icon = Icons.info_outline;
          break;
      }
    }

    return MXIcon(
      icon: _icon,
      iconFontSize: assetsSize,
      useDefaultPadding: false,
      iconColor: _getIconColor(context),
    );
  }

  Widget? _buildImg() {
    Widget? child;
    if (netUrl != null) {
      child = MXImage(
        netUrl: netUrl,
        width: assetsSize,
        height: assetsSize,
        customRadius: BorderRadius.circular(0),
      );
    } else if (assetUrl != null) {
      child = MXImage(
        assetsUrl: assetUrl,
        width: assetsSize,
        height: assetsSize,
        customRadius: BorderRadius.circular(0),
      );
    }
    return child;
  }

  Widget _buildAssetContent(BuildContext context) {
    Widget child;

    if (assetUrl != null || netUrl != null) {
      child = _buildImg()!;
    } else {
      child = _buildIcon(context);
    }

    return child;
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MXTheme.of(context).space12),
      child: MXText(
        data: title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textColor: MXTheme.of(context).fontUsePrimaryColor,
        font: MXTheme.of(context).fontTitleSmall,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDes(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MXTheme.of(context).space8),
      child: MXText(
        data: description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textColor: MXTheme.of(context).fontUseSecondColors,
        font: MXTheme.of(context).fontBodySmall,
      ),
    );
  }

  Widget _buildResultBody(BuildContext context) {
    List<Widget> children = [];

    children.add(_buildAssetContent(context));

    if (title != null) {
      children.add(_buildTitle(context));
    }

    if (description != null) {
      children.add(_buildDes(context));
    }

    if (pluginWidget != null) {
      children.add(pluginWidget!);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildResultBody(context);
  }
}
