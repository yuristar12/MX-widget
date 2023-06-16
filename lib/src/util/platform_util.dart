import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformUtil {
  static bool get android {
    return !kIsWeb && Platform.isAndroid;
  }

  static bool get ios {
    return !kIsWeb && Platform.isIOS;
  }

  static bool get web {
    return kIsWeb;
  }
}
