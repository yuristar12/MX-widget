import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXFormItem extends StatelessWidget {
  const MXFormItem(
      {super.key,
      this.padding = 16,
      required this.model,
      required this.align,
      this.isError = false,
      this.labelWidth = 80});

  final MXFormItemModel model;

  final MXFormAlign align;

  final double labelWidth;

  final bool isError;

  final double padding;

  Widget _buildItemHelpText(BuildContext context) {
    return MXText(
      data: model.help,
      font: MXTheme.of(context).fontInfoLarge,
      textColor: MXTheme.of(context).infoPrimaryColor,
    );
  }

  Widget _buildErrorText(BuildContext context) {
    return MXText(
      data: model.errorMessage,
      font: MXTheme.of(context).fontInfoLarge,
      textColor: MXTheme.of(context).errorPrimaryColor,
    );
  }

  Widget _buildSpaceWidget(BuildContext context) {
    return SizedBox(
      height: MXTheme.of(context).space8,
    );
  }

  Widget _buildItemContent(BuildContext context) {
    List<Widget> children = [];
    CrossAxisAlignment alignment;

    switch (model.contentAlign) {
      case MXFormPositionAlign.start:
        alignment = CrossAxisAlignment.start;

        break;
      case MXFormPositionAlign.center:
        alignment = CrossAxisAlignment.center;
        break;

      case MXFormPositionAlign.end:
        alignment = CrossAxisAlignment.end;
        break;
    }
    children.add(model.builder.call(model));

    if (model.help != null) {
      children.add(_buildSpaceWidget(context));
      children.add(_buildItemHelpText(context));
    }

    if (isError) {
      children.add(_buildSpaceWidget(context));
      children.add(_buildErrorText(context));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: alignment,
      children: children,
    );
  }

  AlignmentGeometry _getAlignment(MXFormPositionAlign align) {
    AlignmentGeometry alignment;

    switch (model.labelAlign) {
      case MXFormPositionAlign.start:
        alignment = Alignment.centerLeft;

        break;
      case MXFormPositionAlign.center:
        alignment = Alignment.center;
        break;

      case MXFormPositionAlign.end:
        alignment = Alignment.centerRight;
        break;
    }
    return alignment;
  }

  Widget _buildRequireSymbole(BuildContext context) {
    return MXText(
      data: '*',
      font: MXTheme.of(context).fontBodyMedium,
      textColor: MXTheme.of(context).errorPrimaryColor,
    );
  }

  Widget _buildItemLabel(BuildContext context) {
    AlignmentGeometry alignment = _getAlignment(model.labelAlign);

    List<Widget> children = [];

    if (model.require) {
      children.add(_buildRequireSymbole(context));
    }

    children.add(
      MXText(
        maxLines: 1,
        data: model.label,
        overflow: TextOverflow.ellipsis,
        font: MXTheme.of(context).fontBodyMedium,
      ),
    );

    return Container(
        margin: EdgeInsets.only(right: padding),
        width: align == MXFormAlign.horizontal ? labelWidth : null,
        child: Align(
            alignment: alignment,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            )));
  }

  Widget _buildBody(BuildContext context) {
    Widget child;

    switch (align) {
      case MXFormAlign.horizontal:
        child = LayoutBuilder(builder: ((context, constraints) {
          double contentWidth =
              constraints.biggest.width - labelWidth - padding;

          return Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItemLabel(context),
              SizedBox(
                width: contentWidth,
                child: _buildItemContent(context),
              )
            ],
          );
        }));
        break;
      case MXFormAlign.vertical:
        child = Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItemLabel(context),
            _buildSpaceWidget(context),
            _buildItemContent(context)
          ],
        );
        break;
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: MXTheme.of(context).infoPrimaryColor))),
      child: _buildBody(context),
    );
  }
}
