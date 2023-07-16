import 'dart:ui';

extension DoubleScale on double {
  double get scale {
    /// 屏幕的逻辑宽度=屏幕物理宽度/屏幕的像素倍数
    // ignore: deprecated_member_use
    var screenWidth = window.physicalSize.width / window.devicePixelRatio;

    /// 设计稿用的是750的宽度
    return screenWidth / 375.0 * this;
  }
}

extension IntScale on double {
  double get scale {
    /// 屏幕的逻辑宽度=屏幕物理宽度/屏幕的像素倍数
    // ignore: deprecated_member_use
    var screenWidth = window.physicalSize.width / window.devicePixelRatio;

    /// 设计稿用的是750的宽度
    return screenWidth / 375 * this;
  }
}
