<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

这是一个包含了一些开发时常用的Flutter组件库。

## Features

包含：avatar/badge/bottomNavBar/button/checkBox/circleLoading/divideLine/icon/image/input/navBar/picker/radio/skeleton/swiper/switch/tabBar/tag/toast组件


## Usage



```dart
///引用组件库暴露的所有文件
import 'package:mx_widget/src/export.dart';
/// 使用组件库
  Widget build(BuildContext context) {
    return MXTheme(

        /// 需要将themeConfig放在前面先执行才能使自定义主题生效，否则主题的配置还是默认的
        themeConfig: MXThemeConfig.cacheThemeConfig(customThemeConfig: {
          // "color": {
          //   "brandColor1": "#FFF8F2",
          //   "brandColor2": "#FDDAC6",
          //   "brandColor3": "#ECAE91",
          //   "brandColor4": "#BE7055",
          //   "brandColor5": "#652B1C",
          //   "brandColor6": "#56180E",
          //   "brandColor7": "#460D07",
          //   "brandColor8": "#360605",
          //   "brandColor9": "#260303",
          //   "brandPrimaryColor": "#652B1C",
          //   "brandFocusColor": "#BE7055",
          //   "brandDisabledColor": "#ECAE91",
          //   "brandClickColor": "#56180E"
          // }
        }),
        widget: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              colorScheme: ColorScheme.light(
                  primary: MXTheme.of(context).brandPrimaryColor)),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }

```

## Additional information

组件库还在构建当中，可能存在BUG，如存在请在github中联系我。
