import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';

class MXCountDownMillSecond extends StatefulWidget {
  const MXCountDownMillSecond({super.key, required this.fontStyle, this.color});

  final MXFontStyle fontStyle;
  final Color? color;

  @override
  State<MXCountDownMillSecond> createState() => _MXCountDownMillSecondState();
}

class _MXCountDownMillSecondState extends State<MXCountDownMillSecond>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..fling();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        animationController.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  int _getTextValue(double animationValue) {
    /// 这里不用1000是防止页面抖动所以采用了999与100固定位数
    int value = (999 - 999 * animationValue).toInt();
    return value <= 100 ? 100 : value;
  }

  Widget _buildText() {
    return AnimatedBuilder(
        animation: _animation,
        builder: ((BuildContext context, child) {
          return MXText(
            isLine: false,
            isNumber: true,
            font: widget.fontStyle,
            textColor: widget.color,
            data: '${_getTextValue(_animation.value)}',
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return _buildText();
  }
}
