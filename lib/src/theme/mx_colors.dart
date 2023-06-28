import 'dart:ui';

import 'package:mx_widget/src/theme/mx_theme.dart';

extension MXColors on MXThemeConfig {
  // 如果主题并没有成功赋值则寻找默认的主题的AHEX模式
  // ----------------------------------------------------------------------品牌色
  /// #F2F8FF
  Color get brandColor1 => colorsMap['brandColor1'] ?? const Color(0xFFF2F8FF);

  /// #C9E0FF
  Color get brandColor2 => colorsMap['brandColor2'] ?? const Color(0xFFC9E0FF);

  /// #A3C6FF
  Color get brandColor3 => colorsMap['brandColor3'] ?? const Color(0xFFA3C6FF);

  /// #7AA9FF
  Color get brandColor4 => colorsMap['brandColor4'] ?? const Color(0xFF7AA9FF);

  /// #548AFF
  Color get brandColor5 => colorsMap['brandColor5'] ?? const Color(0xFF548AFF);

  /// #2C68FF
  Color get brandColor6 => colorsMap['brandColor6'] ?? const Color(0xFF2C68FF);

  /// #1C4AD4
  Color get brandColor7 => colorsMap['brandColor7'] ?? const Color(0xFF1C4AD4);

  /// #0D2EA6
  Color get brandColor8 => colorsMap['brandColor8'] ?? const Color(0xFF0D2EA6);

  /// #051A7A
  Color get brandColor9 => colorsMap['brandColor9'] ?? const Color(0xFF051A7A);

  /// #2C68FF
  Color get brandPrimaryColor =>
      colorsMap['brandPrimaryColor'] ?? const Color(0xFF2C68FF);

  /// #7AA9FF
  Color get brandFocusColor =>
      colorsMap['brandFocusColor'] ?? const Color(0xFF7AA9FF);

  /// #A3C6FF
  Color get brandDisabledColor =>
      colorsMap['brandDisabledColor'] ?? const Color(0xFFA3C6FF);

  /// #1C4AD4
  Color get brandClickColor =>
      colorsMap['brandClickColor'] ?? const Color(0xFF1C4AD4);

  // ----------------------------------------------------------------------错误色
  /// #FFF2F5
  Color get errorColor1 => colorsMap['errorColor1'] ?? const Color(0xFFFFF2F5);

  /// #FFCCD7
  Color get errorColor2 => colorsMap['errorColor2'] ?? const Color(0xFFFFCCD7);

  /// #FFA6B6
  Color get errorColor3 => colorsMap['errorColor2'] ?? const Color(0xFFFFA6B6);

  /// #FF7D90
  Color get errorColor4 => colorsMap['errorColor4'] ?? const Color(0xFFFF7D90);

  /// #FF576A
  Color get errorColor5 => colorsMap['errorColor5'] ?? const Color(0xFFFF576A);

  /// #F52F3E
  Color get errorColor6 => colorsMap['errorColor6'] ?? const Color(0xFFF52F3E);

  /// #CC1D31
  Color get errorColor7 => colorsMap['errorColor7'] ?? const Color(0xFFCC1D31);

  /// #A10E24
  Color get errorColor8 => colorsMap['errorColor8'] ?? const Color(0xFFA10E24);

  /// #78061B
  Color get errorColor9 => colorsMap['errorColor9'] ?? const Color(0xFF78061B);

  /// #F52F3E
  Color get errorPrimaryColor =>
      colorsMap['errorPrimaryColor'] ?? const Color(0xFFF52F3E);

  /// #FF7D90
  Color get errorFocusColor =>
      colorsMap['errorFocusColor'] ?? const Color(0xFFFF7D90);

  /// #FFA6B6
  Color get errorDisabledColor =>
      colorsMap['errorDisabledColor'] ?? const Color(0xFFFFA6B6);

  /// #CC1D31
  Color get errorClickColor =>
      colorsMap['errorClickColor'] ?? const Color(0xFFCC1D31);

  // ----------------------------------------------------------------------成功色
  /// #F2FFFB
  Color get successColor1 =>
      colorsMap['successColor1'] ?? const Color(0xFFF2FFFB);

  /// #BEF7E5
  Color get successColor2 =>
      colorsMap['successColor2'] ?? const Color(0xFFBEF7E5);

  /// #90F0CE
  Color get successColor3 =>
      colorsMap['successColor2'] ?? const Color(0xFF90F0CE);

  /// #60E6B2
  Color get successColor4 =>
      colorsMap['successColor4'] ?? const Color(0xFF60E6B2);

  /// #37DE99
  Color get successColor5 =>
      colorsMap['successColor5'] ?? const Color(0xFF049149);

  /// #0ED57D
  Color get successColor6 =>
      colorsMap['successColor6'] ?? const Color(0xFF0ED57D);

  /// #09B562
  Color get successColor7 =>
      colorsMap['successColor7'] ?? const Color(0xFF09B562);

  /// #049149
  Color get successColor8 =>
      colorsMap['successColor8'] ?? const Color(0xFF049149);

  /// #027034
  Color get successColor9 =>
      colorsMap['successColor9'] ?? const Color(0xFF027034);

  /// #0ED57D
  Color get successPrimaryColor =>
      colorsMap['successPrimaryColor'] ?? const Color(0xFF0ED57D);

  /// #60E6B2
  Color get successFocusColor =>
      colorsMap['successFocusColor'] ?? const Color(0xFF60E6B2);

  /// #90F0CE
  Color get successDisabledColor =>
      colorsMap['successDisabledColor'] ?? const Color(0xFF90F0CE);

