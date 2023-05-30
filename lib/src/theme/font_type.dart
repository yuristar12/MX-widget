class FontStyle {
  late double size;
  late double lineHeight;

  FontStyle({required int size, required int lineHeight}) {
    this.size = size.toDouble();
    this.lineHeight = size.toDouble();
  }

  factory FontStyle.fromJson(Map<String, dynamic> map) {
    return FontStyle(size: map['size'], lineHeight: map['lineHeight']);
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
