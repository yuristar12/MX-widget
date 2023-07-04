import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

const double limitCustomWidgetHeight = 160;
final double space = MXTheme.getThemeConfig().space24;

///--------------------------------------------------------------弹窗组件的内容组件
/// [title] 弹窗的标题
/// [confirmCallback] 确认按钮的回调方法
/// [closeCallback] 取消按钮的回调方法
/// [cancelText] 取消按钮的文案
/// [confirmText] 确认按钮的文案
/// [confirmWidget] 自定义的确认按钮组件
/// [content] 弹窗内容的文案
/// [contentStyle] 弹窗内容的自定义字体样式
/// [extendButtons] 扩展的按钮集合，只适用与feedback类型的弹窗
/// [contentWidget] 自定义弹窗内容的部件
/// [customWidget] 扩展的自定义部件有两种位置top与center，只适用
/// dialogByConfigAndCustomWidget的弹窗高度限制为160
/// [dialogFooterDirectionEnum] 弹窗底部按钮的排列方式 horizontal与vertical
/// [dialogCustomWidgetDirectionEnum] 弹窗自定义扩展部件的位置

class MXDialogBody extends StatefulWidget {
  const MXDialogBody({
    super.key,
    this.title,
    this.confirmCallback,
    this.closeCallback,
    required this.confirmText,
    this.cancelCallback,
    this.cancelText,
    this.confirmWidget,
    this.cancelWidget,
    this.content,
    this.contentStyle,
    this.extendButtons,
    this.contentWidget,
    this.customWidget,
    this.dialogFooterDirectionEnum = MXDialogFooterDirectionEnum.horizontal,
    this.dialogCustomWidgetDirectionEnum =
        MXDialogCustomWidgetDirectionEnum.center,
    this.mxDialogLoadingCallback,
    this.onDialogCloseCallback,
  });

  final String? title;
  final String? content;
  final TextStyle? contentStyle;

  final String confirmText;
  final String? cancelText;

  final MXButton? confirmWidget;
  final MXButton? cancelWidget;
  final Widget? contentWidget;

  final List<MXButton>? extendButtons;

  final VoidCallback? confirmCallback;

  final VoidCallback? cancelCallback;

  final VoidCallback? closeCallback;

  final VoidCallback? onDialogCloseCallback;

  final MXDialogFooterDirectionEnum dialogFooterDirectionEnum;

  final MXDialogCustomWidgetDirectionEnum dialogCustomWidgetDirectionEnum;

  final MXDialogLoadingCallback? mxDialogLoadingCallback;

  final Widget? customWidget;

  @override
  State<MXDialogBody> createState() => _MXDialogBodyState();
}

class _MXDialogBodyState extends State<MXDialogBody> {
  bool loading = false;

