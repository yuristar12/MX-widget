import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/theme/mx_colors.dart';
import 'package:mx_widget/src/theme/mx_fonts.dart';
import 'package:mx_widget/src/theme/mx_spaces.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';

import '../../config/global_enum.dart';

///---------------------------------------------------------------------分割线组件
/// [text] 分割线显示的内容
/// [color] 分割线的颜色
/// [margin] 分割线的外边距，默认为左右各8物理像素
/// [width] 分割线的容器宽度，当为竖型时为单条竖线的宽度
/// [height] 分割线的线条高度
/// [widget] 自定义展示的内容，替换默认的文字组件
/// [padding] 分割线内容的左右内边距，默认为左右16的物理像素
/// [useTextDivide] 是否启用文字分割，隐藏线条，默认为false
/// [alignment] 分割线排列方式 左/中/右

class MXDivideLine extends StatelessWidget {
  const MXDivideLine({
    super.key,
    this.text,
    this.color,
    this.margin,
    this.width,
    this.height,
    this.widget,
    this.padding,
    this.useTextDivide = false,
    this.alignment = MXDivideAlignmentEnum.left,
  });

  final String? text;

  final Color? color;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  final MXDivideAlignmentEnum alignment;

  final double? width;

  final double? height;

  final Widget? widget;

  final bool useTextDivide;

  @override
  Widget build(BuildContext context) {
    if (text == null && widget == null) {}
    return buildDivideLineBody(context);
  }

  Widget buildDivideLineBody(BuildContext context) {
    if (text == null && widget == null) {
      return _buildLineBody(context, width: width, height: height);
    }

    if (useTextDivide) {
      return Container(
        width: width,
        height: width,
        margin: _getMargin(context),
        child: _buildDivideContentBody(context),
      );
    }

    var space = MXTheme.of(context).space16;
    switch (alignment) {
      case MXDivideAlignmentEnum.left:
        return _buildDivideBodyWrap(
            context,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLineBody(context, width: space),
                Padding(
                  padding: _getPadding(context),
                  child: _buildDivideContentBody(context),
                ),
                Expanded(child: _buildLineBody(context))
              ],
            ));
      case MXDivideAlignmentEnum.center:
        return _buildDivideBodyWrap(
            context,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildLineBody(context)),
                Padding(
                  padding: _getPadding(context),
                  child: _buildDivideContentBody(context),
                ),
                Expanded(child: _buildLineBody(context)),
              ],
            ));

      case MXDivideAlignmentEnum.right:
        return _buildDivideBodyWrap(
            context,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildLineBody(context)),
                Padding(
                  padding: _getPadding(context),
                  child: _buildDivideContentBody(context),
                ),
                _buildLineBody(context, width: space),
              ],
            ));
      default:
    }

    return Container();
  }

  EdgeInsetsGeometry _getPadding(BuildContext context) {
    var space = MXTheme.of(context).space16;

    return padding ?? EdgeInsets.only(left: space, right: space);
  }

  EdgeInsetsGeometry _getMargin(BuildContext context) {
    var space = MXTheme.of(context).space8;

    return margin ?? EdgeInsets.only(left: space, right: space);
  }

  Widget _buildDivideBodyWrap(BuildContext context, Widget widget) {
    return Container(
      width: width,
      margin: _getMargin(context),
      child: widget,
    );
  }

  Widget _buildDivideContentBody(BuildContext context) {
    return widget ??
        Text(
          text!,
          style: TextStyle(
              color: MXTheme.of(context).fontUseSecondColors,
              fontSize: MXTheme.of(context).fontBodyMedium!.size),
        );
  }

  Widget _buildLineBody(BuildContext context, {double? width, double? height}) {
    return Container(
      width: width,
      height: height ?? 0.5,
      margin: margin,
      color: color ?? MXTheme.of(context).infoColor5,
    );
  }
}
