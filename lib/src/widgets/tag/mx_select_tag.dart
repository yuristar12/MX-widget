import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/config/global_enum.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_base.dart';
import 'package:mx_widget/src/widgets/tag/mx_tag_mixins.dart';

// ignore: must_be_immutable
class MXSelectTag extends StatefulWidget implements MXTagBase {
  MXSelectTag(
      {super.key,
      required this.text,
      this.icon,
      this.padding,
      this.textWidget,
      this.iconWidget,
      this.backgroundColor,
      this.disabled = false,
      this.sizeEnum = MXTagSizeEnum.medium,
      this.modeEnum = MXTagModeEnum.deep,
      this.shapeEnum = MXTagshapeEnum.square,
      this.themeEnum = MXTagThemeEnum.primary,
      this.needCloseIcon = false,
      this.isSelect = false,
      this.selectOnChange});

  @override
  Color? backgroundColor;

  @override
  IconData? icon;

  @override
  Widget? iconWidget;

  @override
  MXTagModeEnum modeEnum;

  @override
  EdgeInsets? padding;

  @override
  MXTagshapeEnum shapeEnum;

  @override
  MXTagSizeEnum sizeEnum;

  @override
  String text;

  @override
  Widget? textWidget;

  @override
  MXTagThemeEnum themeEnum;

  final bool disabled;

  final bool needCloseIcon;

  final bool isSelect;

  final MXTagSelectOnChange? selectOnChange;

  @override
  State<MXSelectTag> createState() => _MXSelectTagState();
}

class _MXSelectTagState extends State<MXSelectTag> with MXTagMixins {
  late bool isSelect;
  @override
  void initState() {
    super.initState();

    _setSelect(widget.isSelect);
  }

  void _setSelect(bool value) {
    setState(() {
      isSelect = value;
      _setTagStyle();
    });
  }

  void _setTagStyle() {
    MXTagThemeEnum themeEnum;

    if (isSelect) {
      themeEnum = widget.themeEnum;
    } else {
      themeEnum = MXTagThemeEnum.info;
    }

    setStyle(context, widget.modeEnum, themeEnum, widget.shapeEnum,
        disabled: widget.disabled);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = buildTag(context, widget.sizeEnum, widget.text);

    child = GestureDetector(
      onTap: () {
        _setSelect(!isSelect);
      },
      child: child,
    );

    return child;
  }
}