  /// #09B562
  Color get successClickColor =>
      colorsMap['successClickColor'] ?? const Color(0xFF09B562);

  // ----------------------------------------------------------------------警告色
  /// #FFFCF2
  Color get warnColor1 => colorsMap['warnColor1'] ?? const Color(0xFFFFFCF2);

  /// #FFF0C2
  Color get warnColor2 => colorsMap['warnColor2'] ?? const Color(0xFFFFF0C2);

  /// #FFE091
  Color get warnColor3 => colorsMap['warnColor2'] ?? const Color(0xFFFFE091);

  /// #FFCD61
  Color get warnColor4 => colorsMap['warnColor4'] ?? const Color(0xFFFFCD61);

  /// #FFB730
  Color get warnColor5 => colorsMap['warnColor5'] ?? const Color(0xFFFFB730);

  /// #FF9C00
  Color get warnColor6 => colorsMap['warnColor6'] ?? const Color(0xFFFF9C00);

  /// #D47B00
  Color get warnColor7 => colorsMap['warnColor7'] ?? const Color(0xFFD47B00);

  /// #A65B00
  Color get warnColor8 => colorsMap['warnColor8'] ?? const Color(0xFFA65B00);

  /// #7A3F00
  Color get warnColor9 => colorsMap['warnColor9'] ?? const Color(0xFF7A3F00);

  /// #FF9C00
  Color get warnPrimaryColor =>
      colorsMap['warnPrimaryColor'] ?? const Color(0xFFFF9C00);

  /// #FFCD61
  Color get warnFocusColor =>
      colorsMap['warnFocusColor'] ?? const Color(0xFFFFCD61);

  /// #FFE091
  Color get warnDisabledColor =>
      colorsMap['warnDisabledColor'] ?? const Color(0xFFFFE091);

  /// #D47B00
  Color get warnClickColor =>
      colorsMap['warnClickColor'] ?? const Color(0xFFD47B00);

  // ----------------------------------------------------------------------信息色
  /// #F5F5F5
  Color get infoColor1 => colorsMap['infoColor1'] ?? const Color(0xfff5f5f5);

  /// #F0F0F0
  Color get infoColor2 => colorsMap['infoColor2'] ?? const Color(0xfff0f0f0);

  /// #E5E5E5
  Color get infoColor3 => colorsMap['infoColor2'] ?? const Color(0xffe5e5e5);

  /// #D9D9D9
  Color get infoColor4 => colorsMap['infoColor4'] ?? const Color(0xffd9d9d9);

  /// #BFBFBF
  Color get infoColor5 => colorsMap['infoColor5'] ?? const Color(0xffbfbfbf);

  /// #8C8C8C
  Color get infoColor6 => colorsMap['infoColor6'] ?? const Color(0xff8c8c8c);

  /// #595959
  Color get infoColor7 => colorsMap['infoColor7'] ?? const Color(0xff595959);

  /// #262626
  Color get infoColor8 => colorsMap['infoColor8'] ?? const Color(0xff262626);

  /// #000000
  Color get infoColor9 => colorsMap['infoColor9'] ?? const Color(0xff000000);

  /// #F5F5F5
  Color get infoPrimaryColor =>
      colorsMap['infoPrimaryColor'] ?? const Color(0xFFF0F0F0);

  /// #E5E5E5
  Color get infoDisabledColor =>
      colorsMap['infoDisabledColor'] ?? const Color(0xFFF5F5F5);

  // --------------------------------------------------------------------字体颜色
  /// #F5F5F5
  Color get fontColor1 => colorsMap['fontColor1'] ?? const Color(0xfff5f5f5);

  /// #F0F0F0
  Color get fontColor2 => colorsMap['fontColor2'] ?? const Color(0xfff0f0f0);

  /// #E5E5E5
  Color get fontColor3 => colorsMap['fontColor2'] ?? const Color(0xffe5e5e5);

  /// #D9D9D9
  Color get fontColor4 => colorsMap['fontColor4'] ?? const Color(0xffd9d9d9);

  /// #BFBFBF
  Color get fontColor5 => colorsMap['fontColor5'] ?? const Color(0xffbfbfbf);

  /// #8C8C8C
  Color get fontColor6 => colorsMap['fontColor6'] ?? const Color(0xff8c8c8c);

  /// #595959
  Color get fontColor7 => colorsMap['fontColor7'] ?? const Color(0xff595959);

  /// #262626
  Color get fontColor8 => colorsMap['fontColor8'] ?? const Color(0xff262626);

  /// #262626
  Color get fontUsePrimaryColor =>
      colorsMap['fontUsePrimaryColor'] ?? const Color(0xff262626);

  /// #595959
  Color get fontUseSecondColors =>
      colorsMap['fontUseSecondColors'] ?? const Color(0xff595959);

  /// #8c8c8c
  Color get fontUseIconColor =>
      colorsMap['fontUseIconColor'] ?? const Color(0xff8c8c8c);

  /// #BFBFBF
  Color get fontUseDisabledColor =>
      colorsMap['fontUseDisabledColor'] ?? const Color(0xffbfbfbf);

  /// #FFFFFF
  Color get whiteColor => colorsMap['whiteColor'] ?? const Color(0xFFFFFFFF);

  /// #a500030e
  Color get mask1 => colorsMap['mask1'] ?? const Color(0xa500030e);

  /// #d900030e
  Color get mask2 => colorsMap['mask2'] ?? const Color(0xd900030e);
}
