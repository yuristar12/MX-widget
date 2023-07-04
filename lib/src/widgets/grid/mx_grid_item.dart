import 'package:flutter/material.dart';

import '../../../mx_widget.dart';

class MXGirdItem extends StatelessWidget {
  const MXGirdItem({
    super.key,
    required this.model,
    this.width,
    this.useBorder = false,
    required this.size,
    required this.useRightBorder,
    required this.useBottomBorder,
    required this.gridItemAxis,
    this.onClick,
  });

  final MXGridItemModel model;

  final double? width;

  final bool useBorder;

  final MXGirdSizeEnum size;

  final bool useRightBorder;

  final bool useBottomBorder;

  final Axis gridItemAxis;

  final VoidCallback? onClick;

  MXFontStyle _getTitleFont(BuildContext context) {
    switch (size) {
      case MXGirdSizeEnum.large:
        return MXTheme.of(context).fontBodySmall!;
      case MXGirdSizeEnum.mini:
      case MXGirdSizeEnum.medium:
        return MXTheme.of(context).fontInfoLarge!;
    }
  }

  MXFontStyle _getDesFont(BuildContext context) {
    switch (size) {
      case MXGirdSizeEnum.large:
        return MXTheme.of(context).fontInfoLarge!;
      case MXGirdSizeEnum.mini:
      case MXGirdSizeEnum.medium:
        return MXTheme.of(context).fontInfoSmall!;
    }
  }

  double _getContentSize(BuildContext context) {
    switch (size) {
      case MXGirdSizeEnum.large:
        return 48;
      case MXGirdSizeEnum.medium:
        return 40;
      case MXGirdSizeEnum.mini:
        return 32;
    }
  }

  Widget _buildImg(BuildContext context) {
    double size = _getContentSize(context);
    if (model.assetUrl != null) {
      return MXImage(
        width: size,
        height: size,
        assetsUrl: model.assetUrl,
        modeEnum: MXImageModeEnum.roundSquare,
      );
    } else {
      return MXImage(
        width: size,
        height: size,
        netUrl: model.netUrl,
        modeEnum: MXImageModeEnum.roundSquare,
      );
    }
  }

  Widget _buildText(BuildContext context) {
    List<Widget> children = [];

    children.add(MXText(
      data: model.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      font: _getTitleFont(context),
      textColor: MXTheme.of(context).fontUsePrimaryColor,
    ));

    if (model.des != null) {
      children.add(MXText(
        data: model.des,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        font: _getDesFont(context),
        textColor: MXTheme.of(context).fontUseSecondColors,
      ));
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: gridItemAxis == Axis.horizontal
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: children);
  }

  Widget _buildContent(BuildContext context) {
    double size = _getContentSize(context);
    return model.customWidget != null
        ? SizedBox(
            width: size,
            height: size,
            child: Center(
              child: model.customWidget,
            ))
        : _buildImg(context);
  }

  Widget _buildBody(BuildContext context) {
    double space = MXTheme.of(context).space8;

    Color borderColor = MXTheme.of(context).infoPrimaryColor;

    Widget child;
    if (gridItemAxis == Axis.horizontal) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildContent(context),
          SizedBox(
            width: space,
          ),
          _buildText(context)
        ],
      );
    } else {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: model.des != null ? 0 : 4,
          ),
          _buildContent(context),
          SizedBox(
            height: space,
          ),
          _buildText(context),
        ],
      );
    }

    return Container(
      width: width,
      height: width,
      padding: width != null ? EdgeInsets.symmetric(vertical: space) : null,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  width: 1,
                  color: useRightBorder ? borderColor : Colors.transparent),
              bottom: BorderSide(
                  width: 1,
                  color: useBottomBorder ? borderColor : Colors.transparent))),
      child: Center(
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick?.call();
      },
      child: _buildBody(context),
    );
  }
}
