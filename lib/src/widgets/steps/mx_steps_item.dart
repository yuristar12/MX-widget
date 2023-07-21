import 'package:flutter/material.dart';

import '../../../mx_widget.dart';

const double anchorSize = 22;
const double space = 8;

enum LineAlimentEnum {
  before,
  after,
}

class MXStepsItem extends StatelessWidget {
  const MXStepsItem(
      {super.key,
      required this.index,
      required this.maxLength,
      required this.activityIndex,
      required this.type,
      required this.axis,
      required this.width,
      required this.model,
      this.onTap});

  /// [index] 当前处于列表的下标
  final int index;

  /// [activityIndex] 列表的活动下标
  final int activityIndex;

  /// [maxLength] 列表的长度
  final int maxLength;

  /// [width] item的宽度
  final double width;

  /// [type] item的类型
  final MXStepsTypeEnum type;

  /// [model] 数据模型
  final MXStepsItemModel model;

  final Axis axis;

  final VoidCallback? onTap;

  bool get isActivity {
    return index == activityIndex;
  }

  bool get isPast {
    return index < activityIndex;
  }

  bool get isFirst {
    return index == 0;
  }

  bool get isLast {
    return index == maxLength - 1;
  }

  /// 构建icon类型
  Widget _buildPattern(BuildContext context) {
    Widget content = Container(
      width: anchorSize,
      height: anchorSize,
      margin: axis == Axis.horizontal
          ? const EdgeInsets.symmetric(horizontal: space)
          : EdgeInsets.only(bottom: space, top: isFirst ? 0 : space),
      child: Center(
        child: _buildPatternIcon(context),
      ),
    );

    return content;
  }

  /// 获取icon的内容
  Widget _buildPatternIcon(BuildContext context) {
    return MXIcon(
      iconFontSize: 20,
      icon: model.icon!,
      iconColor: (isActivity || isPast)
          ? MXTheme.of(context).brandPrimaryColor
          : MXTheme.of(context).fontUseIconColor,
    );
  }

  /// simple类型
  Widget _buildSimple(BuildContext context) {
    Widget content = Container(
      width: anchorSize,
      height: anchorSize,
      margin: axis == Axis.horizontal
          ? const EdgeInsets.symmetric(horizontal: space)
          : model.builder == null
              ? EdgeInsets.only(bottom: space, top: isFirst ? 0 : space)
              : null,
      child: Center(
        child: _buildSimpleContent(context),
      ),
    );

    return content;
  }

