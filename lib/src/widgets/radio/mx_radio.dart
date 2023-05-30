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

  final String? title;

  final String? desSub;

  final bool disabled;

  final bool checked;

  final String? id;

  final bool showDivide;

  final int titleMaxLine;

  final int desSubMaxLine;

  final MXCheckBoxSizeEnum sizeEnum;

  final MXCheckBoxModeEnum modeEnum;

  final double? iconSpace;

  final Color? backgroundColor;

  final MXCheckBoxDirectionEnum directionEnum;

  final IconBuilder? iconBuilder;

  final ContentBuilder? contentBuilder;

  final OnCheckBoxValueChange? onCheckBoxValueChange;

  final double iconSize;
}
