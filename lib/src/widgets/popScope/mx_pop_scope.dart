import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mx_widget/mx_widget.dart';

/// --------------------------------------------------------------左滑两次退出组件
/// [child] 当前组件包裹的child部件类型为scaffold，其它不生效。
/// [customConfrim] 自定义成功的回调方法
/// [customText] 自定义提示内容
/// [duration] 下一次滑动的有效时间范围

// ignore: must_be_immutable
class MXPopScope extends StatelessWidget {
  MXPopScope(
      {super.key,
      required this.child,
      this.customConfrim,
      this.customText,
      this.duration = const Duration(seconds: 2)});

  final Scaffold child;

  final Duration duration;

  final VoidCallback? customConfrim;

  final String? customText;

  DateTime? onPopTime;

  void _onWillPop(BuildContext context) async {
    if (onPopTime != null && DateTime.now().difference(onPopTime!) < duration) {
      customConfrim != null
          ? customConfrim!.call()
          : () async {
              await SystemChannels.platform
                  .invokeListMethod('SystemNavigator.pop');
            }();
      return;
    }
    onPopTime = DateTime.now();
    MXToast()
        .toastByText(context, customText ?? "再按一次推出App", duration: duration);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _onWillPop(context);
          return Future.value(false);
        },
        child: child);
  }
}
