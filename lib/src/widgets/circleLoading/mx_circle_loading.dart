import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:mx_widget/src/theme/mx_colors.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';

class MXCircleLoading extends StatefulWidget {
  const MXCircleLoading(
      {super.key,
      this.strokeWidth = 5,
      this.circleColor,
      this.duration = 1000,
      this.size = 25});

  final double strokeWidth;
  final Color? circleColor;

  final double size;

  final int duration;

  @override
  State<MXCircleLoading> createState() => _MXCircleLoadingState();
}

class _MXCircleLoadingState extends State<MXCircleLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration))
      ..addListener(() {
        setState(() {});
      })
      ..repeat();

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = _animation.value * 2 * pi;

    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateZ(size),
        child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: _CirclePointer(
                  widget.circleColor ?? MXTheme.of(context).brandPrimaryColor,
                  widget.strokeWidth),
            )));
  }
}

class _CirclePointer extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CirclePointer(this.color, this.strokeWidth);

  final _paint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    double minSize = min(size.width, size.height);

    _paint.strokeWidth = strokeWidth;

    _paint.shader = ui.Gradient.sweep(Offset(size.width / 2, size.height / 2),
        [const Color(0x01ffffff), color]);

    if (minSize == size.width) {
      canvas.drawArc(
          Rect.fromLTWH(
              0, (size.height - size.width) / 2, size.width, size.width),
          0,
          pi * 2,
          false,
          _paint);
    } else {
      canvas.drawArc(
          Rect.fromLTWH(
              0, (size.width - size.height) / 2, size.height, size.height),
          0,
          pi * 2,
          false,
          _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
