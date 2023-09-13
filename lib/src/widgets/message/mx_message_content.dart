import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';
import 'package:mx_widget/src/util/string_util.dart';
import 'package:mx_widget/src/widgets/marquee/mx_marquee_by_horizontal.dart';
import 'package:mx_widget/src/widgets/message/mx_message_manage.dart';

const double contentHeight = 56;

class MXMessageContent extends StatefulWidget {
  const MXMessageContent(
      {super.key,
      required this.model,
      required this.type,
      required this.serialNumber});

  final MXMessageModel model;

  final MXMessageTypeEnum type;

  final String serialNumber;

  @override
  State<MXMessageContent> createState() => _MXMessageContentState();
}

class _MXMessageContentState extends State<MXMessageContent>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  GlobalKey? marqueeKey;

  @override
  void initState() {
    if (widget.model.useScroll) {
      marqueeKey = GlobalKey();
    }

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..forward();

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _init();
        // 如果设置了滚动则开始自动滚动

        if (widget.model.useScroll) {
          (marqueeKey?.currentState as MXMarqueeByHorizontalState)
              .startMarquee();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

// 初始化，如果有传入倒计时大于0则需要开始倒计时并且关闭消息
  void _init() {
    if (widget.model.duration > 0 && !widget.model.useClose) {
      Timer(Duration(milliseconds: widget.model.duration), () {
        _reverseAnimationAndDestory();
      });
    }
  }

// 反转动画并且销毁当前message组件
  void _reverseAnimationAndDestory() {
    // 需要判断是否处于自动滚动中并且中止自动滚动
    if (widget.model.useScroll) {
      (marqueeKey?.currentState as MXMarqueeByHorizontalState).endMarquee();
    }

    // 反转动画
    animationController.reverse().whenComplete(() {
      // 反转后销毁
      _destoryMessage();
    });
  }

  // 销毁message
  void _destoryMessage() {
    MXMessageManage.destoryMessage(widget.serialNumber);
  }

  Widget _buildTitle() {
    return LayoutBuilder(builder: (context, constraints) {
      Widget child;
      bool isLine = true;
      double width = constraints.maxWidth;
      TextStyle textStyle = TextStyle(
        color: MXTheme.of(context).fontUsePrimaryColor,
        fontSize: MXTheme.of(context).fontBodySmall!.size,
      );

      if (!widget.model.useScroll) {
        isLine = !stringHasEllipsis(
            maxWidth: constraints.maxWidth,
            text: widget.model.title,
            style: textStyle);
      }
      child = MXText(
        isLine: isLine,
        maxLines: widget.model.useScroll ? null : 2,
        overflow: TextOverflow.ellipsis,
        data: widget.model.title,
        style: textStyle,
      );
      if (widget.model.useScroll) {
        child =
            MXMarqueeByHorizontal(key: marqueeKey, width: width, child: child);
      }

      return child;
    });
  }

  Widget _buildRight() {
    List<Widget> children = [];

    children.add(SizedBox(
      width: MXTheme.of(context).space8,
    ));

    if (widget.model.link != null) {
      children.add(MXLink(
        size: MXLinkSizeEnum.medium,
        content: widget.model.link!,
        onHref: () {
          widget.model.onButtonClick?.call();
        },
      ));
    }

    if (widget.model.useClose) {
      children.add(SizedBox(
        width: MXTheme.of(context).space8,
      ));
      children.add(MXIcon(
        useDefaultPadding: false,
        iconFontSize: 24,
        action: () {
          _reverseAnimationAndDestory();
        },
        icon: Icons.close_rounded,
        iconColor: MXTheme.of(context).fontUseIconColor,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildIcon() {
    IconData icon;
    Color color;
    MXThemeConfig config = MXTheme.of(context);
    switch (widget.type) {
      case MXMessageTypeEnum.info:
        icon = widget.model.icon ?? Icons.priority_high_rounded;
        color = config.brandPrimaryColor;

        break;
      case MXMessageTypeEnum.error:
        icon = widget.model.icon ?? Icons.priority_high_rounded;
        color = config.errorPrimaryColor;
        break;
      case MXMessageTypeEnum.waring:
        icon = widget.model.icon ?? Icons.priority_high_rounded;
        color = config.warnPrimaryColor;
        break;
      case MXMessageTypeEnum.success:
        icon = widget.model.icon ?? Icons.check_circle_rounded;
        color = config.successPrimaryColor;
        break;
    }

    return MXIcon(
      icon: icon,
      iconFontSize: 22,
      iconColor: color,
    );
  }

  Widget _buildContent() {
    List<Widget> children = [];

    children.add(_buildIcon());

    children.add(Flexible(fit: FlexFit.tight, flex: 1, child: _buildTitle()));

    children.add(_buildRight());

    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  Widget _buildBody() {
    MXThemeConfig config = MXTheme.of(context);

    return Container(
      width: MediaQuery.sizeOf(context).width * 0.92,
      height: contentHeight,
      padding: EdgeInsets.symmetric(horizontal: config.space16),
      decoration: BoxDecoration(
          color: config.whiteColor,
          boxShadow: config.shadowTopList,
          borderRadius: BorderRadius.circular(config.radiusMedium)),
      child: _buildContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: CurvedAnimation(
            parent: animationController, curve: CurveUtil.curve_1()),
        builder: (context, child) {
          return Transform.translate(
              offset: Offset(
                  0,
                  -(contentHeight -
                      (contentHeight * animationController.value))),
              child: Opacity(
                opacity: animationController.value,
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.sizeOf(context).width,
                  child: Center(
                    child: _buildBody(),
                  ),
                ),
              ));
        });
  }
}
