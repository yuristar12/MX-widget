import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

/// ------------------------------------------------------------searchBar搜索组件
/// [backgroundColor] 背景颜色
/// [controller] TextEditingController 控制器用于获取输入框的值
/// [placeholder] 占位符文字
/// [height] 输入框高度
/// [disabled] 输入框的禁用状态
/// [autofocus] 是否自动对焦
/// [useDefaultBack] 是否启用默认的返回事件
/// [searchBarLeftIcon] 输入框外部的icon
/// [searchBarRightIconList] 输入框外部右侧的icon列表
/// [inputLeftIcon] 输入框内部的左侧icon 默认是search样式
/// [inputRightIcon] 输入框内部右侧的icon
/// [inputRightWidget] 输入框内部右侧的自定义部件与icon冲突
/// [themeEnum] rect与round
/// [onChange]输入框的内容改变的时候
/// [onEditingComplete] 当点击键盘确认的事件
/// [onSubmitted] 当点击键盘确认的事件这个会阻止下一个foucsNode的聚焦事件
/// [maxLength] 输入框最大可以输入的内容
/// [focusNode] 用于缓冲input输入框的节点，方便聚焦与失焦

class MXSearchBar extends StatefulWidget {
  const MXSearchBar({
    super.key,
    this.backgroundColor,
    required this.controller,
    this.placeholder = '请输入搜索内容',
    this.height = 50,
    this.disabled = false,
    this.autofocus = false,
    this.useDefaultBack = false,
    this.searchBarLeftIcon,
    this.searchBarRightIconList,
    this.inputLeftIcon = Icons.search,
    this.inputRightIcon,
    this.inputRightWidget,
    this.themeEnum = MXSearchBarThemeEnum.rect,
    this.onChange,
    this.onEditingComplete,
    this.onSubmitted,
    this.maxLength,
    this.focusNode,
  });

  /// [searchBarLeftIcon] 输入框外部的icon
  final MXIcon? searchBarLeftIcon;

  /// [searchBarRightIconList] 输入框外部右侧的icon列表
  final List<MXIcon>? searchBarRightIconList;

  /// [backgroundColor] 背景颜色
  final Color? backgroundColor;

  /// [inputLeftIcon] 输入框内部的左侧icon 默认是search样式
  final IconData? inputLeftIcon;

  /// [inputRightIcon] 输入框内部右侧的icon
  final IconData? inputRightIcon;

  /// [inputRightWidget] 输入框内部右侧的自定义部件与icon冲突
  final Widget? inputRightWidget;

  /// [controller] TextEditingController 控制器用于获取输入框的值
  final TextEditingController controller;

  /// [placeholder] 占位符文字
  final String? placeholder;

  /// [height] 输入框高度
  final double height;

  /// [disabled] 输入框的禁用状态
  final bool disabled;

  /// [autofocus] 是否自动对焦
  final bool autofocus;

  /// [useDefaultBack] 是否启用默认的返回事件
  final bool useDefaultBack;

  /// [themeEnum] rect与round
  final MXSearchBarThemeEnum themeEnum;

  /// [onChange]输入框的内容改变的时候
  final ValueChanged<String>? onChange;

  /// [onEditingComplete] 当点击键盘确认的事件
  final VoidCallback? onEditingComplete;

  /// [onSubmitted] 当点击键盘确认的事件这个会阻止下一个foucsNode的聚焦事件
  final ValueChanged<String>? onSubmitted;

  /// [maxLength] 输入框最大可以输入的内容
  final int? maxLength;

  /// [focusNode] 用于缓冲input输入框的节点，方便聚焦与失焦
  final FocusNode? focusNode;

  @override
  State<MXSearchBar> createState() => _MXSearchBarState();
}

class _MXSearchBarState extends State<MXSearchBar> {
  @override
  void didUpdateWidget(covariant MXSearchBar oldWidget) {
    /// 当disabled改变时，需要刷新视图层
    if (oldWidget.disabled != widget.disabled) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  List<MXIcon>? _buildBarLeftIcon() {
    List<MXIcon>? child;

    /// 如果传入了左侧的icon并且并没有使用defaultback的，才能渲染自定义icon组件
    if (widget.searchBarLeftIcon != null && widget.useDefaultBack == false) {
      child = [];
      child.add(widget.searchBarLeftIcon!);
    }

    return child;
  }

  Widget _buildBody(BuildContext context) {
    return MXNavBar(
      barRightItems: widget.searchBarRightIconList,
      barLeftItems: _buildBarLeftIcon(),
      useTitleCenter: false,
      navBarHeight: widget.height,
      titleWidget: _buildSearchInput(),
      useDefaultBack: widget.useDefaultBack,
      backgroundColor: widget.backgroundColor ?? MXTheme.of(context).whiteColor,
    );
  }

  Widget? _buildRightWidget() {
    if (widget.inputRightIcon != null && widget.inputRightWidget == null) {
      return MXIcon(
        iconFontSize: 18,
        iconColor: MXTheme.of(context).fontUseIconColor,
        useDefaultPadding: false,
        icon: widget.inputRightIcon!,
      );
    } else if (widget.inputRightWidget != null) {
      return widget.inputRightWidget!;
    }

    return null;
  }

  double _getRadius() {
    if (widget.themeEnum == MXSearchBarThemeEnum.rect) {
      return MXTheme.of(context).radiusMedium;
    } else {
      return MXTheme.of(context).radiusRound;
    }
  }

  Widget _buildSearchInput() {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 36),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_getRadius()),
          child: MXInput(
            verticalPadding: 0,
            focusNode: widget.focusNode,
            contentPadding: const EdgeInsets.symmetric(vertical: 2),
            sizeEnum: MXInputSizeEnum.small,
            inputBackgroundColor: MXTheme.of(context).infoColor1,
            rightWidget: _buildRightWidget(),
            iconData: widget.inputLeftIcon,
            autofocus: widget.autofocus,
            disabled: widget.disabled,
            maxLength: widget.maxLength,
            placeholder: widget.placeholder,
            controller: widget.controller,
            onChange: (value) {
              widget.onChange?.call(value);
            },
            onEditingComplete: () {
              widget.onEditingComplete?.call();
            },
            onSubmitted: (value) {
              widget.onSubmitted?.call(value);
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
