import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/export.dart';

class MXRadio extends MXCheckBox {
  MXRadio({
    super.key,
    this.title,
    this.desSub,
    this.disabled = false,
    this.checked = false,
    this.id,
    this.showDivide = false,
    this.titleMaxLine = 1,
    this.desSubMaxLine = 1,
    this.sizeEnum = MXCheckBoxSizeEnum.small,
    this.modeEnum = MXCheckBoxModeEnum.circle,
    this.iconSpace,
    this.backgroundColor,
    this.directionEnum = MXCheckBoxDirectionEnum.left,
    this.iconBuilder,
    this.contentBuilder,
    this.onCheckBoxValueChange,
    this.iconSize = 22,
  })  : assert(() {
          if (modeEnum == MXCheckBoxModeEnum.square) {
            throw FlutterError('radio请勿使用square样式，如需要使用请更换成MXCheckBox组件');
          }

          return true;
        }()),
        super(
            title: title,
            desSub: desSub,
            disabled: disabled,
            checked: checked,
            id: id,
            showDivide: showDivide,
            titleMaxLine: titleMaxLine,
            desSubMaxLine: desSubMaxLine,
            sizeEnum: sizeEnum,
            modeEnum: modeEnum,
            iconSpace: iconSpace,
            backgroundColor: backgroundColor,
            directionEnum: directionEnum,
            iconBuilder: iconBuilder,
            contentBuilder: contentBuilder,
            onCheckBoxValueChange: onCheckBoxValueChange,
            iconSize: iconSize);

  // ignore: annotate_overrides, overridden_fields
  final String? title;

  // ignore: annotate_overrides, overridden_fields
  final String? desSub;

  // ignore: annotate_overrides, overridden_fields
  final bool disabled;

  // ignore: annotate_overrides, overridden_fields
  final bool checked;

  // ignore: annotate_overrides, overridden_fields
  final String? id;

  // ignore: annotate_overrides, overridden_fields
  final bool showDivide;

  // ignore: annotate_overrides, overridden_fields
  final int titleMaxLine;

  // ignore: annotate_overrides, overridden_fields
  final int desSubMaxLine;

  // ignore: annotate_overrides, overridden_fields
  final MXCheckBoxSizeEnum sizeEnum;

  // ignore: annotate_overrides, overridden_fields
  final MXCheckBoxModeEnum modeEnum;

  // ignore: annotate_overrides, overridden_fields
  final double? iconSpace;

  // ignore: annotate_overrides, overridden_fields
  final Color? backgroundColor;

  // ignore: annotate_overrides, overridden_fields
  final MXCheckBoxDirectionEnum directionEnum;

  // ignore: annotate_overrides, overridden_fields
  final IconBuilder? iconBuilder;

  // ignore: annotate_overrides, overridden_fields
  final ContentBuilder? contentBuilder;

  // ignore: annotate_overrides, overridden_fields
  final OnCheckBoxValueChange? onCheckBoxValueChange;

  // ignore: annotate_overrides, overridden_fields
  final double iconSize;
}
