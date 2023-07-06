import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';

class TextTween extends Tween<double> {
  TextTween({required double begin, required double end})
      : super(begin: begin, end: end);
  bool flag = false;

  @override
  double lerp(double t) {
    print(t);
    return (1000 - 1000 * t);
  }
}

class MXCountDownMillsecond extends StatefulWidget {
  const MXCountDownMillsecond({super.key, required this.fontStyle, this.color});

  final MXFontStyle fontStyle;
  final Color? color;

  @override
  State<MXCountDownMillsecond> createState() => _MXCountDownMillsecondState();
}

class _MXCountDownMillsecondState extends State<MXCountDownMillsecond>
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