  Widget _buildTitle(BuildContext context) {
    bool hasCustomWidgetByTop = widget.customWidget != null &&
        widget.dialogCustomWidgetDirectionEnum ==
            MXDialogCustomWidgetDirectionEnum.top;

    return Container(
        padding: EdgeInsets.only(
            top: hasCustomWidgetByTop ? 0 : space, left: space, right: space),
        child: Column(
          children: [
            MXText(
              data: widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              font: MXTheme.of(context).fontBodyLarge,
              style: TextStyle(
                  color: MXTheme.of(context).fontUsePrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MXTheme.of(context).space8,
            )
          ],
        ));
  }

  Widget _buildDialogContent(BuildContext context) {
    double contentLimitHeight = 466;
    bool hasCustomByCenter = widget.customWidget != null &&
        widget.dialogCustomWidgetDirectionEnum ==
            MXDialogCustomWidgetDirectionEnum.center;

//  如果存在顶上的自定义插入的widget 需要减去自定义的限制高度;

    if (widget.customWidget != null &&
        widget.dialogCustomWidgetDirectionEnum ==
            MXDialogCustomWidgetDirectionEnum.top) {
      contentLimitHeight -= (limitCustomWidgetHeight + space);
    }

    Widget child = Container(
        padding: EdgeInsets.symmetric(horizontal: space),
        child: Text(
          widget.content!,
          textAlign: TextAlign.center,
          style: widget.contentStyle ??
              TextStyle(
                height: MXTheme.of(context).fontBodyMedium!.heightRate * 1.2,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
                fontSize: MXTheme.of(context).fontBodyMedium!.size,
                color: MXTheme.of(context).fontUseSecondColors,
              ),
        ));

    if (hasCustomByCenter) {
      child = Column(
        children: [
          child,
          _buildCustomWidget(),
        ],
      );
    } else {
      child = widget.contentWidget ?? child;
    }

    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: contentLimitHeight),
        child: SingleChildScrollView(
          child: child,
        ));
  }

  Widget _buildCustomWidget() {
    EdgeInsets margin = const EdgeInsets.all(0);

    if (widget.dialogCustomWidgetDirectionEnum ==
        MXDialogCustomWidgetDirectionEnum.top) {
      margin = EdgeInsets.only(bottom: space);
    } else {
      margin = EdgeInsets.only(top: space);
    }

    return Container(
        margin: margin,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: double.infinity, maxHeight: limitCustomWidgetHeight),
          child: widget.customWidget,
        ));
  }

  Widget _buildFooter(BuildContext context) {
    Widget footer;

    if (widget.extendButtons != null ||
        widget.dialogFooterDirectionEnum ==
            MXDialogFooterDirectionEnum.vertical) {
      List<MXButton> children = [];
      children.add(_buildConfirmButton(context));

      if (widget.cancelText != null || widget.cancelWidget != null) {
        children.add(_buttonCancelButton(context));
      }

      if (widget.extendButtons != null) {
        children.addAll(widget.extendButtons!);
      }

      footer = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    } else {
      List<Widget> children = [];
      if (widget.cancelText != null || widget.cancelWidget != null) {
        children.add(Flexible(flex: 1, child: _buttonCancelButton(context)));
        children.add(SizedBox(
          width: space / 2,
        ));
      }
      children.add(Flexible(flex: 1, child: _buildConfirmButton(context)));

      footer = Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: children);
    }

    return Container(
      padding: EdgeInsets.only(left: space, right: space, bottom: space),
      child: Column(children: [
        SizedBox(
          height: MXTheme.of(context).space16,
        ),
        footer
      ]),
    );
  }

  MXButton _buildConfirmButton(BuildContext context) {
    return widget.confirmWidget ?? _buildDefaultButton(context, true);
  }

  MXButton _buttonCancelButton(BuildContext context) {
    return widget.cancelWidget ?? _buildDefaultButton(context, false);
  }

  MXButton _buildDefaultButton(BuildContext context, bool isConfirm) {
    return MXButton(
      loading: loading,
      text: isConfirm ? widget.confirmText : widget.cancelText!,
      textStyle: TextStyle(
          fontSize: MXTheme.of(context).fontBodyMedium!.size,
          color: isConfirm
              ? MXTheme.of(context).whiteColor
              : MXTheme.of(context).brandPrimaryColor,
          fontWeight: FontWeight.w600),
      customMargin: EdgeInsets.symmetric(
          horizontal: 0, vertical: MXTheme.of(context).space8),
      sizeEnum: MXButtonSizeEnum.small,
      typeEnum: isConfirm ? MXButtonTypeEnum.fill : MXButtonTypeEnum.plain,
      themeEnum: MXButtonThemeEnum.primary,
      afterClickButtonCallback: () {
        if (isConfirm) {
          _onCallConfirmCallback();
        } else {
          widget.cancelCallback != null
              ? widget.cancelCallback?.call()
              : Navigator.pop(context);
        }
      },
    );
  }

// 只有当类型为confirm类型时的确认按钮出发方法
  void _onCallConfirmCallback() async {
    if (widget.mxDialogLoadingCallback != null) {
      setState(() {
        loading = true;
      });

      widget.mxDialogLoadingCallback!.call().then((value) {
        if (value) {
          Navigator.pop(context);
          widget.onDialogCloseCallback?.call();
        } else {
          setState(() {
            loading = false;
          });
        }
      });
    } else {
      if (widget.confirmCallback != null) {
        widget.confirmCallback?.call();
      } else {
        Navigator.pop(context);

        widget.onDialogCloseCallback?.call();
      }
    }
  }

  Widget _buildContent(BuildContext context) {
    List<Widget> children = [];

    if (widget.customWidget != null &&
        widget.dialogCustomWidgetDirectionEnum ==
            MXDialogCustomWidgetDirectionEnum.top) {
      children.add(_buildCustomWidget());
    }

    if (widget.title != null) {
      children.add(_buildTitle(context));
    }

    children.add(_buildDialogContent(context));

    children.add(_buildFooter(context));

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 600),
          child: Container(
            // 最大取屏幕的百分之85
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
                color: MXTheme.of(context).whiteColor,
                borderRadius:
                    BorderRadius.circular(MXTheme.of(context).radiusMedium)),
            child: _buildContent(context),
          ),
        ),
        Positioned(
            top: space / 2,
            right: space / 2,
            child: Visibility(
                visible: widget.cancelCallback != null,
                child: MXIcon(
                  iconFontSize: 24,
                  icon: Icons.close,
                  action: () {
                    widget.closeCallback != null
                        ? widget.closeCallback?.call()
                        : Navigator.pop(context);
                  },
                ))),
      ],
    );
  }
}
