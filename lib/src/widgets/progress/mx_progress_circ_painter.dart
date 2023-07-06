import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';

class MXProgressCircPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  final bool useRound;

  final double radiuValue;

  final LinearGradient? gradient;

  MXProgressCircPainter(
      {required this.color,
      required this.strokeWidth,
      required this.useRound,
      required this.radiuValue,
      this.gradient});

  final _paint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    double minSize = min(size.width, size.height);

    _paint.strokeWidth = strokeWidth;

    if (useRound) {
      _paint.strokeCap = StrokeCap.round;
    }

    if (gradient != null) {
      List<Color> colorList = [];

      for (var element in gradient!.colors) {
        colorList.add(element);
      }
      _paint.shader =
          ui.Gradient.sweep(Offset(size.width, size.width), colorList);
    } else {
      _paint.color = color;
    }

    if (minSize == size.width) {
      canvas.drawArc(
          Rect.fromLTRB(
            (size.height - size.width) / 2,
            0,
            size.width,
            size.width,
          ),
          0,
          radiuValue,
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
