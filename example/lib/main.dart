import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
// ignore: implementation_imports
import 'package:mx_widget/src/export.dart';

void main() {
  runApp(const MyApp());
}

/// 组件示例项目
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
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
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  MXButtonThemeEnum themeEnum = MXButtonThemeEnum.primary;
  TabController? _tabController;

  bool disabled = false;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      _counter = Calculator().addOne(_counter);

      disabled = !disabled;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void Test() {}

  @override
  Widget build(BuildContext context) {
    MXCheckBoxSeriesController controller = MXCheckBoxSeriesController();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      bottomNavigationBar: MXBottomNavBar(
          defaultActiviteIndex: 2,
          useTopBorder: true,
          useSafeArea: true,
          bottomNavBarTypeEnum: MXBottomNavBarTypeEnum.iconText,
          bottomNavBarShapeEnum: MXBottomNavBarShapeEnum.rectangle,
          bottomNavBarItemTypeEnum: MXBottomNavBarItemTypeEnum.weak,
          bottomNavBarItemList: [
            MXBottomNavBarItemConfig(
                onTap: () {},
                mxBottomNavBarIconTextConfig:
                    MXBottomNavBarIconTextConfig(text: '页面'),
                mxBottomNavBarItemBadgeConfig:
                    MXBottomNavBarItemBadgeConfig(show: true)),
            MXBottomNavBarItemConfig(
                onTap: () {},
                mxBottomNavBarIconTextConfig:
                    MXBottomNavBarIconTextConfig(text: '页面')),
            MXBottomNavBarItemConfig(
                onTap: () {},
                mxBottomNavBarIconTextConfig:
                    MXBottomNavBarIconTextConfig(text: '页面')),
            MXBottomNavBarItemConfig(
                onTap: () {},
                mxBottomNavBarIconTextConfig:
                    MXBottomNavBarIconTextConfig(text: '页面')),
          ]),

      body: SingleChildScrollView(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: 300,
                  child: Swiper(
                      loop: true,
                      autoplay: true,
                      pagination: MXSwiperControllBar(
                          builder: MXSwiperPointControllerBar()),
                      itemBuilder: (BuildContext context, index) {
                        return const MXImage(
                            height: 300,
                            netUrl:
                                "https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg");
                      },
                      itemCount: 5)),
              SizedBox(
                height: MXTheme.of(context).space12,
              ),
              SizedBox(
                  height: 300,
                  child: Swiper(
                      viewportFraction: 0.88,
                      loop: true,
                      autoplay: true,
                      transformer: MXPagetransform.transToMargin(margin: 6),
                      pagination: MXSwiperControllBar(
                          builder: MXSwiperPointControllerBar()),
                      itemBuilder: (BuildContext context, index) {
                        return const MXImage(
                            height: 300,
                            netUrl:
                                "https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg");
                      },
                      itemCount: 5)),
              SizedBox(
                height: MXTheme.of(context).space12,
              ),

              MXButton(
                text: '时间选择器',
                icon: Icons.ac_unit,
                disabled: disabled,
                themeEnum: themeEnum,
                afterClickButtonCallback: () {
                  MXPickers().showDatePicker(
                    context,
                    DatePickerQuery(),
                    DatePickerParams(
                        useSaftArea: true,
                        datePickerFormatType: DatePickerFormatType.MM_DD),
                  );
                },
                typeEnum: MXButtonTypeEnum.fill,
                shape: MXButtonShapeEnum.round,
                sizeEnum: MXButtonSizeEnum.medium,
              ),
              SizedBox(
                height: MXTheme.of(context).space12,
              ),

              MXButton(
                text: 'options选择器',
                icon: Icons.ac_unit,
                disabled: disabled,
                themeEnum: themeEnum,
                afterClickButtonCallback: () {
                  MXPickers().showOptionsPicker(
                    context,
                    OptionsPickerParams(
                      onConfirm: (p0) {
                        print(p0);
                      },
                    ),
                    MXOptionsQuery(
                      options: [
                        [
                          {"label": '选项一', "value": '1'},
                          {"label": '选项二', "value": '2'},
                          {"label": '选项三', "value": '3'},
                          {"label": '选项四', "value": '4'}
                        ],
                        [
                          {"label": '列1', "value": '1'},
                          {"label": '列2', "value": '2'},
                          {"label": '列3', "value": '3'},
                          {"label": '列4', "value": '4'}
                        ]
                      ],
                      initialValue: ['2', '4'],
                    ),
                  );
                },
                typeEnum: MXButtonTypeEnum.fill,
                shape: MXButtonShapeEnum.round,
                sizeEnum: MXButtonSizeEnum.medium,
              ),
              MXTabBar(
                  controller: _tabController,
                  showIndicator: true,
                  indicatorHeight: 3,
                  indicatorWidth: 16,
                  backgroundColor: Colors.white,
                  tabs: const [
                    MXTab(
                      text: "选项",
                      disabled: true,
                    ),
                    MXTab(
                      text: "选项",
                    ),
                    MXTab(
                      text: "选项",
                    ),
                    MXTab(
                      text: "选项",
                    )
                  ]),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),

              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            shapeEnum: MXTagshapeEnum.round,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            shapeEnum: MXTagshapeEnum.round,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            shapeEnum: MXTagshapeEnum.round,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            shapeEnum: MXTagshapeEnum.round,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            shapeEnum: MXTagshapeEnum.round,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(MXTheme.of(context).space8),
                            child: Text(
                              '徽标',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MXTheme.of(context).fontUsePrimaryColor,
                                fontSize:
                                    MXTheme.of(context).fontBodySmall!.size,
                              ),
                            ),
                          ),
                          const Positioned(
                              right: 5,
                              child: MXBadge(
                                typeEnum: MXBadgeTypeEnum.square,
                                badgeCount: 8,
                                sizeEnum: MXBadgeSizeEnum.small,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            text: "这是一个tag",
                            modeEnum: MXTagModeEnum.plain,
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.plain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            modeEnum: MXTagModeEnum.plain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.plain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                            modeEnum: MXTagModeEnum.plain,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.plain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            modeEnum: MXTagModeEnum.plain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.plain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            modeEnum: MXTagModeEnum.plain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.plain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(MXTheme.of(context).space8),
                            child: Text(
                              '徽标',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MXTheme.of(context).fontUsePrimaryColor,
                                fontSize:
                                    MXTheme.of(context).fontBodySmall!.size,
                              ),
                            ),
                          ),
                          const Positioned(
                              right: 5,
                              child: MXBadge(
                                typeEnum: MXBadgeTypeEnum.square,
                                badgeCount: 8,
                                sizeEnum: MXBadgeSizeEnum.small,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            text: "这是一个tag",
                            modeEnum: MXTagModeEnum.outline,
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outline,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            modeEnum: MXTagModeEnum.outline,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outline,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                            modeEnum: MXTagModeEnum.outline,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outline,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            modeEnum: MXTagModeEnum.outline,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outline,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            modeEnum: MXTagModeEnum.outline,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outline,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(MXTheme.of(context).space8),
                            child: Text(
                              '徽标',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MXTheme.of(context).fontUsePrimaryColor,
                                fontSize:
                                    MXTheme.of(context).fontBodySmall!.size,
                              ),
                            ),
                          ),
                          const Positioned(
                              right: 5,
                              child: MXBadge(
                                typeEnum: MXBadgeTypeEnum.square,
                                badgeCount: 8,
                                sizeEnum: MXBadgeSizeEnum.small,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            text: "这是一个tag",
                            modeEnum: MXTagModeEnum.outlinePlain,
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                            modeEnum: MXTagModeEnum.outlinePlain,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            text: "这是一个tag",
                            modeEnum: MXTagModeEnum.outlinePlain,
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.info,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                            modeEnum: MXTagModeEnum.outlinePlain,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.success,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.warning,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                          MXTag(
                            themeEnum: MXTagThemeEnum.danger,
                            shapeEnum: MXTagshapeEnum.round,
                            modeEnum: MXTagModeEnum.outlinePlain,
                            text: "这是一个tag",
                            icon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              MXSelectTag(
                text: "selectTag",
                isSelect: false,
                modeEnum: MXTagModeEnum.outlinePlain,
              ),

              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  MXIcon(
                    icon: Icons.accessibility,
                    iconSizeEnum: MXIconSizeEnum.small,
                  ),
                  MXIcon(
                    icon: Icons.accessibility,
                    iconSizeEnum: MXIconSizeEnum.medium,
                  ),
                  MXIcon(
                    icon: Icons.accessibility,
                    iconSizeEnum: MXIconSizeEnum.large,
                  ),
                ],
              ),
              MXIcon(
                icon: Icons.accessibility,
                action: () {},
              ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              MXNavBar(
                onHandleBack: () {
                  print('object');
                },
                backgroundColor: MXTheme.of(context).brandPrimaryColor,
                titleColor: MXTheme.of(context).whiteColor,
                titleWeight: FontWeight.bold,
                useTitleCenter: true,
                titleContent: "这是一个导航栏",
                navBarChild: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(MXTheme.of(context).space8),
                        child: Text(
                          '徽标',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: MXTheme.of(context).fontUsePrimaryColor,
                            fontSize: MXTheme.of(context).fontBodySmall!.size,
                          ),
                        ),
                      ),
                      const Positioned(
                          right: 5,
                          top: 5,
                          child: MXBadge(
                            typeEnum: MXBadgeTypeEnum.square,
                            badgeCount: 8,
                            sizeEnum: MXBadgeSizeEnum.small,
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              const MXDivideLine(
                alignment: MXDivideAlignmentEnum.left,
                text: '分割线',
              ),
              const MXDivideLine(
                alignment: MXDivideAlignmentEnum.center,
                text: '分割线',
              ),
              const MXDivideLine(
                useTextDivide: true,
                alignment: MXDivideAlignmentEnum.center,
                text: '分割线',
              ),
              const MXDivideLine(
                alignment: MXDivideAlignmentEnum.right,
                text: '分割线',
              ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '信息1',
                    style: TextStyle(
                        color: MXTheme.of(context).fontUsePrimaryColor,
                        fontSize: MXTheme.of(context).fontBodyMedium!.size),
                  ),
                  const MXDivideLine(
                    width: 1,
                    height: 16,
                  ),
                  Text(
                    '信息2',
                    style: TextStyle(
                        color: MXTheme.of(context).fontUsePrimaryColor,
                        fontSize: MXTheme.of(context).fontBodyMedium!.size),
                  ),
                  const MXDivideLine(
                    width: 1,
                    height: 16,
                  ),
                  Text(
                    '信息3',
                    style: TextStyle(
                        color: MXTheme.of(context).fontUsePrimaryColor,
                        fontSize: MXTheme.of(context).fontBodyMedium!.size),
                  ),
                ],
              ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              Container(
                width: 200,
                height: 200,
                color: Colors.red,
                alignment: Alignment.center,
                child: const MXImage(
                  width: 100,
                  height: 100,
                  modeEnum: MXImageModeEnum.cover,
                  netUrl:
                      'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                ),
              ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              const MXAvatar(
                sizeEnum: MXAvatarSizeEnum.medium,
                shapeEnum: MXAvatarShapeEnum.square,
                modeEnum: MXAvatarModeEnum.icon,
              ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              // const MXAvatar(
              //   avatarNetUrl:
              //       "https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp",
              //   sizeEnum: MXAvatarSizeEnum.lager,
              //   shapeEnum: MXAvatarShapeEnum.square,
              //   modeEnum: MXAvatarModeEnum.img,
              // ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              // MXAvatar(
              //   avatarNetUrlList: const [
              //     'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp',
              //     'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp',
              //     'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp'
              //   ],
              //   avatarAppendixText: "+5",
              //   avatarAppendixCallback: () {},
              //   sizeEnum: MXAvatarSizeEnum.medium,
              //   shapeEnum: MXAvatarShapeEnum.circle,
              //   modeEnum: MXAvatarModeEnum.imgList,
              // ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              Padding(
                padding: EdgeInsets.all(MXTheme.of(context).space16),
                child: MXCheckBox(
                  title: "选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择框",
                  desSub:
                      "选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择框选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择框",
                  modeEnum: MXCheckBoxModeEnum.card,
                  directionEnum: MXCheckBoxDirectionEnum.left,
                  onCheckBoxValueChange: (isChecked) {
                    print(isChecked);
                  },
                ),
              ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              MXCheckBoxSeries(
                  checkIds: ["1"],
                  useIndeterminate: true,
                  checkBoxSeriesController: controller,
                  modeEnum: MXCheckBoxModeEnum.card,
                  direction: Axis.vertical,
                  onCheckBoxSeriesValueChange: (value) {
                    print(value);
                  },
                  checkBoxs: [
                    MXCheckBox(
                      id: "1",
                      title: "选择选择选择选择选择选择",
                      showDivide: false,
                      iconSpace: 0,
                      modeEnum: MXCheckBoxModeEnum.card,
                      directionEnum: MXCheckBoxDirectionEnum.left,
                      onCheckBoxValueChange: (isChecked) {},
                    ),
                    MXCheckBox(
                      id: "2",
                      title: "选择",
                      showDivide: false,
                      iconSpace: 0,
                      modeEnum: MXCheckBoxModeEnum.card,
                      directionEnum: MXCheckBoxDirectionEnum.left,
                      onCheckBoxValueChange: (isChecked) {},
                    ),
                    MXCheckBox(
                      id: "3",
                      title: "选择",
                      showDivide: false,
                      iconSpace: 0,
                      modeEnum: MXCheckBoxModeEnum.card,
                      directionEnum: MXCheckBoxDirectionEnum.left,
                      onCheckBoxValueChange: (isChecked) {},
                    ),
                    MXCheckBox(
                      id: "4",
                      title: "选择",
                      showDivide: false,
                      iconSpace: 0,
                      modeEnum: MXCheckBoxModeEnum.card,
                      directionEnum: MXCheckBoxDirectionEnum.left,
                      onCheckBoxValueChange: (isChecked) {},
                    )
                  ]),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
              const MXSwitch(
                isOn: false,
                disabled: false,
                modeEnum: MXSwitchModeEnum.icon,
                sizeEnum: MXSwitchSizeEnum.lager,
              ),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),

              MXRadio(
                title: "radio组件",
              ),

              MXRadioSeries(
                  checkIds: ["3"],
                  direction: Axis.vertical,
                  checkRadios: [
                    MXRadio(
                      id: '1',
                      title: "radio组件1",
                      showDivide: true,
                    ),
                    MXRadio(
                      id: '2',
                      title: "radio组件2",
                      showDivide: true,
                    ),
                    MXRadio(
                      id: '3',
                      title: "radio组件3",
                      showDivide: true,
                    ),
                    MXRadio(
                      id: '4',
                      title: "radio组件4",
                    ),
                  ]),
              SizedBox(
                height: MXTheme.of(context).space32,
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
