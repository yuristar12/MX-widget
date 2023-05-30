import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/skeleton/skeleton_box_dec.dart';

/// 当开启百分比后固定宽度失效，反之亦然。
/// 当开启百分比后请如父组件为row/column，请使用Flexible容器包裹该组件，固定宽度不需要该操作
/// [percentageWidth] 是否开启百分比宽度默认为0为关闭 最大为1代表100% .3为30%
/// [width] 骨架屏宽度
/// [height] 骨架屏高度必填
/// [useAnimation] 是否开启动画效果 默认打开
/// [duration] 动画持续时间，默认为1秒
/// [curve] 动画执行的贝塞尔曲线效果，默认为easeInOutSine
/// [useCircle] 是否使用圆形形状 开启时推荐使用固定宽度使用百分比宽度会导致椭圆形状
class MXSkeleton extends StatefulWidget {
  const MXSkeleton({
    super.key,
    this.width = 0,
    required this.height,
    this.useAnimation = true,
    this.percentageWidth = 0,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeInOutSine,
    this.useCircle = false,
  });

  final double width;
  final double height;
  final bool useAnimation;
  final Duration duration;
  final Curve curve;
  final double percentageWidth;
  final bool useCircle;

  @override
  State<MXSkeleton> createState() => _MXSkeletonState();
}

class _MXSkeletonState extends State<MXSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    if (widget.useAnimation) {
      _controller = AnimationController(vsync: this, duration: widget.duration);
      animation = Tween<double>(begin: -1.0, end: 2.0)
          .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          _controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.useAnimation) {
      _controller.dispose();
    }
    super.dispose();
  }

// 构建动画骨架屏
  buildAnimationSkeleton() {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, childe) {
          return buildSkeleton();
        });
  }

// 构建普通无动画骨架屏
  buildSkeleton() {
    if (widget.percentageWidth > 0) {
      return FractionallySizedBox(
          widthFactor: widget.percentageWidth,
          child: Container(
            height: widget.height,
            decoration:
                skeletonBoxDes(widget.useAnimation ? animation : false, false),
          ));
    } else {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration:
            skeletonBoxDes(widget.useAnimation ? animation : false, false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.useAnimation ? buildAnimationSkeleton() : buildSkeleton();
  }
}
