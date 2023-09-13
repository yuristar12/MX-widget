import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/drawer/mx_drawer_option_item.dart';

double padding = MXTheme.getThemeConfig().space16;

class MXDrawerContent extends StatelessWidget {
  const MXDrawerContent({super.key, required this.model});

  final MXDrawerModel model;

  double _getSize(BuildContext context) {
    double size = model.size ?? MediaQuery.of(context).size.width * 0.75;
    return size;
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MXTheme.of(context).space8),
      child: MXText(
        maxLines: 1,
        data: model.title,
        fontWeight: FontWeight.bold,
        font: MXTheme.of(context).fontBodyLarge,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return SizedBox(
      height: 200,
      child: model.footerBuilder!.call(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    List<Widget> children = [];

    if (model.title != null) {
      children.add(_buildTitle(context));
    }

    children.add(_buildMiddle(context));
    if (model.footerBuilder != null) {
      children.add(_buildFooter(context));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildMiddle(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        padding;

    if (model.title != null) {
      height -= 36;
    }

    if (model.footerBuilder != null) {
      height -= 200;
    }

    return Container(
      width: _getSize(context),
      height: height,
      color: MXTheme.of(context).whiteColor,
      child: SingleChildScrollView(
        child: _buildMiddleContent(context),
      ),
    );
  }

  Widget _buildMiddleContent(BuildContext context) {
    Widget child;

    if (model.options != null) {
      child = _buildOptions(context);
    } else {
      child = model.middleBuilder!.call(context);
    }

    return Container(
      child: child,
    );
  }

  Widget _buildOptions(BuildContext context) {
    List<Widget> children = [];

    int length = model.options!.length;

    for (var i = 0; i < length; i++) {
      MXDrawerOptionsModel itemModel = model.options![i];
      children.add(MXDrawerOptionItem(
        model: itemModel,
        onClick: (p0) {
          if (model.optionsClick != null) {
            model.optionsClick?.call(p0);
            Navigator.pop(context);
          }
        },
        useBottomBorder: i != length - 1,
      ));
    }

    return Column(
      children: children,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: padding,
          right: padding,
          bottom: padding),
      color: MXTheme.of(context).whiteColor,
      width: _getSize(context),
      height: MediaQuery.of(context).size.height,
      child: _buildContent(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
