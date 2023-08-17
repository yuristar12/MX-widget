typedef EventCenterCallback = void Function<T>({T? params});

abstract class AbstractEventCenter {
  AbstractEventCenter register(String eventName, EventCenterCallback callback);

  AbstractEventCenter off(String eventName, {EventCenterCallback? callback});

  AbstractEventCenter offAll();

  AbstractEventCenter once(String eventName, EventCenterCallback callback);

  void trigger<T>(String eventName, {T? params});
}
