import 'dart:async';

import 'package:example/custom_upload_hooks.dart';
import 'package:example/test.dart';
import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

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
  MXButtonThemeEnum themeEnum = MXButtonThemeEnum.primary;
  TabController? _tabController;

  bool disabled = false;

  MXCheckBoxSeriesController controller = MXCheckBoxSeriesController();

  TextEditingController textEditingController = TextEditingController();

  MXAuthCodeController mxAuthCodeController = MXAuthCodeController(
    codeNum: 6,
    onConfirm: (p0) {},
  );

  late MXCountDownController countDownController;

  late MXProgressController progressController;

  late MXProgressController progressControllerCirc;

  late MXStepsController stepsController;

  late MXStepsController stepsController2;

  late MXSideBarController sideBarController;

  late MXSideBarController sideBarController2;

  late MXFabButtonController fabButtonController;

  late MXCascaderController mxCascaderController;

  late MXFormController mxFormController;

  late MXCalendarController mxCalendarController;

  late MXIndexesController mxIndexesController;

  late MXUploadImgController mxUploadImgController;

  @override
  void initState() {
    super.initState();

    countDownController = MXCountDownController(
      time: 1000 * 10,
      onFinish: () {
        MXToast().toastBySuccess(context, '倒计时结束');
      },
    );
    _tabController = TabController(length: 4, vsync: this);

    progressController = MXProgressController(initValue: 25);

    progressControllerCirc = MXProgressController(initValue: 25);

    sideBarController = MXSideBarController(
        sideBarItemBuilder: (model, isActivity) {
          return Container(
            width: 120,
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    gradient: isActivity
                        ? LinearGradient(colors: [
                            MXTheme.of(context).brandPrimaryColor,
                            MXTheme.of(context).brandColor8,
                          ])
                        : null,
                    borderRadius:
                        BorderRadius.circular(MXTheme.of(context).radiusRound)),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: MXText(
                  font: MXTheme.of(context).fontBodySmall,
                  data: model.title,
                  textColor: isActivity
                      ? MXTheme.of(context).whiteColor
                      : MXTheme.of(context).fontUsePrimaryColor,
                ),
              ),
            ),
          );
        },
        sideBarItemList: [
          MXSideBarItemModel(
            title: '自定义样式',
            id: "1",
            builder: (index) {
              return Container(
                color: MXTheme.of(context).whiteColor,
                child: MXGrid(
                    space: 0,
                    useBorder: false,
                    size: MXGirdSizeEnum.medium,
                    column: 3,
                    gridItemAxis: Axis.vertical,
                    itemList: List.generate(
                      40,
                      (index) => MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                    )),
              );
            },
          ),
          MXSideBarItemModel(
            title: '面部精华',
            id: "2",
            builder: (index) {
              return Container(
                height: 1200,
                color: MXTheme.of(context).successPrimaryColor,
              );
            },
          ),
          MXSideBarItemModel(
            title: '乳液面霜',
            id: "3",
            builder: (index) {
              return Container(
                height: 1200,
                color: MXTheme.of(context).errorPrimaryColor,
              );
            },
          ),
          MXSideBarItemModel(
            title: '眼部护理',
            id: "4",
            builder: (index) {
              return Container(
                height: 1200,
                color: MXTheme.of(context).warnPrimaryColor,
              );
            },
          )
        ]);

    sideBarController2 = MXSideBarController(sideBarItemList: [
      MXSideBarItemModel(
        title: '柏溪推荐',
        id: "1",
        builder: (index) {
          return Container(
            color: MXTheme.of(context).whiteColor,
            child: MXGrid(
                space: 0,
                useBorder: false,
                size: MXGirdSizeEnum.medium,
                column: 3,
                gridItemAxis: Axis.vertical,
                itemList: List.generate(
                  40,
                  (index) => MXGridItemModel(
                    title: '标题文字',
                    netUrl:
                        'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                  ),
                )),
          );
        },
      ),
      MXSideBarItemModel(
        title: '面部精华',
        id: "2",
        builder: (index) {
          return Container(
            height: 1200,
            color: MXTheme.of(context).successPrimaryColor,
          );
        },
      ),
      MXSideBarItemModel(
        title: '乳液面霜',
        id: "3",
        builder: (index) {
          return Container(
            height: 1200,
            color: MXTheme.of(context).errorPrimaryColor,
          );
        },
      ),
      MXSideBarItemModel(
        title: '眼部护理',
        id: "4",
        builder: (index) {
          return Container(
            height: 1200,
            color: MXTheme.of(context).warnPrimaryColor,
          );
        },
      )
    ]);

    stepsController = MXStepsController(
      stepsItems: [
        MXStepsItemModel(
            title: '未完成',
            pastTitle: '已完成',
            activityTitle: '当前步骤',
            description: '描述信息描述信息描述信息',
            pluginWidget: Container(
              height: 300,
              color: Colors.red,
            )),
        MXStepsItemModel(
            title: '未完成',
            pastTitle: '已完成',
            activityTitle: '当前步骤',
            description: '描述信息'),
        MXStepsItemModel(
            title: '未完成',
            pastTitle: '已完成',
            activityTitle: '当前步骤',
            description: '描述信息'),
        MXStepsItemModel(
            title: '未完成',
            pastTitle: '已完成',
            activityTitle: '当前步骤',
            description: '描述信息')
      ],
      onAction: () {},
    );

    stepsController2 = MXStepsController(
      stepsItems: [
        MXStepsItemModel(
            icon: Icons.public_outlined,
            title: '未完成',
            pastTitle: '已完成',
            activityTitle: '当前步骤',
            description: '描述信息',
            pluginWidget: Container(
              height: 300,
              color: Colors.red,
            )),
        MXStepsItemModel(
            icon: Icons.public_outlined,
            title: '未完成',
            pastTitle: '已完成',
            activityTitle: '当前步骤',
            description: '描述信息'),
        MXStepsItemModel(
            icon: Icons.public_outlined,
            title: '未完成',
            pastTitle: '已完成',
            activityTitle: '当前步骤',
            description: '描述信息'),
        MXStepsItemModel(
            icon: Icons.public_outlined,
            title: '未完成',
            pastTitle: '已完成',
            activityTitle: '当前步骤',
            description: '描述信息')
      ],
      onAction: () {},
    );

    fabButtonController = MXFabButtonController(
        context: context,
        model: MXFabButtonModel(
            icon: Icons.check,
            text: '按钮文字',
            afterClickButtonCallback: () {
              MXToast().toastBySuccess(context, "点击成功");
            },
            themeEnum: MXButtonThemeEnum.primary,
            sizeEnum: MXButtonSizeEnum.large));

    mxCascaderController = MXCascaderController(
        onChange: (id, lastSelectOption) {},
        onClose: () {
          // print('关闭');
        },
        onPick: (lastSelectOption) {
          // print(lastSelectOption);
        },
        options: [
          MXCascaderOptions(label: "北京市", value: "110000", children: [
            MXCascaderOptions(label: "北京市", value: "110100", children: [
              MXCascaderOptions(
                label: "东城区",
                value: "110101",
              ),
              MXCascaderOptions(
                label: "西城区",
                value: "110102",
              ),
              MXCascaderOptions(
                label: "丰台区",
                value: "110105",
              ),
              MXCascaderOptions(
                label: "石景山区",
                value: "110106",
              ),
              MXCascaderOptions(
                label: "海淀区",
                value: "110107",
              ),
              MXCascaderOptions(
                label: "门头沟区",
                value: "110108",
              ),
              MXCascaderOptions(
                label: "房山区",
                value: "110109",
              ),
              MXCascaderOptions(
                label: "通州区",
                value: "110110",
              ),
            ]),
          ]),
          MXCascaderOptions(label: "天津市", value: "120000", children: [
            MXCascaderOptions(
              value: '120100',
              label: '天津市',
              children: [
                MXCascaderOptions(value: '120101', label: '和平区'),
                MXCascaderOptions(value: '120102', label: '河东区'),
                MXCascaderOptions(value: '120103', label: '河西区'),
                MXCascaderOptions(value: '120104', label: '南开区'),
              ],
            ),
          ])
        ]);

    mxFormController = MXFormController(rules: {
      'switch': [
        MXFormRule(
          required: true,
        )
      ],
      'rate': [
        MXFormRule(
          required: true,
          message: '分数过低',
          validator: (value) {
            if (value < 3.0) {
              return MXFormRuleResult(result: false, message: '自定义错误提示');
            }
            return MXFormRuleResult(result: true);
          },
        )
      ],
    });

    mxCalendarController = MXCalendarController(
      // defaultValue: MXCalendarValueByRange(
      //     startTime: DateTime(2021, 1, 22), endTime: DateTime(2021, 1, 26)),
      // defaultValue: [DateTime(2021, 1, 22), DateTime(2021, 1, 26)],
      // defaultValue: DateTime(2021, 1, 22),
      aweakColor: MXTheme.of(context).errorPrimaryColor,
      weaknessColor: MXTheme.of(context).errorColor2,
      typeEnum: MXCalendarTypeEnum.range,
      minDate: MXCalendarTime(2021, 1, 15),
      maxDate: MXCalendarTime(2021, 12, 3),
      onSelect: (DateTime time) {
        print(time);
      },
      // dayBuilder: (context, currentTime,
      //     {isActivity, isDisabled, isEnd, isRange, isStart}) {
      //   String text = currentTime.day.toString();
      //   Color textColor = MXTheme.of(context).fontUsePrimaryColor;

      //   if (isStart != null && isStart) {
      //     text = '放假';
      //     textColor = MXTheme.of(context).whiteColor;
      //   } else if (isEnd != null && isEnd) {
      //     text = '上班';
      //     textColor = MXTheme.of(context).whiteColor;
      //   } else if (isDisabled != null && isDisabled) {
      //     textColor = MXTheme.of(context).fontUseDisabledColor;
      //   }

      //   return Center(
      //     child: MXText(
      //       data: text,
      //       font: MXTheme.of(context).fontBodyMedium,
      //       fontWeight: FontWeight.bold,
      //       textColor: textColor,
      //     ),
      //   );
      // },
    );

    mxIndexesController = MXIndexesController(
        model: [
          MXIndexesModel(index: "A", children: <String>[
            '阿坝',
            '阿拉善',
            '阿里',
            '安康',
          ]),
          MXIndexesModel(index: "B", children: <String>[
            '北京',
            '白银',
            '保定',
            '宝鸡',
            '保山',
            '包头',
            '巴中',
            '北海',
            '蚌埠',
            '本溪',
            '毕节',
            '滨州',
            '百色',
            '亳州',
          ]),
          MXIndexesModel(index: "C", children: <String>[
            '重庆',
            '成都',
            '长沙',
            '长春',
            '沧州',
            '常德',
            '昌都',
            '长治',
            '常州',
            '巢湖',
            '潮州',
            '承德',
            '郴州',
            '赤峰',
            '池州',
            '崇左',
            '楚雄',
            '滁州',
            '朝阳',
          ]),
          MXIndexesModel(index: "D", children: <String>[
            '大连',
            '东莞',
            '大理',
            '丹东',
            '大庆',
            '大同',
            '大兴安岭',
            '德宏',
            '德阳',
            '德州',
            '定西',
            '迪庆',
            '东营',
          ]),
          MXIndexesModel(index: "E", children: <String>['鄂尔多斯', '恩施', '鄂州']),
          MXIndexesModel(
              index: "F",
              children: <String>['福州', '防城港', '佛山', '抚顺', '抚州', '阜新', '阜阳']),
          MXIndexesModel(index: "G", children: <String>[
            '广州',
            '桂林',
            '贵阳',
            '甘南',
            '赣州',
            '甘孜',
            '广安',
            '广元',
            '贵港',
            '果洛'
          ]),
        ],
        contentItemBuilder: <String>(String params) {
          return Container(
              child: MXCell(
                  model: MXCellModel(title: params.toString()), padding: 16));
        });

    mxUploadImgController = MXUploadImgController(
      hooks: CustomUploadHooks(),
      actionUrl: 'https://mx-admin-oa.oss-cn-hangzhou.aliyuncs.com',
      uploadType: MXUploadImgType.multiply,
      maxNum: 6,
      defaultValue: [
        'https://tdesign.gtimg.com/miniprogram/images/example4.png',
        'https://tdesign.gtimg.com/miniprogram/images/example4.png',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  MXButton(
                    text: '打开抽屉',
                    icon: Icons.calendar_month_outlined,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXDrawer(
                          model: MXDrawerModel(
                              optionsClick: (p0) {
                                print(p0);
                              },
                              onClose: () {
                                print('onClose');
                              },
                              footerBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MXButton(
                                      text: '操作按钮',
                                      typeEnum: MXButtonTypeEnum.plain,
                                      themeEnum: MXButtonThemeEnum.info,
                                    )
                                  ],
                                );
                              },
                              title: '标题',
                              options: [
                            MXDrawerOptionsModel(
                                title: "菜单一", icon: Icons.airplay_rounded),
                            MXDrawerOptionsModel(
                                title: "菜单二",
                                icon: Icons.airplay_rounded,
                                placement:
                                    MXDrawerOptionItemPlacementEnum.left),
                            MXDrawerOptionsModel(
                                title: "菜单三",
                                icon: Icons.airplay_rounded,
                                disabled: true),
                            MXDrawerOptionsModel(
                                title: "菜单四", icon: Icons.airplay_rounded),
                            MXDrawerOptionsModel(
                                title: "菜单五",
                                icon: Icons.airplay_rounded,
                                placement:
                                    MXDrawerOptionItemPlacementEnum.right),
                            MXDrawerOptionsModel(
                                title: "菜单六", icon: Icons.airplay_rounded),
                          ])).tovisibility(context);
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  MXNoticeBar(
                    scrollDirection: MXNoticeBarScrollDirectionEnum.vertical,
                    theme: MXNoticeThemeEnum.info,
                    suffixIcon: Icons.close_rounded,
                    contentList: [
                      '1。这是一段描述文字,这是一段描述文字,这是一段描述文字,这是一段描述文字。',
                      '2。这是一段描述文字,这是一段描述文字,这是一段描述文字,这是一段描述文字。',
                      '3。这是一段描述文字,这是一段描述文字,这是一段描述文字,这是一段描述文字。',
                      '4。这是一段描述文字,这是一段描述文字,这是一段描述文字,这是一段描述文字。'
                    ],
                    prefixIcon: Icons.notifications_none,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MXNoticeBar(
                    scrollDirection: MXNoticeBarScrollDirectionEnum.horizontal,
                    theme: MXNoticeThemeEnum.info,
                    suffixIcon: Icons.close_rounded,
                    content: "这是一段描述文字,这是一段描述文字,这是一段描述文字,这是一段描述文字。",
                    prefixIcon: Icons.notifications_none,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MXTheme.of(context).space16),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MXLink(
                          useUnderLine: true,
                          content: "跳转链接",
                          theme: MXLinkThemeEnum.info,
                          prefixIcon: Icons.share,
                          size: MXLinkSizeEnum.small,
                        ),
                        MXLink(
                          useUnderLine: true,
                          content: "跳转链接",
                          suffixIcon: Icons.share,
                          theme: MXLinkThemeEnum.error,
                          size: MXLinkSizeEnum.medium,
                        ),
                        MXLink(
                          useUnderLine: true,
                          content: "跳转链接",
                          suffixIcon: Icons.share,
                          theme: MXLinkThemeEnum.success,
                          size: MXLinkSizeEnum.large,
                        ),
                        MXLink(
                          useUnderLine: true,
                          content: "跳转链接",
                          suffixIcon: Icons.share,
                          theme: MXLinkThemeEnum.waring,
                          size: MXLinkSizeEnum.large,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MXTheme.of(context).space16),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MXLink(
                          disabled: true,
                          useUnderLine: true,
                          content: "跳转链接",
                          theme: MXLinkThemeEnum.info,
                          prefixIcon: Icons.share,
                          size: MXLinkSizeEnum.small,
                        ),
                        MXLink(
                          disabled: true,
                          useUnderLine: true,
                          content: "跳转链接",
                          suffixIcon: Icons.share,
                          theme: MXLinkThemeEnum.error,
                          size: MXLinkSizeEnum.medium,
                        ),
                        MXLink(
                          disabled: true,
                          useUnderLine: true,
                          content: "跳转链接",
                          suffixIcon: Icons.share,
                          theme: MXLinkThemeEnum.success,
                          size: MXLinkSizeEnum.large,
                        ),
                        MXLink(
                          disabled: true,
                          useUnderLine: true,
                          content: "跳转链接",
                          suffixIcon: Icons.share,
                          theme: MXLinkThemeEnum.waring,
                          size: MXLinkSizeEnum.large,
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  MXButton(
                    text: '打开普通消息',
                    icon: Icons.calendar_month_outlined,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXMessage.info(
                          context,
                          MXMessageModel(
                              duration: 3000,
                              title:
                                  '这一条普通消息,这一条普通消息,这一条普通消息,这一条普通消息,这一条普通消息,结尾。',
                              link: '链接',
                              useScroll: true,
                              useClose: false));
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  MXButton(
                    text: '打开actionsheetgrid布局面板',
                    icon: Icons.calendar_month_outlined,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXActionSheet(
                          typeEnum: MXActionSheetTypeEnum.grid,
                          actionSheetTitle: 'ActionSheet描述文字',
                          actionOptionsByGrid: [
                            MXActionSheetListModelByGrid(
                                label: "微信",
                                value: "wx",
                                disabled: true,
                                badge: MXBadge(
                                  typeEnum: MXBadgeTypeEnum.point,
                                ),
                                netImgUrl:
                                    'https://tdesign.gtimg.com/miniprogram/logo/wechat.png'),
                            MXActionSheetListModelByGrid(
                                label: "朋友圈",
                                value: "sns",
                                badge: MXBadge(
                                  typeEnum: MXBadgeTypeEnum.point,
                                ),
                                netImgUrl:
                                    'https://tdesign.gtimg.com/miniprogram/logo/times.png'),
                            MXActionSheetListModelByGrid(
                                label: "QQ",
                                value: "qq",
                                badge: MXBadge(
                                  typeEnum: MXBadgeTypeEnum.point,
                                ),
                                netImgUrl:
                                    'https://tdesign.gtimg.com/miniprogram/logo/qq.png'),
                            MXActionSheetListModelByGrid(
                                label: "企业微信",
                                value: "wecom",
                                badge: MXBadge(
                                  text: "99",
                                  typeEnum: MXBadgeTypeEnum.text,
                                ),
                                netImgUrl:
                                    'https://tdesign.gtimg.com/miniprogram/logo/wecom.png'),
                            MXActionSheetListModelByGrid(
                                label: "分享", value: "share", icon: Icons.share),
                            MXActionSheetListModelByGrid(
                                label: "收藏",
                                value: "coll",
                                icon: Icons.star_border_purple500),
                            MXActionSheetListModelByGrid(
                                label: "下载",
                                value: "down",
                                icon: Icons.download),
                            MXActionSheetListModelByGrid(
                                label: "复制", value: "copy", icon: Icons.edit),
                            MXActionSheetListModelByGrid(
                                label: "微信2",
                                value: "wx",
                                netImgUrl:
                                    'https://tdesign.gtimg.com/miniprogram/logo/wechat.png'),
                            MXActionSheetListModelByGrid(
                                label: "朋友圈2",
                                value: "sns",
                                netImgUrl:
                                    'https://tdesign.gtimg.com/miniprogram/logo/times.png'),
                            MXActionSheetListModelByGrid(
                                label: "QQ3",
                                value: "qq",
                                netImgUrl:
                                    'https://tdesign.gtimg.com/miniprogram/logo/qq.png'),
                            MXActionSheetListModelByGrid(
                                label: "企业微信4",
                                value: "wecom",
                                netImgUrl:
                                    'https://tdesign.gtimg.com/miniprogram/logo/wecom.png'),
                            MXActionSheetListModelByGrid(
                                label: "分享5",
                                value: "share",
                                icon: Icons.share),
                            MXActionSheetListModelByGrid(
                                label: "收藏6",
                                value: "coll",
                                icon: Icons.star_border_purple500),
                            MXActionSheetListModelByGrid(
                                label: "下载7",
                                value: "down",
                                icon: Icons.download),
                            MXActionSheetListModelByGrid(
                                label: "复制8", value: "copy", icon: Icons.edit),
                          ]).toAction(
                        context,
                        onConfirm: (model) {
                          print(model);
                        },
                        onClose: () {
                          print('onClose');
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  MXButton(
                    text: '打开actionsheet面板',
                    icon: Icons.calendar_month_outlined,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXActionSheet(
                          actionSheetTitle: 'ActionSheet描述文字',
                          actionOptionsByList: [
                            MXActionSheetListModel(label: '选项一', value: "1"),
                            MXActionSheetListModel(label: '选项二', value: "1"),
                            MXActionSheetListModel(label: '选项三', value: "1"),
                            MXActionSheetListModel(label: '选项四', value: "1"),
                            MXActionSheetListModel(label: '选项一', value: "1"),
                            MXActionSheetListModel(label: '选项二', value: "1"),
                            MXActionSheetListModel(label: '选项三', value: "1"),
                            MXActionSheetListModel(label: '选项四', value: "1"),
                            MXActionSheetListModel(label: '选项一', value: "1"),
                            MXActionSheetListModel(label: '选项二', value: "1"),
                            MXActionSheetListModel(label: '选项三', value: "1"),
                            MXActionSheetListModel(label: '选项四', value: "1"),
                          ]).toAction(
                        context,
                        onConfirm: (model) {
                          print(model);
                        },
                        onClose: () {
                          print('onClose');
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  MXUploadImg(controller: mxUploadImgController),

                  const SizedBox(
                    height: 10,
                  ),

                  MXIndexes(height: 400, controller: mxIndexesController),

                  const SizedBox(
                    height: 10,
                  ),
                  MXButton(
                    text: '打开日历',
                    icon: Icons.calendar_month_outlined,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      UseMXCalendarByPopup.toRender(
                          onClose: () {
                            MXToast().toastBySuccess(context, '关闭日历');
                          },
                          onConfirm: () {
                            MXToast().toastBySuccess(context,
                                '日期为${mxCalendarController.value.toString()}');
                          },
                          context: context,
                          controller: mxCalendarController);
                    },
                  ),

                  const SizedBox(
                    height: 200,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 200),
                    child: MXPopover(
                      popoverModel: MXPopoverModel(showTriangle: true),
                      positionEnum: MXPopoverPositionEnum.bottomCenter,
                      triggerWidget: MXIcon(
                          useDefaultPadding: false,
                          action: () {},
                          icon: Icons.chair),
                      contentByText: '弹出气泡内',
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: MXTheme.of(context).infoPrimaryColor),
                    child: MXForm(formList: [
                      MXFormItemModel(
                          require: true,
                          label: "开关",
                          initValue: false,
                          props: 'switch',
                          contentAlign: MXFormPositionAlign.end,
                          builder: (MXFormItemModel model) {
                            return MXSwitch(
                              isOn: model.value,
                              disabled: false,
                              modeEnum: MXSwitchModeEnum.icon,
                              sizeEnum: MXSwitchSizeEnum.medium,
                              onChange: (value) {
                                model.value = value;

                                if (!value) {
                                  mxFormController.disabled = true;
                                }
                              },
                            );
                          }),
                      MXFormItemModel(
                          require: true,
                          label: "自我评价",
                          initValue: 1.0,
                          props: 'rate',
                          contentAlign: MXFormPositionAlign.end,
                          builder: (MXFormItemModel model) {
                            return MXRate(
                              size: 28,
                              initValue: model.value,
                              onchange: (index) {
                                model.value = index;
                              },
                            );
                          }),
                      MXFormItemModel(
                          require: false,
                          label: "个人简介",
                          initValue: '',
                          props: 'brief',
                          contentAlign: MXFormPositionAlign.end,
                          builder: (MXFormItemModel model) {
                            return MXTextArea(
                              maxLength: 60,
                              maxLines: 5,
                              space: 0,
                              useIndicator: true,
                              autoHeight: false,
                              backgroundColor: Colors.transparent,
                              onMaxLengthCallback: () {
                                MXToast().toastByError(context, '字数过长');
                              },
                              alignment: MXTextAreaAlignmentEnum.horizontal,
                              controller: textEditingController,
                            );
                          })
                    ], controller: mxFormController),
                  ),

                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        child: MXButton(
                            customMargin: const EdgeInsets.all(2),
                            text: '校验全部',
                            disabled: disabled,
                            themeEnum: themeEnum,
                            afterClickButtonCallback: () {
                              mxFormController.onValidatorByAll();
                            }),
                      ),
                      Flexible(
                        child: MXButton(
                            customMargin: const EdgeInsets.all(2),
                            text: '清除校验',
                            disabled: disabled,
                            themeEnum: themeEnum,
                            afterClickButtonCallback: () {
                              mxFormController.onCleanAllValidator();
                            }),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: EdgeInsets.all(MXTheme.of(context).space16),
                    color: MXTheme.of(context).infoPrimaryColor,
                    child: MXCellGroup(type: MXCellGroupType.cadr, cellList: [
                      MXCellModel(
                          title: '单行标题', description: '这是一段描述', note: '辅助描述'),
                      MXCellModel(
                        title: '单行标题',
                        description: '这是一段描述',
                        note: '辅助描述',
                        rightWidget: const MXSwitch(
                          isOn: false,
                          disabled: false,
                          modeEnum: MXSwitchModeEnum.icon,
                          sizeEnum: MXSwitchSizeEnum.medium,
                        ),
                      ),
                      MXCellModel(
                          title: '单行标题',
                          description: '这是一段描述',
                          useArrow: false),
                      MXCellModel(
                        leftIconWidget: const MXAvatar(
                          avatarNetUrl:
                              'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp',
                          sizeEnum: MXAvatarSizeEnum.medium,
                          shapeEnum: MXAvatarShapeEnum.circle,
                        ),
                        title: '单行标题',
                        description: '这是一段描述',
                        note: '辅助描述',
                        onClick: (details) {
                          print(details);
                        },
                      ),
                      MXCellModel(
                          type: MXCellType.mutipleLine,
                          leftIconWidget: const MXAvatar(
                            avatarNetUrl:
                                'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp',
                            sizeEnum: MXAvatarSizeEnum.lager,
                            shapeEnum: MXAvatarShapeEnum.circle,
                          ),
                          title:
                              '这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题',
                          description:
                              '这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，',
                          note: '辅助描述'),
                    ]),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  MXCellGroup(cellList: [
                    MXCellModel(
                        title: '单行标题', description: '这是一段描述', note: '辅助描述'),
                    MXCellModel(
                      title: '单行标题',
                      description: '这是一段描述',
                      note: '辅助描述',
                      rightWidget: const MXSwitch(
                        isOn: false,
                        disabled: false,
                        modeEnum: MXSwitchModeEnum.icon,
                        sizeEnum: MXSwitchSizeEnum.medium,
                      ),
                    ),
                    MXCellModel(
                      leftIconWidget: const MXAvatar(
                        avatarNetUrl:
                            'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp',
                        sizeEnum: MXAvatarSizeEnum.medium,
                        shapeEnum: MXAvatarShapeEnum.circle,
                      ),
                      title: '单行标题',
                      description: '这是一段描述',
                      note: '辅助描述',
                      onClick: (details) {
                        print(details);
                      },
                    ),
                    MXCellModel(
                        type: MXCellType.mutipleLine,
                        leftIconWidget: const MXAvatar(
                          avatarNetUrl:
                              'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp',
                          sizeEnum: MXAvatarSizeEnum.lager,
                          shapeEnum: MXAvatarShapeEnum.circle,
                        ),
                        title:
                            '这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题，这是一段很长的标题',
                        description:
                            '这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，这一段很长的描述，',
                        note: '辅助描述'),
                  ]),

                  const SizedBox(
                    height: 20,
                  ),

                  const MXRate(
                    initValue: 1.0,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      MXRate(
                        size: 40,
                        initValue: 3.5,
                        useHalf: true,
                        customSelectIcon: Icons.thumb_up,
                        customUnselectIcon: Icons.thumb_up_outlined,
                        customSelectColor:
                            MXTheme.of(context).brandPrimaryColor,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  MXButton(
                    text: '打开cascader组件',
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      mxCascaderController.toRenderCascader(
                          context: context, id: '120104');
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  MXButton(
                    text: '打开悬浮按钮',
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      fabButtonController.show();
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MXButton(
                    text: '隐藏悬浮按钮',
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      fabButtonController.hidden();
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const MXExpendAbleText(
                      text:
                          "精油密集修护，淡纹保湿，缓解干燥粗糙，内柔外亮，平滑紧致，激发肌肤天然修护力。美肌精华一秒乳化，无惧敏感零油腻，焕活青春弹润美肌，令肌肤呈现水水嫩莹润之态。"),

                  const SizedBox(
                    height: 20,
                  ),

                  MXSideBar(
                    sideBarColor: MXTheme.of(context).whiteColor,
                    contentColor: MXTheme.of(context).infoColor1,
                    height: 500,
                    customContentPadding: 8,
                    controller: sideBarController,
                    type: MXSideBarTypeEnum.anchor,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  MXSideBar(
                    height: 500,
                    customContentPadding: 8,
                    controller: sideBarController2,
                    type: MXSideBarTypeEnum.page,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  MXSteps(
                    type: MXStepsTypeEnum.simple,
                    controller: stepsController2,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  MXSteps(
                    axis: Axis.vertical,
                    type: MXStepsTypeEnum.simple,
                    controller: stepsController2,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  MXSteps(
                    type: MXStepsTypeEnum.pattern,
                    controller: stepsController2,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MXSteps(
                    axis: Axis.vertical,
                    type: MXStepsTypeEnum.pattern,
                    controller: stepsController2,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  MXSteps(
                    controller: stepsController,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MXSteps(
                    axis: Axis.vertical,
                    controller: stepsController,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MXTextArea(
                    // useBorder: true,
                    maxLength: 10,
                    useIndicator: true,
                    autoHeight: true,
                    onMaxLengthCallback: () {
                      MXToast().toastByError(context, '字数过长');
                    },
                    alignment: MXTextAreaAlignmentEnum.horizontal,
                    controller: textEditingController,
                    label: '标签文字',
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MXProgress(
                          /// 支持渐变色
                          // gradient: LinearGradient(
                          //   colors: [Colors.blue, Colors.purple],
                          //   begin: Alignment.centerLeft,
                          //   end: Alignment.centerRight,
                          // ),
                          type: MXProgressTypeEnum.circ,
                          controller: progressControllerCirc,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: MXButton(
                                  customMargin: const EdgeInsets.all(2),
                                  text: '减少进度',
                                  disabled: disabled,
                                  themeEnum: themeEnum,
                                  afterClickButtonCallback: () {
                                    int value =
                                        progressControllerCirc.value - 10;
                                    progressControllerCirc
                                        .setProgressValue(value);
                                  }),
                            ),
                            Flexible(
                              child: MXButton(
                                  customMargin: const EdgeInsets.all(2),
                                  text: '重置进度',
                                  disabled: disabled,
                                  themeEnum: themeEnum,
                                  afterClickButtonCallback: () {
                                    progressControllerCirc.reset();
                                  }),
                            ),
                            Flexible(
                              child: MXButton(
                                  customMargin: const EdgeInsets.all(2),
                                  text: '增加进度',
                                  disabled: disabled,
                                  themeEnum: themeEnum,
                                  afterClickButtonCallback: () {
                                    int value =
                                        progressControllerCirc.value + 10;
                                    progressControllerCirc
                                        .setProgressValue(value);
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        MXProgress(
                          controller: progressController,

                          /// 支持渐变色
                          // gradient: LinearGradient(
                          //   colors: [Colors.blue, Colors.purple],
                          //   begin: Alignment.centerLeft,
                          //   end: Alignment.centerRight,
                          // ),
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: MXButton(
                                  customMargin: const EdgeInsets.all(2),
                                  text: '减少进度',
                                  disabled: disabled,
                                  themeEnum: themeEnum,
                                  afterClickButtonCallback: () {
                                    int value = progressController.value - 10;
                                    progressController.setProgressValue(value);
                                  }),
                            ),
                            Flexible(
                              child: MXButton(
                                  customMargin: const EdgeInsets.all(2),
                                  text: '重置进度',
                                  disabled: disabled,
                                  themeEnum: themeEnum,
                                  afterClickButtonCallback: () {
                                    progressController.reset();
                                  }),
                            ),
                            Flexible(
                              child: MXButton(
                                  customMargin: const EdgeInsets.all(2),
                                  text: '增加进度',
                                  disabled: disabled,
                                  themeEnum: themeEnum,
                                  afterClickButtonCallback: () {
                                    int value = progressController.value + 10;
                                    progressController.setProgressValue(value);
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.lager,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.medium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.mini,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    shape: MXCountDownShapeEnum.rect,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.lager,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    shape: MXCountDownShapeEnum.rect,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.medium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    shape: MXCountDownShapeEnum.rect,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.mini,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    shape: MXCountDownShapeEnum.circ,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.lager,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    shape: MXCountDownShapeEnum.circ,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.medium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    shape: MXCountDownShapeEnum.circ,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.mini,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    useUnit: true,
                    autoStare: true,
                    shape: MXCountDownShapeEnum.circ,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.lager,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    useUnit: true,
                    autoStare: true,
                    shape: MXCountDownShapeEnum.circ,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.medium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    useUnit: true,
                    autoStare: true,
                    shape: MXCountDownShapeEnum.circ,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.mini,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  MXCountDown(
                    autoStare: true,
                    format: MXCountDownFormatEnum.ddhhmmsss,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.lager,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    useUnit: true,
                    shape: MXCountDownShapeEnum.rect,
                    format: MXCountDownFormatEnum.ddhhmmsss,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.lager,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MXCountDown(
                    autoStare: true,
                    useUnit: true,
                    shape: MXCountDownShapeEnum.reverse,
                    format: MXCountDownFormatEnum.ddhhmmsss,
                    controller: countDownController,
                    size: MXCountDownSizeEnum.lager,
                    complatedWidget: MXText(data: '倒计时结束'),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const MXResult(
                    typeEnum: MXResultTypeEnum.primary,
                    title: '成功页面',
                    description: '这是一段描述',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const MXResult(
                    typeEnum: MXResultTypeEnum.error,
                    title: '错误页面',
                    description: '这是一段描述',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const MXResult(
                    typeEnum: MXResultTypeEnum.success,
                    title: '成功页面',
                    description: '这是一段描述',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const MXResult(
                    typeEnum: MXResultTypeEnum.warn,
                    title: '警告页面',
                    description: '这是一段描述',
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  const MXResult(
                    netUrl:
                        "https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg",
                    title: '结果页但是自定义网络图片',
                    description: '这是一段描述',
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  MXCollapse(
                      controller: MXCollapsePannerController(
                          isOnlyOne: false,
                          initValue: [
                        '2'
                      ],
                          collapseItemList: [
                        MXCollapsePannerModel(
                            id: '1',
                            mxCollapsePlacementEnum:
                                MXCollapsePlacementEnum.top,
                            title: "折叠面板标题上面",
                            collapseNotice: '关闭',
                            noCollapseNotice: '展开',
                            child: Container(
                              height: 300,
                              color: MXTheme.of(context).infoColor1,
                            )),
                        MXCollapsePannerModel(
                            id: '2',
                            title: "折叠面板标题2",
                            child: Container(
                              height: 300,
                              color: MXTheme.of(context).infoColor1,
                            )),
                        MXCollapsePannerModel(
                            id: '3',
                            title: "折叠面板标题3",
                            child: Container(
                              height: 300,
                              color: MXTheme.of(context).infoColor1,
                            )),
                        MXCollapsePannerModel(
                            id: '4',
                            title: "折叠面板标题4",
                            child: Container(
                              height: 300,
                              color: MXTheme.of(context).infoColor1,
                            )),
                      ])),

                  const SizedBox(
                    height: 20,
                  ),

                  MXSearchBar(
                    searchBarRightIconList: [
                      MXIcon(
                          useDefaultPadding: false,
                          action: () {},
                          icon: Icons.chair)
                    ],
                    controller: textEditingController,
                    inputRightIcon: Icons.chat_bubble_outline_rounded,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MXGrid(
                      space: 0,
                      size: MXGirdSizeEnum.large,
                      column: 2,
                      theme: MXGirdThemeEnum.card,
                      gridItemAxis: Axis.horizontal,
                      itemList: [
                        MXGridItemModel(
                          title: '标题文字',
                          des: '描述文字',
                          netUrl:
                              'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                        ),
                        MXGridItemModel(
                          title: '标题文字',
                          des: '描述文字',
                          netUrl:
                              'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                        ),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),

                  MXGrid(
                      space: 0,
                      useBorder: true,
                      size: MXGirdSizeEnum.large,
                      column: 2,
                      gridItemAxis: Axis.horizontal,
                      itemList: [
                        MXGridItemModel(
                          title: '标题文字',
                          des: '描述文字',
                          netUrl:
                              'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                        ),
                        MXGridItemModel(
                          title: '标题文字',
                          des: '描述文字',
                          netUrl:
                              'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                        ),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  MXGrid(
                    space: 0,
                    useBorder: false,
                    size: MXGirdSizeEnum.large,
                    column: 4,
                    gridItemAxis: Axis.vertical,
                    itemList: [
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MXGrid(
                    space: 0,
                    useBorder: false,
                    size: MXGirdSizeEnum.large,
                    column: 0,
                    gridItemAxis: Axis.vertical,
                    itemList: [
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MXGrid(
                    space: 0,
                    useBorder: true,
                    size: MXGirdSizeEnum.large,
                    column: 4,
                    gridItemAxis: Axis.vertical,
                    itemList: [
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                      MXGridItemModel(
                        title: '标题文字',
                        netUrl:
                            'https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg',
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  MXSwiperCell(
                    title: '右滑操作',
                    note: '副标题',
                    description: '这是一段描述',
                    leftListController: [
                      SwiperCellHandleController(
                        text: '取消',
                        icon: Icons.check,
                        theme: MXButtonThemeEnum.error,
                      )
                    ],
                    rightListController: [
                      SwiperCellHandleController(
                        text: '选择',
                        icon: Icons.check,
                        theme: MXButtonThemeEnum.primary,
                      ),
                      SwiperCellHandleController(
                        text: '取消',
                        icon: Icons.check,
                        theme: MXButtonThemeEnum.warn,
                      )
                    ],
                  ),
                  MXStepper(
                    disabled: false,
                    max: 10,
                    controller: textEditingController,
                    stepperSizeEnum: MXStepperSizeEnum.medium,
                  ),

                  MXButton(
                      loading: true,
                      text: '确认类型的对话框携带自定义部件上',
                      icon: Icons.ac_unit,
                      disabled: disabled,
                      themeEnum: themeEnum,
                      afterClickButtonCallback: () {
                        MXDialog.dialogByConfigAndCustomWidget(
                            context: context,
                            title: '对话框标题',
                            confirmText: '知道了',
                            cancelText: '取消',
                            customWidget: const MXImage(
                                customRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4)),
                                modeEnum: MXImageModeEnum.roundSquare,
                                height: 160,
                                netUrl:
                                    "https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg"),
                            dialogCustomWidgetDirectionEnum:
                                MXDialogCustomWidgetDirectionEnum.top,
                            content: '反馈内容，反馈内容，反馈内容');
                      }),
                  MXButton(
                      text: '确认类型的对话框携带自定义部件中',
                      icon: Icons.ac_unit,
                      disabled: disabled,
                      themeEnum: MXButtonThemeEnum.info,
                      afterClickButtonCallback: () {
                        MXDialog.dialogByConfigAndCustomWidget(
                            context: context,
                            title: '对话框标题',
                            confirmText: '知道了',
                            cancelText: '取消',
                            customWidget: const MXImage(
                                height: 160,
                                customRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                netUrl:
                                    "https://test-technology.oss-cn-hangzhou.aliyuncs.com/Web/system/20220831/image/623263909669acc4da4f61195e9c1a5d.jpg"),
                            dialogCustomWidgetDirectionEnum:
                                MXDialogCustomWidgetDirectionEnum.center,
                            content: '反馈内容，反馈内容，反馈内容');
                      }),
                  MXButton(
                      text: '确认类型的对话框loading',
                      icon: Icons.ac_unit,
                      disabled: disabled,
                      themeEnum: themeEnum,
                      afterClickButtonCallback: () {
                        MXDialog.dialogByConfirm(
                            context: context,
                            title: '对话框标题',
                            confirmText: '确认了',
                            cancelText: '取消',
                            mxDialogLoadingCallback: () async {
                              bool res = await Future.delayed(
                                  const Duration(seconds: 5), () {
                                // 返回true 会直接关闭dialog
                                return true;
                              });

                              return res;
                            },
                            dialogFooterDirectionEnum:
                                MXDialogFooterDirectionEnum.horizontal,
                            content:
                                '反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容');
                      }),
                  MXButton(
                      text: '确认类型的对话框',
                      icon: Icons.ac_unit,
                      disabled: disabled,
                      themeEnum: themeEnum,
                      afterClickButtonCallback: () {
                        MXDialog.dialogByConfirm(
                            context: context,
                            title: '对话框标题',
                            confirmText: '知道了',
                            cancelText: '取消',
                            dialogFooterDirectionEnum:
                                MXDialogFooterDirectionEnum.horizontal,
                            content:
                                '反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容,反馈内容，反馈内容，反馈内容');
                      }),
                  MXButton(
                      text: '反馈内容的对话框',
                      icon: Icons.ac_unit,
                      disabled: disabled,
                      themeEnum: themeEnum,
                      afterClickButtonCallback: () {
                        MXDialog.dialogByFeedback(
                            context: context,
                            title: '对话框标题',
                            confirmText: '知道了',
                            content: '反馈内容，反馈内容，反馈内容');
                      }),
                  MXButton(
                    text: 'popUpTop',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXPopUp.MXpopUpByOther(context, (BuildContext content) {
                        return Container(
                          height: 280,
                          color: MXTheme.of(content).whiteColor,
                        );
                      }, MXPopUpShowTypeEnum.toTop);
                    },
                  ),
                  MXButton(
                    text: 'popUpRight',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXPopUp.MXpopUpByOther(context, (BuildContext content) {
                        return Container(
                          width: 280,
                          color: MXTheme.of(content).whiteColor,
                        );
                      }, MXPopUpShowTypeEnum.toRight);
                    },
                  ),
                  MXButton(
                    text: 'popUpLeft',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXPopUp.MXpopUpByOther(context, (BuildContext content) {
                        return Container(
                          width: 280,
                          color: MXTheme.of(content).whiteColor,
                        );
                      }, MXPopUpShowTypeEnum.toLeft);
                    },
                  ),
                  MXButton(
                    text: 'popUpCenter',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXPopUp.MXpopUpByOther(context, (BuildContext content) {
                        return Container(
                          width: 280,
                          height: 200,
                          color: MXTheme.of(content).whiteColor,
                        );
                      }, MXPopUpShowTypeEnum.toCenter);
                    },
                  ),

                  MXButton(
                    text: 'popUpBottom',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXPopUp.MXpopUpByBottom(context,
                          leftText: '取消',
                          rightText: '确定',
                          title: "这是title",
                          footerText: '确定',
                          child: Container(
                            height: 200,
                          ));
                    },
                  ),

                  MXAuthCode(
                    mxAuthCodeController: mxAuthCodeController,
                    useAutoFocus: false,
                  ),
                  MXButton(
                    text: '设置code为错误状态',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      mxAuthCodeController.setError(true);
                    },
                  ),
                  MXInput(
                    dividerColor: MXTheme.of(context).errorPrimaryColor,
                    useBottomDividerLine: true,
                    typeEnum: MXInputTypeEnum.norma,
                    placeholder: '请输入文字',
                  ),
                  MXInput(
                      typeEnum: MXInputTypeEnum.norma,
                      iconData: Icons.ac_unit,
                      useRequire: true,
                      placeholder: '请输入文字',
                      labelText: '标签文字字',
                      rightWidget: MXIcon(
                          action: () {},
                          iconFontSize: 20,
                          icon: Icons.center_focus_strong)),

                  MXButton(
                    text: '成功toast',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXToast().toastBySuccess(context, '成功文案',
                          directionEnum: MXToastDirectionEnum.horizontal);
                    },
                    typeEnum: MXButtonTypeEnum.fill,
                    shape: MXButtonShapeEnum.round,
                    sizeEnum: MXButtonSizeEnum.medium,
                  ),

                  MXDropDownMenu(menuList: [
                    DropDownMenuItemController(
                        label: '单选菜单',
                        columnsEnum: MXDropDownMenuItemColumnsEnum.three,
                        disabledIds: [
                          '5',
                          '7',
                          '9'
                        ],
                        options: [
                          {
                            MXDropDownMenuOptionsEnum.label: '选项一',
                            MXDropDownMenuOptionsEnum.value: '1'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项二',
                            MXDropDownMenuOptionsEnum.value: '2'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项三',
                            MXDropDownMenuOptionsEnum.value: '3'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项四',
                            MXDropDownMenuOptionsEnum.value: '4'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项五',
                            MXDropDownMenuOptionsEnum.value: '5'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项六',
                            MXDropDownMenuOptionsEnum.value: '6'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项七',
                            MXDropDownMenuOptionsEnum.value: '7'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项八',
                            MXDropDownMenuOptionsEnum.value: '8'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项九',
                            MXDropDownMenuOptionsEnum.value: '9'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项十',
                            MXDropDownMenuOptionsEnum.value: '10'
                          }
                        ]),
                    DropDownMenuItemController(
                        label: '多选菜单',
                        multiple: true,
                        columnsEnum: MXDropDownMenuItemColumnsEnum.three,
                        disabledIds: [],
                        initValue: [
                          '3',
                          '5',
                          '7',
                          '9'
                        ],
                        options: [
                          {
                            MXDropDownMenuOptionsEnum.label: '选项一',
                            MXDropDownMenuOptionsEnum.value: '1'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项二',
                            MXDropDownMenuOptionsEnum.value: '2'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项三',
                            MXDropDownMenuOptionsEnum.value: '3'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项四',
                            MXDropDownMenuOptionsEnum.value: '4'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项五',
                            MXDropDownMenuOptionsEnum.value: '5'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项六',
                            MXDropDownMenuOptionsEnum.value: '6'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项七',
                            MXDropDownMenuOptionsEnum.value: '7'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项八',
                            MXDropDownMenuOptionsEnum.value: '8'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项九',
                            MXDropDownMenuOptionsEnum.value: '9'
                          },
                          {
                            MXDropDownMenuOptionsEnum.label: '选项十',
                            MXDropDownMenuOptionsEnum.value: '10'
                          }
                        ])
                  ]),
                  MXButton(
                    text: '错误toast',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXToast().toastByError(context,
                          '错误文案,错误文案错误文案,错误文案,错误文案,错误文案,错误文案,错误文案,错误文案误文案,错误文案,错误文案,错误文案,错误文案,误文案,错误文案,错误文案,错误文案,错误文案,误文案,错误文案,错误文案,错误文案,错误文案,,错误文案,错误文案',
                          directionEnum: MXToastDirectionEnum.vertical);
                    },
                    typeEnum: MXButtonTypeEnum.fill,
                    shape: MXButtonShapeEnum.round,
                    sizeEnum: MXButtonSizeEnum.medium,
                  ),
                  MXButton(
                    text: 'loadingToast',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      var toast = MXToast().toastByLoading(context,
                          directionEnum: MXToastDirectionEnum.vertical);

                      Timer(const Duration(milliseconds: 1000), () {
                        toast.hidden();
                      });
                    },
                    typeEnum: MXButtonTypeEnum.fill,
                    shape: MXButtonShapeEnum.round,
                    sizeEnum: MXButtonSizeEnum.medium,
                  ),

                  MXButton(
                    text: '文字toast',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,
                    afterClickButtonCallback: () {
                      MXToast().toastByText(context, '文字内容',
                          directionEnum: MXToastDirectionEnum.vertical);
                    },
                    typeEnum: MXButtonTypeEnum.fill,
                    shape: MXButtonShapeEnum.round,
                    sizeEnum: MXButtonSizeEnum.medium,
                  ),

                  const MXCircleLoading(),
                  SizedBox(
                    height: MXTheme.of(context).space12,
                  ),
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
                          viewportFraction: 0.65,
                          loop: true,
                          autoplay: true,
                          transformer:
                              MXPagetransform.transToMargin(margin: 12),
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
                    text: 'plainPrimary',
                    icon: Icons.ac_unit,
                    themeEnum: MXButtonThemeEnum.primary,
                    afterClickButtonCallback: () {},
                    typeEnum: MXButtonTypeEnum.plain,
                    shape: MXButtonShapeEnum.round,
                    sizeEnum: MXButtonSizeEnum.medium,
                  ),
                  MXButton(
                    text: 'plainSuccess',
                    icon: Icons.ac_unit,
                    themeEnum: MXButtonThemeEnum.success,
                    afterClickButtonCallback: () {},
                    typeEnum: MXButtonTypeEnum.plain,
                    shape: MXButtonShapeEnum.round,
                    sizeEnum: MXButtonSizeEnum.medium,
                  ),
                  MXButton(
                    text: 'plainError',
                    icon: Icons.ac_unit,
                    themeEnum: MXButtonThemeEnum.error,
                    afterClickButtonCallback: () {},
                    typeEnum: MXButtonTypeEnum.plain,
                    shape: MXButtonShapeEnum.round,
                    sizeEnum: MXButtonSizeEnum.medium,
                  ),
                  MXButton(
                    text: 'plainWarn',
                    icon: Icons.ac_unit,
                    themeEnum: MXButtonThemeEnum.warn,
                    afterClickButtonCallback: () {},
                    typeEnum: MXButtonTypeEnum.plain,
                    shape: MXButtonShapeEnum.round,
                    sizeEnum: MXButtonSizeEnum.medium,
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
                          onConfirm: (p0) {},
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

                  SizedBox(
                    height: MXTheme.of(context).space12,
                  ),

                  MXButton(
                    text: '多级联动选择器',
                    icon: Icons.ac_unit,
                    disabled: disabled,
                    themeEnum: themeEnum,

                    //  MultipleOptionsModel(options: Test().data);
                    afterClickButtonCallback: () {
                      MXPickers().showMultipleOptionsPicker(
                          context,
                          MultipleOptionsQuery(options: Test().data),
                          MultiplePickerParams());
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

                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                                padding:
                                    EdgeInsets.all(MXTheme.of(context).space8),
                                child: Text(
                                  '徽标',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        MXTheme.of(context).fontUsePrimaryColor,
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

                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                                padding:
                                    EdgeInsets.all(MXTheme.of(context).space8),
                                child: Text(
                                  '徽标',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        MXTheme.of(context).fontUsePrimaryColor,
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
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                                padding:
                                    EdgeInsets.all(MXTheme.of(context).space8),
                                child: Text(
                                  '徽标',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        MXTheme.of(context).fontUsePrimaryColor,
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
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(8),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    onHandleBack: () {},
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
                                fontSize:
                                    MXTheme.of(context).fontBodySmall!.size,
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
                  const MXAvatar(
                    avatarNetUrl:
                        "https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp",
                    sizeEnum: MXAvatarSizeEnum.lager,
                    shapeEnum: MXAvatarShapeEnum.square,
                    modeEnum: MXAvatarModeEnum.img,
                  ),
                  SizedBox(
                    height: MXTheme.of(context).space32,
                  ),
                  MXAvatar(
                    avatarNetUrlList: const [
                      'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp',
                      'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp',
                      'https://i0.hdslb.com/bfs/face/eb101ef90ebc4e9bf79f65312a22ebac84946700.jpg@240w_240h_1c_1s.webp'
                    ],
                    avatarAppendixText: "+5",
                    avatarAppendixCallback: () {},
                    sizeEnum: MXAvatarSizeEnum.medium,
                    shapeEnum: MXAvatarShapeEnum.circle,
                    modeEnum: MXAvatarModeEnum.imgList,
                  ),
                  SizedBox(
                    height: MXTheme.of(context).space32,
                  ),
                  Padding(
                    padding: EdgeInsets.all(MXTheme.of(context).space16),
                    child: MXCheckBox(
                      title:
                          "选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择框",
                      desSub:
                          "选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择框选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择选择框",
                      modeEnum: MXCheckBoxModeEnum.card,
                      directionEnum: MXCheckBoxDirectionEnum.left,
                      onCheckBoxValueChange: (isChecked) {},
                    ),
                  ),
                  SizedBox(
                    height: MXTheme.of(context).space32,
                  ),
                  MXCheckBoxSeries(
                      checkIds: const ["1"],
                      useIndeterminate: true,
                      checkBoxSeriesController: controller,
                      modeEnum: MXCheckBoxModeEnum.card,
                      direction: Axis.vertical,
                      onCheckBoxSeriesValueChange: (value) {},
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
                      checkIds: const ["3"],
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
            )
          ],
        ));
  }
}
