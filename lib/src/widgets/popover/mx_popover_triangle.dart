import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

enum TriangleDirection {
  top,
  bottom,
  left,
  right,
}

class MXPopoverTriangle extends StatelessWidget {
  const MXPopoverTriangle(
      {super.key, required this.direction, required this.size});

  final TriangleDirection direction;

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: MXTheme.of(context).shadowTopList),
        child: CustomPaint(
          painter: Triangel(direction: direction, size: size),
        ));
  }
}

class Triangel extends CustomPainter {
  Triangel({required this.direction, required this.size});

  final TriangleDirection direction;
  final double size;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    switch (direction) {
      case TriangleDirection.top:
        _drawerByTop(canvas, paint);
        break;
      case TriangleDirection.left:
        _drawerByLeft(canvas, paint);
        break;
      case TriangleDirection.right:
        _drawerByRight(canvas, paint);
        break;
      case TriangleDirection.bottom:
        _drawerByBottom(canvas, paint);
        break;
    }
  }

  void _drawerByTop(Canvas canvas, Paint paint) {
    double width = size * 2;
    double height = size;
    Path path = Path();
    path.moveTo(width / 2, 0);
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width / 2, 0);
    canvas.drawPath(path, paint);
  }

  void _drawerByBottom(Canvas canvas, Paint paint) {
    double width = size * 2;
    double height = size;
    Path path = Path();
    path.moveTo(width / 2, height);
    path.lineTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width / 2, height);
    canvas.drawPath(path, paint);
  }

  void _drawerByLeft(Canvas canvas, Paint paint) {
    double width = size;
    double height = size * 2;

    Path path = Path();
    path.moveTo(0, height / 2);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height / 2);
    canvas.drawPath(path, paint);
  }

  void _drawerByRight(Canvas canvas, Paint paint) {
    double width = size;
    double height = size * 2;
    Path path = Path();
    path.moveTo(width, height / 2);
    path.lineTo(0, 0);
    path.lineTo(0, height);
    path.lineTo(width, height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
