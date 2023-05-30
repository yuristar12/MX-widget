import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

/// -------------------------------------------------------------------navBar组件
/// [barLeftItems] navBar 左侧的iconlist
/// [barRightItems] navBar 右侧的iconlist
/// [titleWidget] navBar 文字的组件优先于text
/// [titleContent] navBar 标题内容
/// [titleColor] 标题颜色
/// [titleWeight] navBar 标题字重/默认为FontWeight.w500
/// [useTitleCenter] navBar 的tittle 是否居中展示
/// [backgroundColor] navBar 的背景颜色默认为白色
/// [navBarHeight] navBar 的高度默认44
/// [useDefaultBack] navBar 是否开启默认的点击返回 将渲染返回icon按钮
/// [onHandleBack] 返回的事件
/// [navBarChild] navBar下方的渲染插槽

class MXNavBar extends StatefulWidget implements PreferredSizeWidget {
  const MXNavBar(
      {super.key,
      this.barLeftItems,
      this.barRightItems,
      this.titleWidget,
      this.titleContent,
      this.titleColor,
      this.useTitleCenter = true,
      this.titleWeight = FontWeight.w500,
      this.backgroundColor,
      this.navBarHeight = 44,
      this.useDefaultBack = true,
      this.onHandleBack,
      this.navBarChild});

  /// navBar 左侧的iconlist
  final List<MXIcon>? barLeftItems;

  /// navBar 右侧的iconlist
  final List<MXIcon>? barRightItems;

  /// navBar 文字的组件优先于text
  final Widget? titleWidget;

  /// navBar 标题内容
  final String? titleContent;

  /// navBar 标题颜色
  final Color? titleColor;

  /// navBar 标题字重
  final FontWeight titleWeight;

  /// navBar 的tittle 是否居中展示
  final bool useTitleCenter;

  /// navBar 的背景颜色默认为白色
  final Color? backgroundColor;

  /// navBar 的高度默认44
  final double navBarHeight;

  /// navBar 是否开启默认的点击返回 将渲染返回icon按钮
  final bool useDefaultBack;

  /// 返回的事件
  final MXNavBarOnBack? onHandleBack;

  /// navBar下方的渲染插槽
  final Widget? navBarChild;

  @override
  State<MXNavBar> createState() => _MXNavBarState();

  @override
  Size get preferredSize => Size.fromHeight(navBarHeight);
}

class _MXNavBarState extends State<MXNavBar> {
  Color _getFontColor() {
    return widget.titleColor ?? MXTheme.getThemeConfig().fontUsePrimaryColor;
  }

  double _getFontSize(BuildContext context) {
    return MXTheme.of(context).fontBodyLarge!.size;
  }

  Widget _getFont(BuildContext context) {
    return widget.titleWidget ??
        Text(
          widget.titleContent!,
          style: TextStyle(
              color: _getFontColor(),
              fontSize: _getFontSize(context),
              fontWeight: widget.titleWeight,
              overflow: TextOverflow.ellipsis,
              decoration: TextDecoration.none),
        );
  }

  Widget _getNavBarList({bool isLeft = true}) {
    var list = isLeft ? widget.barLeftItems ?? [] : widget.barRightItems ?? [];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLeft && widget.useDefaultBack) _backIcon(),
        if (list.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: list,
          )
      ],
    );
  }

  Widget _backIcon() {
    return MXIcon(
      iconFontSize: 30,
      iconColor: _getFontColor(),
      icon: Icons.chevron_left_outlined,
      iconSizeEnum: MXIconSizeEnum.large,
      action: () {
        widget.onHandleBack?.call();
        Navigator.maybePop(context);
      },
    );
  }

  Widget _getNavBarChildren(BuildContext context) {
    final navBar = NavigationToolbar(
      leading: _getNavBarList(isLeft: true),
      middle: _getFont(context),
      trailing: _getNavBarList(isLeft: false),
      centerMiddle: widget.useTitleCenter,
    );

    return navBar;
  }

  @override
  Widget build(BuildContext context) {
    var paddingTop = (MediaQuery.of(context).padding.top);
    var height = widget.navBarHeight + paddingTop;

    Widget navBar = Container(
      color: widget.backgroundColor ?? MXTheme.of(context).whiteColor,
      padding: EdgeInsetsDirectional.symmetric(
              vertical: MXTheme.of(context).space4,
              horizontal: MXTheme.of(context).space8)
          .add(EdgeInsets.only(top: paddingTop)),
      height: height,
      child: _getNavBarChildren(context),
    );

    if (widget.navBarChild != null) {
      navBar = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [navBar, widget.navBarChild!],
      );
    }

    return navBar;
  }
}
