import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXCell extends StatelessWidget {
  const MXCell({super.key, required this.model, required this.padding});

  final MXCellModel model;

  final double padding;

  Widget _buildNoteText(BuildContext context) {
    MXThemeConfig config = MXTheme.of(context);
    return MXText(
      maxLines: 1,
      data: model.note,
      font: config.fontBodyMedium,
      overflow: TextOverflow.ellipsis,
      textColor: config.fontUseSecondColors,
    );
  }

  CrossAxisAlignment _getAlignment() {
    CrossAxisAlignment alignment;
    switch (model.align) {
      case MXCellAlign.top:
        alignment = CrossAxisAlignment.start;
        break;
      case MXCellAlign.middle:
        alignment = CrossAxisAlignment.center;
        break;
      case MXCellAlign.bottom:
        alignment = CrossAxisAlignment.end;
        break;
    }

    return alignment;
  }

  Widget _buildSpace(BuildContext context) {
    return SizedBox(
      width: MXTheme.of(context).space8,
    );
  }

  Widget _buildRight(BuildContext context) {
    List<Widget> children = [];

    if (model.note != null || model.noteWidget != null) {
      if (model.note != null) {
        children.add(_buildNoteText(context));
      } else if (model.noteWidget != null) {
        children.add(model.noteWidget!);
      }
      children.add(_buildSpace(context));
    }

    if (model.useArrow || model.rightIconWidget != null) {
      children.add(_buildRightIcon());
    }

    return Row(
      crossAxisAlignment: _getAlignment(),
      mainAxisAlignment: MainAxisAlignment.end,
      children: children,
    );
  }

  Widget _buildTitleText(BuildContext context) {
    List<Widget> children = [];

    children.add(MXText(
      maxLines: 1,
      data: model.title,
      overflow: TextOverflow.ellipsis,
      font: MXTheme.of(context).fontBodyMedium,
    ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildDescription(BuildContext context) {
    MXThemeConfig config = MXTheme.of(context);
    return MXText(
      data: model.description,
      maxLines: 1,
      textColor: config.fontUseSecondColors,
      overflow: TextOverflow.ellipsis,
      font: config.fontBodySmall,
    );
  }

  Widget _buildLeft(BuildContext context) {
    List<Widget> children = [];

    List<Widget> leftChildren = [];

    if (model.leftIconWidget != null) {
      children.add(_buildLeftIcon(context));
      children.add(_buildSpace(context));
    }

    leftChildren.add(_buildTitleText(context));
    if (model.description != null) {
      leftChildren.add(_buildDescription(context));
    }

    children.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: leftChildren));

    Widget child = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
    return child;
  }

  Widget _buildLeftIcon(BuildContext context) {
    return model.leftIconWidget!;
  }

  Widget _buildRightIcon() {
    Widget child = model.rightIconWidget ??
        const MXIcon(
          iconFontSize: 24,
          icon: Icons.keyboard_arrow_right_outlined,
          useDefaultPadding: false,
        );

    return child;
  }

  Widget _buildMutipleTitle(BuildContext context) {
    return Text(
      model.title,
      style: TextStyle(
          color: MXTheme.of(context).fontUsePrimaryColor,
          fontSize: MXTheme.of(context).fontBodyMedium!.size),
    );
  }

  Widget _buildMutipleDescription(BuildContext context) {
    return Text(
      model.description!,
      style: TextStyle(
          color: MXTheme.of(context).fontUseSecondColors,
          fontSize: MXTheme.of(context).fontBodySmall!.size),
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget child;
    List<Widget> children = [];

    if (model.type == MXCellType.singleLine) {
      children.add(_buildLeft(context));

      children.add(model.rightWidget ?? _buildRight(context));

      child = Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      );
    } else {
      children.add(_buildMutipleTitle(context));

      if (model.description != null) {
        children.add(SizedBox(
          height: MXTheme.of(context).space8,
        ));
        children.add(_buildMutipleDescription(context));
      }

      child = Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: children,
      );
    }

    return GestureDetector(
        onPanDown: model.onClick,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: padding),
            decoration: BoxDecoration(
                border: Border(
                    bottom: model.useBorder
                        ? BorderSide(
                            width: 1,
                            color: MXTheme.of(context).infoPrimaryColor)
                        : BorderSide.none)),
            child: child));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
