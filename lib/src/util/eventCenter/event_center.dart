import 'package:mx_widget/src/util/eventCenter/abstract_event_center.dart';
import 'package:mx_widget/src/util/eventCenter/event_center_callback_model.dart';

/// 组件库自带的消息事件订阅中心
class EventCenter extends AbstractEventCenter {
  EventCenter();

  static Map<String, List<EventCenterCallbackModel>> eventList = {};

  @override
  AbstractEventCenter register(String eventName, EventCenterCallback callback) {
    onRegister(eventName, callback);

    return this;
  }

  /// 判断是否存在事件
  static bool hasEvent(String eventName) {
    return eventList.containsKey(eventName);
  }

  /// 注册事件
  void onRegister(String eventName, EventCenterCallback callback) {
    registerEvent(eventName, callback, isOnce: false);
  }

  /// 添加一个事件监听，并在事件触发完成之后移除Callbacks
  @override
  AbstractEventCenter once(String eventName, EventCenterCallback callback) {
    registerEvent(eventName, callback, isOnce: true);
    return this;
  }

  /// 取消一个事件
  /// [callback] 如果传入了callback则清除指定的事件，不影响该事件名称下的其它回调，反之则全部清除该事件名称下的所有回调
  @override
  AbstractEventCenter off(String eventName, {EventCenterCallback? callback}) {
    bool isExits = hasEvent(eventName);

    if (isExits) {
      if (callback != null) {
        List<EventCenterCallbackModel>? list = eventList[eventName];

        if (list != null) {
          for (var element in list) {
            if (element.callback == callback) {
              list.remove(element);
              break;
            }
          }
        }
      } else {
        eventList.remove(eventName);
      }
    }

    return this;
  }

  /// 触发事件
  @override
  void trigger<T>(String eventName, {T? params}) {
    bool isExits = hasEvent(eventName);

    if (isExits) {
      List<EventCenterCallbackModel>? list = eventList[eventName];
      if (list != null) {
        for (var element in list) {
          element.callback.call(params: params);

          if (element.isOnce) {
            off(eventName, callback: element.callback);
          }
        }
      }
    }
  }

  /// 清除所有事件
  @override
  AbstractEventCenter offAll() {
    eventList = {};
    return this;
  }

  /// 开始注册事件
  static void registerEvent(String eventName, EventCenterCallback callback,
      {required bool isOnce}) {
    EventCenterCallbackModel model =
        EventCenterCallbackModel(isOnce: isOnce, callback: callback);

    if (eventList.containsKey(eventName)) {
      eventList[eventName]?.add(model);
    } else {
      List<EventCenterCallbackModel> list = [];
      list.add(model);
      eventList[eventName] = list;
    }
  }
}
