import 'package:flutter/cupertino.dart';

class MXFontStyle {
  late double size;
  late double lineHeight;
  late FontWeight fontWeight;

  MXFontStyle(
      {required int size,
      required int lineHeight,
      this.fontWeight = FontWeight.w400}) {
    this.size = size.toDouble();
    this.lineHeight = lineHeight.toDouble();
  }

  factory MXFontStyle.fromJson(Map<String, dynamic> map) {
    return MXFontStyle(size: map['size'], lineHeight: map['lineHeight']);
  }

  double get heightRate {
    return lineHeight / size;
  }
}

class FontFamily {
  late String fontFamily;

  FontFamily({required this.fontFamily});

  factory FontFamily.fromJson(Map<String, dynamic> map) {
    return FontFamily(fontFamily: map['fontFamily']);
  }
}
