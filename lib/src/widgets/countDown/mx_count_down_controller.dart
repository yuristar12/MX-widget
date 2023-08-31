import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mx_widget/src/widgets/countDown/mx_count_down_model.dart';

import '../../../mx_widget.dart';

class MXCountDownController {
  MXCountDownController({
    required this.time,
    this.onChange,
    this.onFinish,
    this.downSpace = 1,
  }) : assert(() {
          if (time < 1000) {
            throw FlutterError('时间必须为毫秒');
          }
          return true;
        }()) {
    //  初始化并且设置视图层的模型
    _setModel();
  }

  /// [time] 倒计时长
  int time;

  /// [onChange] 值变更时的回调方法
  MXCountDownOnChange? onChange;

  /// [onFinish] 倒计时结束时的回调方法
  MXCountDownOnFinish? onFinish;

  /// [downSpace] 自定义倒计时间隔
  int downSpace;

  /// [timer] 定时器
  Timer? timer;

  /// [isOver] 记录是否记录定时是否结束
  bool isOver = false;

  /// 视图层
  MXCountDownState? state;

  /// 视图层model
  MXCountDownModel? model;

  bool isPause = true;

  /// 开始倒计时
  void startDown() {
    if (isOver) return;
    _cancelTimer();
    isPause = false;

    int timeSpace = downSpace * 1000;

    timer = Timer.periodic(Duration(seconds: downSpace), (timer) {
      if (time > timeSpace) {
        time -= timeSpace;
        onChange?.call(time);
      } else {
        time = 0;
        overTimer();
        onFinish?.call();
      }
      _setModel();
      state?.onUpdateLayout();
    });
  }

  /// 取消定时器
  void _cancelTimer() {
    isPause = true;
    timer?.cancel();
    timer = null;
  }

  /// 暂停定时器方法
  void pauseTimer() {
    _cancelTimer();
  }

  /// 结束定时器
  void overTimer() {
    isOver = true;
    _cancelTimer();
    state?.onUpdateLayout();
  }

  void setState(MXCountDownState state) {
    this.state = state;
  }

  int _getDay() {
    int day = (time / 86400000).floorToDouble().toInt();
    return day;
  }

  int _getHour() {
    int hour = (time / 3600000).floorToDouble().toInt();
    return hour;
  }

  int _getMinute() {
    int minute = (time % 3600000) ~/ 60000;
    return minute;
  }

  int _getSecond() {
    int second = (time % 60000) ~/ 1000;

    return second;
  }

  void _setModel() {
    model ??= MXCountDownModel();

    model!.setModel(_getDay(), _getHour(), _getMinute(), _getSecond());
  }
}
