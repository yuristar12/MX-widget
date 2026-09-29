# MX-widget

MX-widget 是一个 Flutter 常用组件库，包含按钮、表单、导航、弹层、反馈和展示组件。当前仓库包版本为 `0.1.3`。

> 效果图待从真实运行的示例应用采集。请先提交图片，再启用下方的图片引用；不要让 README 出现失效图片。

<!-- 将真实截图保存到 docs/images/overview.png 后启用：
![MX-widget 组件总览：按钮、表单、导航和反馈组件](docs/images/overview.png)
-->

## 目录

- [安装](#安装)
- [快速开始](#快速开始)
- [常用组件](#常用组件)
- [主题配置](#主题配置)
- [运行示例工程](#运行示例工程)
- [截图清单](#截图清单)

## 安装

在 Flutter 项目中运行：

```bash
flutter pub add mx_widget
```

在 Dart 文件中引用包的公开入口：

```dart
import 'package:mx_widget/mx_widget.dart';
```

如果需要直接使用仓库中的未发布修改，可在项目的 `pubspec.yaml` 中改用 Git 依赖：

```yaml
dependencies:
  mx_widget:
    git:
      url: https://github.com/yuristar12/MX-widget.git
      ref: main
```

修改依赖后运行 `flutter pub get`。实际可用的 Flutter/Dart 版本还取决于依赖解析结果；仓库包本身声明 Dart `>=2.19.1 <4.0.0`。

## 快速开始

先用 `MXTheme` 包裹应用，再在页面中使用组件。以下文件可直接作为 `lib/main.dart` 的起点：

```dart
import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MXTheme(
      themeConfig: MXThemeConfig.cacheThemeConfig(),
      widget: MaterialApp(
        title: 'MX-widget 示例',
        home: Scaffold(
          appBar: AppBar(title: const Text('MX-widget 示例')),
          body: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MXButton(
                    text: '提交',
                    themeEnum: MXButtonThemeEnum.primary,
                    afterClickButtonCallback: () {
                      MXToast().toastBySuccess(context, '提交成功');
                    },
                  ),
                  const SizedBox(height: 16),
                  const MXBadge(
                    typeEnum: MXBadgeTypeEnum.square,
                    badgeCount: 8,
                  ),
                  const SizedBox(height: 16),
                  const MXSwitch(isOn: true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

`MXThemeConfig.cacheThemeConfig()` 初始化默认主题。按钮的 `themeEnum` 是必填参数；Toast 需要从 `MaterialApp` 下方的 `context` 调用，因此示例使用了 `Builder`。

## 常用组件

### 按钮、徽标与标签

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    MXButton(
      text: '主要操作',
      themeEnum: MXButtonThemeEnum.primary,
      afterClickButtonCallback: () {},
    ),
    MXButton(
      text: '不可点击',
      themeEnum: MXButtonThemeEnum.primary,
      disabled: true,
    ),
    const MXBadge(
      typeEnum: MXBadgeTypeEnum.square,
      badgeCount: 8,
    ),
    MXTag(
      text: '已完成',
      themeEnum: MXTagThemeEnum.success,
      modeEnum: MXTagModeEnum.outline,
    ),
  ],
)
```

`MXButton` 支持 `typeEnum`（填充、文字、描边等）、`sizeEnum`、`shape`、`loading` 和 `disabled`。`MXBadge` 可以显示红点、数字或文字；`MXTag` 提供主题与样式选项。

<!-- 提交真实截图后启用：
![按钮的主题和状态，以及徽标、标签效果](docs/images/basic-components.png)
-->

### 输入与选择

以下片段放在页面的 `build` 方法中；如需读取输入值，可为 `MXInput` 传入 `TextEditingController` 并在有状态组件的 `dispose` 中释放它。

```dart
Column(
  children: [
    MXInput(
      labelText: '用户名',
      placeholder: '请输入用户名',
      onChange: (value) {
        debugPrint(value);
      },
    ),
    MXCheckBox(
      title: '同意协议',
      modeEnum: MXCheckBoxModeEnum.square,
      onCheckBoxValueChange: (checked) {
        debugPrint('checked: $checked');
      },
    ),
    MXSwitch(
      isOn: false,
      onChange: (isOn) {
        debugPrint('isOn: $isOn');
      },
    ),
  ],
)
```

<!-- 提交真实截图后启用：
![输入框、复选框和开关的不同状态](docs/images/form-components.png)
-->

### 日期选择器

`MXPickers` 通过底部弹层打开日期选择器；在按钮回调中传入当前页面的 `context`：

```dart
MXButton(
  text: '选择日期',
  themeEnum: MXButtonThemeEnum.primary,
  afterClickButtonCallback: () {
    MXPickers().showDatePicker(
      context,
      DatePickerQuery(value: [2026, 9, 29]),
      DatePickerParams(
        datePickerFormatType: DatePickerFormatType.YYYY_MM_DD,
        onConfirm: (date) => debugPrint('选择日期: $date'),
      ),
    );
  },
)
```

`DatePickerQuery` 也可设置 `startDate` 和 `endDate`，格式均为 `[年, 月, 日]`。更新示例时建议把初始日期改为当前日期。

### 操作面板与反馈

```dart
MXButton(
  text: '更多操作',
  themeEnum: MXButtonThemeEnum.primary,
  afterClickButtonCallback: () {
    MXActionSheet(
      actionSheetTitle: '请选择操作',
      actionOptionsByList: [
        MXActionSheetListModel(label: '编辑', value: 'edit'),
        MXActionSheetListModel(label: '分享', value: 'share'),
      ],
    ).toAction(
      context,
      onConfirm: (item) {
        MXToast().toastByText(context, '选择了 ${item.label}');
      },
    );
  },
)
```

<!-- 提交真实截图后启用：
![操作面板、日期选择器和 Toast 的打开状态](docs/images/overlays.png)
-->

### 导航与其他组件

仓库还提供 `MXNavBar`、`MXTabBar`、`MXBottomNavBar`，以及图片、骨架屏、日历、表单、宫格、抽屉、上传图片等组件。各组件的完整配置可在 [示例入口](example/lib/main.dart) 中查找类名。建议先看截图，再跳转到对应源码示例。

<!-- 提交真实截图后启用：
![顶部导航、标签栏和底部导航](docs/images/navigation.png)
-->

## 主题配置

自定义颜色时，把配置传给 `MXThemeConfig.cacheThemeConfig`，并在构造 `MaterialApp` 前初始化：

```dart
MXTheme(
  themeConfig: MXThemeConfig.cacheThemeConfig(
    customThemeConfig: {
      'color': {
        'brandPrimaryColor': '#652B1C',
        'brandFocusColor': '#BE7055',
      },
    },
  ),
  widget: MaterialApp(home: const MyHomePage()),
)
```

颜色键必须是库默认主题中已有的键；未知键不会写入。`cacheThemeConfig` 会缓存配置，请在应用初始化时设置主题。

## 运行示例工程

```bash
git clone https://github.com/yuristar12/MX-widget.git
cd MX-widget/example
flutter pub get
flutter run
```

示例工程的 Dart SDK 约束已与包统一为 `>=2.19.1 <4.0.0`。此变更尚未经过 Flutter 运行验证。

## 截图清单

建议从同一次真实运行中截取以下五张图片，提交至 `docs/images/`，再取消上方对应图片引用的注释：

| 文件 | 内容 | 推荐位置 |
| --- | --- | --- |
| `overview.png` | 基础组件总览，首屏可辨认按钮、输入和导航 | 项目简介下方 |
| `basic-components.png` | 按钮主题、禁用状态、徽标与标签 | 基础组件示例下方 |
| `form-components.png` | 输入框、复选框、开关的状态 | 表单示例下方 |
| `overlays.png` | 操作面板、日期选择器、Toast 打开后的效果 | 弹层示例下方 |
| `navigation.png` | 顶部导航、TabBar、底部导航 | 导航介绍下方 |

截图采用统一尺寸与主题，裁掉无关空白；每张图保留组件名称。不要把模拟图或未运行的设计稿标成真实运行效果。

## 反馈

组件库仍在开发中。问题和改进建议请提交至 [GitHub Issues](https://github.com/yuristar12/MX-widget/issues)。
