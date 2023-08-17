import 'package:mx_widget/src/util/eventCenter/abstract_event_center.dart';

class EventCenterCallbackModel {
  EventCenterCallbackModel({
    required this.isOnce,
    required this.callback,
  });

  final bool isOnce;

  final EventCenterCallback callback;
}
