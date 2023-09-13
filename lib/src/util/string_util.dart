import 'package:flutter/widgets.dart';

Color strintToColor(String colorStr, {double alpha = 1}) {
  var hexColor = colorStr.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    var alphaInt = (0xFF * alpha).toInt();
    var alphaString = alphaInt.toRadixString(16);

    hexColor = '$alphaString$hexColor';
  }
  return Color(int.parse(hexColor, radix: 16));
}

bool stringHasEllipsis(
    {required double maxWidth,
    int? maxLines,
    required String text,
    required TextStyle style}) {
  final span = TextSpan(text: text, style: style);
  final tp = TextPainter(
      text: span,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      ellipsis: 'EllipseText');

  tp.layout(maxWidth: maxWidth);

  return tp.didExceedMaxLines;
}