  Widget _buildSimpleContent(BuildContext context) {
    Color primaryColor = MXTheme.of(context).brandPrimaryColor;

    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MXTheme.of(context).radiusRound),
          border: Border.all(
              width: 1,
              color: (isActivity || isPast)
                  ? primaryColor
                  : MXTheme.of(context).infoPrimaryColor),
          color: isActivity ? primaryColor : Colors.transparent),
    );
  }

  /// 类型为序号类型的类别
  Widget _buildCircle(BuildContext context) {
    Widget content = Container(
      width: anchorSize,
      height: anchorSize,
      margin: axis == Axis.horizontal
          ? const EdgeInsets.symmetric(horizontal: space)
          : EdgeInsets.only(bottom: space, top: isFirst ? 0 : space),
      decoration: BoxDecoration(
          color: isPast
              ? MXTheme.of(context).brandColor1
              : isActivity
                  ? MXTheme.of(context).brandPrimaryColor
                  : MXTheme.of(context).infoPrimaryColor,
          borderRadius: BorderRadius.circular(MXTheme.of(context).radiusRound)),
      child: Center(
        child: _buildCircleText(context),
      ),
    );

    return content;
  }

  /// 获取线条颜色
  Color _getLineColor(BuildContext context, {bool activity = false}) {
    if (isPast || activity) {
      return MXTheme.of(context).brandFocusColor;
    } else {
      return MXTheme.of(context).infoPrimaryColor;
    }
  }

  /// 构建线条
  Widget _buildLine(
    BuildContext context,
    LineAlimentEnum aliment,
  ) {
    Widget child;

    Color lineColor;

    double lineSpace = 2;

    if (aliment == LineAlimentEnum.before) {
      lineColor = index == 0
          ? Colors.transparent
          : _getLineColor(context,
              activity: index == activityIndex - 1 || isActivity);
    } else {
      lineColor = index == maxLength - 1
          ? Colors.transparent
          : _getLineColor(context, activity: false);
    }

    if (axis == Axis.horizontal) {
      child = Expanded(
          child: Container(
        height: lineSpace,
        color: lineColor,
      ));
    } else {
      child = Expanded(
          child: Container(
        width: lineSpace,
        color: lineColor,
      ));
    }

    return child;
  }

  /// 构建序号类型里面的文字与icon
  Widget _buildCircleText(BuildContext context) {
    Widget child;

    if (isPast) {
      child = MXIcon(
        iconFontSize: 14,
        icon: Icons.check_outlined,
        useDefaultPadding: false,
        iconColor: MXTheme.of(context).brandPrimaryColor,
      );
    } else {
      child = MXText(
        data: (index + 1).toString(),
        isNumber: true,
        font: MXTheme.of(context).fontBodySmall,
        textColor: isActivity
            ? MXTheme.of(context).whiteColor
            : MXTheme.of(context).fontUsePrimaryColor,
      );
    }

    return child;
  }

  /// 构建
  Widget _buildAnchor(BuildContext context) {
    Widget anchor;

    Widget child;

    List<Widget> children;

    if (type == MXStepsTypeEnum.number) {
      anchor = _buildCircle(context);
    } else if (type == MXStepsTypeEnum.pattern) {
      anchor = _buildPattern(context);
    } else if (type == MXStepsTypeEnum.simple) {
      anchor = _buildSimple(context);
    } else {
      anchor = _buildCircle(context);
    }

    if (axis == Axis.horizontal) {
      children = [
        _buildLine(context, LineAlimentEnum.before),
        anchor,
        _buildLine(context, LineAlimentEnum.after)
      ];

      child = Row(children: children);
    } else {
      child = Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            anchor,
            index == maxLength - 1
                ? const SizedBox()
                : _buildLine(context, LineAlimentEnum.after),
          ]);
    }

    return child;
  }

  /// 构建描述文字
  Widget _buildDescription(BuildContext context) {
    return MXText(
      data: model.description,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      font: MXTheme.of(context).fontInfoLarge,
      textColor: MXTheme.of(context).fontUseSecondColors,
    );
  }

  /// 构建标题
  Widget _buildTitle(BuildContext context) {
    String text;

    if (isPast) {
      text = model.pastTitle ?? model.title;
    } else if (isActivity) {
      text = model.activityTitle ?? model.title;
    } else {
      text = model.title;
    }

    return MXText(
      data: text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      font: MXTheme.of(context).fontBodySmall,
      fontWeight: (isActivity || isPast) ? FontWeight.bold : FontWeight.w400,
      textColor: isPast
          ? MXTheme.of(context).fontUsePrimaryColor
          : isActivity
              ? MXTheme.of(context).brandPrimaryColor
              : MXTheme.of(context).fontUseSecondColors,
    );
  }

  /// 构建间距widget
  Widget _buildSpaceWidget(BuildContext context) {
    Widget spaceWidget = SizedBox(
      height: MXTheme.of(context).space8,
    );

    return spaceWidget;
  }

  /// 构建文字内容包含title与description与自定义扩展内容
  Widget _buildContent(BuildContext context) {
    Widget child;

    Widget spaceWidget = _buildSpaceWidget(context);

    List<Widget> list = [];

    list.add(_buildTitle(context));

    if (model.description != null) {
      list.add(_buildDescription(context));
    }

    if (axis == Axis.horizontal) {
      child = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list,
      );
    } else {
      if (!isFirst) {
        list.insert(0, const SizedBox(height: space));
      }

      if (model.pluginWidget != null) {
        list.add(spaceWidget);
        list.add(model.pluginWidget!);
      }

      child = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      );
    }

    return child;
  }

  Widget _buildBody(BuildContext context) {
    Widget child;

    Widget content = _buildContent(context);

    List<Widget> children = [content];

    if (axis == Axis.horizontal) {
      children.insert(0, _buildAnchor(context));
      children.insert(1, _buildSpaceWidget(context));
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    } else {
      const double contentSize = anchorSize + space;

      child = Stack(
        children: [
          Positioned.fill(
              child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: anchorSize,
              child: _buildAnchor(context),
            ),
          )),
          Positioned(
              child: Transform.translate(
            offset: const Offset(contentSize, 0),
            child: SizedBox(
              width: width - contentSize,
              child: model.builder != null
                  ? model.builder!.call(isActivity)
                  : content,
            ),
          ))
        ],
      );
    }

    return child;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          width: width,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _buildBody(context),
          )),
    );
  }
}
