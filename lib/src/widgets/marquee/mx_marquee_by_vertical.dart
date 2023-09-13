import 'dart:async';

import 'package:flutter/material.dart';

class MXMarqueeByVertical extends StatefulWidget {
  const MXMarqueeByVertical({
    super.key,
    required this.children,
    this.duration = 3000,
  });

  final List<Widget> children;

  final int duration;

  @override
  State<MXMarqueeByVertical> createState() => MXMarqueeByVerticalState();
}

class MXMarqueeByVerticalState extends State<MXMarqueeByVertical> {
  int pageNum = 0;

  late PageController controller;

  Timer? timer;

  @override
  void initState() {
    controller = PageController();

    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer?.cancel();
    }
    super.dispose();
  }

  void startTimer() {
    if (timer == null) {
      pageNum = -1;
      timer = Timer.periodic(Duration(milliseconds: widget.duration), (timer) {
        _onScroll();
      });
    }
  }

  void endTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  void _onScroll() {
    pageNum += 1;

    controller.animateToPage(pageNum,
        duration: Duration(milliseconds: widget.duration ~/ 3),
        curve: Curves.linear);
  }

  Widget _buildBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: controller,
      onPageChanged: (value) {
        if (value == widget.children.length - 1) {
          // 需要结束滚动循环
          endTimer();
          // 继续开始
          startTimer();
        }
      },
      children: widget.children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
