import 'package:flutter/widgets.dart';

/// [title] 标题
/// [icon] icon图标
/// [useClose] 是否显示关闭icon
/// [link] 按钮文字
/// [useScroll] 是否开启滚动
/// [onClose] 当关闭时的回调事件
/// [onButtonClick] 存在button按钮时的按钮点击事件

class MXMessageModel {
  MXMessageModel(
      {required this.title,
      this.icon,
      this.link,
      this.onButtonClick,
      this.onClose,
      this.duration = 3000,
      this.useClose = false,
      this.offsetY = 0,
      this.useScroll = false});

  final String title;
  final IconData? icon;

  final String? link;

  final bool useScroll;

  final bool useClose;

  final VoidCallback? onClose;

  final VoidCallback? onButtonClick;

  final int duration;

  final double offsetY;
}
