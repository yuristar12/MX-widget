import 'dart:async';
import 'package:flutter/widgets.dart';

/// 组件库内部组件，目前用于message组件及noticeBar组件，用于自动滚动文字内容。

class MXMarqueeByHorizontal extends StatefulWidget {
  const MXMarqueeByHorizontal({
    super.key,
    required this.width,
    required this.child,
    this.animationDuration = 300,
  });
  final double width;

  final Widget child;

  final int animationDuration;

  @override
  State<MXMarqueeByHorizontal> createState() => MXMarqueeByHorizontalState();
}

class MXMarqueeByHorizontalState extends State<MXMarqueeByHorizontal> {
  late ScrollController controller;

  double offsetX = 0;

  Timer? time;

  @override
  void initState() {
    controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double totalWidth =
          controller.position.maxScrollExtent + (widget.width / 2);

      controller.addListener(() {
        // 底部需要终止滚动并且从头开始播放
        if (offsetX >= totalWidth) {
          endMarquee();
          startMarquee();
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    if (time != null) {
      time?.cancel();
    }
    super.dispose();
  }

// 开始自动滚动滚动
  void startMarquee() {
    if (time == null) {
      offsetX = 0;
      controller.jumpTo(
        offsetX,
      );
      time = Timer.periodic(Duration(milliseconds: widget.animationDuration),
          (timer) {
        _onScroll();
      });
    }
  }

  // 结束滚动
  void endMarquee() {
    if (time != null) {
      time?.cancel();
      time = null;
      offsetX = 0;
    }
  }

  void _onScroll() {
    offsetX += 10;
    controller.animateTo(offsetX,
        duration: Duration(milliseconds: widget.animationDuration),
        curve: Curves.linear);
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: SingleChildScrollView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: widget.child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
