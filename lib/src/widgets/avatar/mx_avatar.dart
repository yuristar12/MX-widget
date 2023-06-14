import 'package:flutter/material.dart';
import 'package:mx_widget/src/theme/mx_colors.dart';
import 'package:mx_widget/src/theme/mx_fonts.dart';
import 'package:mx_widget/src/theme/mx_radius.dart';
import 'package:mx_widget/src/theme/mx_theme.dart';
import 'package:mx_widget/src/widgets/icon/mx_icon.dart';
import 'package:mx_widget/src/widgets/image/mx_image.dart';

import '../../config/global_enum.dart';

typedef AvatarAppendixCallback = void Function();

///----------------------------------------------------------------------头像组件
/// [text] 文字头像的内容
/// [icon] icon头像展示的icon
/// [onTap] 头像的点击事件
/// [radius] 头像自定义圆角，如果有优先取这个
/// [iconSize] 自定义icon大小，如果有优先取这个
/// [modeEnum] 头像类型icon/img/text/imgList
/// [sizeEnum] 头像大小lager/medium/small
/// [textStyle] 文字头像的文字自定义样式，如果有优先取这个
/// [shapeEnum] 头像新增circle/square
/// [avatarSize] 自定义头像大小
/// [avatarNetUrl] 头像在线地址
/// [avatarsPadding] 头像组头像之间的间隔
/// [avatarAssetsUrl] 头像本地地址
/// [avatarNetUrlList] 头像组各个头像展示的图片网络链接
/// [avatarsBorderWidth] 头像组头像的外边框宽度
/// [avatarAppendixText] 头像组最后一头像展示的文字内容
/// [avatarAssetsUrlList] 头像组各个头像展示的图片本地链接
/// [avatarAppendixCallback] 头像组最后一头像是否拥有点击事件

class MXAvatar extends StatelessWidget {
  const MXAvatar(
      {super.key,
      this.modeEnum = MXAvatarModeEnum.img,
      this.sizeEnum = MXAvatarSizeEnum.medium,
      this.shapeEnum = MXAvatarShapeEnum.square,
      this.avatarsPadding = 8,
      this.avatarsBorderWidth = 2,
      this.avatarSize,
      this.avatarNetUrl,
      this.avatarAssetsUrl,
      this.text,
      this.icon,
      this.radius,
      this.iconSize,
      this.onTap,
      this.textStyle,
      this.avatarNetUrlList,
      this.avatarAssetsUrlList,
      this.avatarAppendixText,
      this.avatarAppendixCallback});

  /// 头像的模式
  final MXAvatarModeEnum modeEnum;

  /// 头像的大小
  final MXAvatarSizeEnum sizeEnum;

  /// 头像的展示类型
  final MXAvatarShapeEnum shapeEnum;

  /// 自定义头像的大小如果有优先取这个
  final double? avatarSize;

  /// 头像的地址（网络）
  final String? avatarNetUrl;

  /// 头像的地址（本地）
  final String? avatarAssetsUrl;

  /// 头像列表的地址（网络）
  final List<String>? avatarNetUrlList;

  /// 头像列表的地址（本地）
  final List<String>? avatarAssetsUrlList;

  /// 头像文字
  final String? text;

  /// 头像自定义icon 如果有优先取这个
  final IconData? icon;

  /// 头像自定义圆角 如果有优先取这个
  final double? radius;

  /// 头像点击事件
  final Function? onTap;

  /// 自定义icon大小
  final double? iconSize;

  /// 自定义文字样式

  final TextStyle? textStyle;

  ///  当头像为列表的时候，头像与头像重叠的距离
  final double avatarsPadding;

  /// 当头像为列表的时候，头像的边框距离

  final double avatarsBorderWidth;

  /// 当头像为组时显示在最后面的文字
  final String? avatarAppendixText;

  /// 当头像为组时显示在最后面是否包含点击事件
  final AvatarAppendixCallback? avatarAppendixCallback;

  /// 获取头像尺寸
  double _getSize() {
    double size;
    switch (sizeEnum) {
      case MXAvatarSizeEnum.lager:
        size = 64;
        break;
      case MXAvatarSizeEnum.medium:
        size = 48;
        break;
      case MXAvatarSizeEnum.small:
        size = 40;
        break;
    }

    return avatarSize ?? size;
  }

  /// 获取头像的icon

  Widget _getIcon(BuildContext context) {
    return MXIcon(
      icon: icon ?? Icons.account_circle,
      // iconFontSize: ,
      iconColor: MXTheme.of(context).brandPrimaryColor,
      iconFontSize: _getIconSize(context),
    );
  }

  double _getIconSize(BuildContext context) {
    double defaultIconSize;
    switch (sizeEnum) {
      case MXAvatarSizeEnum.lager:
        defaultIconSize = MXTheme.of(context).fontTitleMedium!.size;
        break;
      case MXAvatarSizeEnum.medium:
        defaultIconSize = MXTheme.of(context).fontTitleSmall!.size;
        break;
      case MXAvatarSizeEnum.small:
        defaultIconSize = MXTheme.of(context).fontBodyLarge!.size;
        break;
    }

    return iconSize ?? defaultIconSize;
  }

  double _getRadius(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    double _radius;

    switch (shapeEnum) {
      case MXAvatarShapeEnum.square:
        _radius = MXTheme.of(context).radiusDefault;
        break;
      case MXAvatarShapeEnum.circle:
        _radius = _getSize() / 2;
        break;
    }

    return radius ?? _radius;
  }

  /// 基础icon基础配置
  Widget _buildBaseAvatarBody(BuildContext context, Widget child) {
    return GestureDetector(
      onTap: () {
        avatarAppendixCallback?.call();
      },
      child: Container(
        width: _getSize(),
        height: _getSize(),
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: MXTheme.of(context).brandDisabledColor,
            borderRadius:
                BorderRadius.all(Radius.circular(_getRadius(context)))),
        child: Center(child: child),
      ),
    );
  }

  /// 获取文字内容
  Widget _getText(BuildContext context, {String? paramsText}) {
    return Text(
      text ?? paramsText!,
      style: textStyle ??
          TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              fontSize: _getIconSize(context),
              color: MXTheme.of(context).brandPrimaryColor),
    );
  }

  /// 获取图片
  Widget _getImage(String url, {bool isNet = false}) {
    double size = _getSize();

    if (isNet) {
      return MXImage(
        netUrl: url,
        width: size,
        height: size,
      );
    } else {
      return MXImage(
        assetsUrl: url,
        width: size,
        height: size,
      );
    }
  }

  Widget _buildImgAvatar(BuildContext context) {
    if (avatarAssetsUrl != null) {
      return _buildBaseAvatarBody(
          context, _getImage(avatarAssetsUrl!, isNet: false));
    } else {
      return _buildBaseAvatarBody(
          context, _getImage(avatarNetUrl!, isNet: true));
    }
  }

  List<Widget> _getAvatarList(
      BuildContext context, List<String> list, bool isNet) {
    List<Widget> childrenList = [];

    var size = _getSize();

    if (avatarAppendixCallback == null) {
      int length = list.length;
      for (int i = length; i > -1; i--) {
        dynamic weight;
        if (i == length) {
          weight = Positioned(
              top: 0,
              right: 0,
              child:
                  _buildPostionChild(context, _buildAvatarByAppendix(context)));
        } else {
          weight = Container();
          weight = Positioned(
              top: 0,
              left:
                  i == 0 ? 0 : i * (size - avatarsPadding + avatarsBorderWidth),
              child: _buildPostionChild(
                  context,
                  _buildBaseAvatarBody(
                      context, _getImage(list[i], isNet: isNet))));
        }

        childrenList.add(weight);
      }
    } else {
      for (int i = 0; i <= list.length; i++) {
        var weight = Positioned(
            top: 0,
            left: i == 0
                ? 0
                : (i * (size + avatarsBorderWidth - avatarsPadding)) -
                    avatarsBorderWidth,
            child: _buildPostionChild(
                context,
                i != list.length
                    ? _buildBaseAvatarBody(
                        context, _getImage(list[i], isNet: isNet))
                    : _buildAvatarByAppendix(context)));

        childrenList.add(weight);
      }
    }

    return childrenList;
  }

  Widget _buildPostionChild(BuildContext context, Widget child) {
    var size = _getSize();

    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size - avatarsPadding),
                side: BorderSide(
                    color: MXTheme.of(context).brandDisabledColor,
                    width: avatarsBorderWidth))),
        child: child);
  }

  /// 构建头像组最后面的文字提示

  Widget _buildAvatarByAppendix(BuildContext context) {
    Widget child;

    child = _buildBaseAvatarBody(
        context, _getText(context, paramsText: avatarAppendixText));

    if (avatarAppendixCallback != null) {
      return GestureDetector(
        onTap: () {
          avatarAppendixCallback!.call();
        },
        child: child,
      );
    } else {
      return child;
    }
  }

  /// 构建头像列表
  Widget _buildAvatarList(BuildContext context) {
    double size = _getSize();

    List<String> urlList = [];
    List<Widget> childrenList = [];

    if (avatarAssetsUrlList != null) {
      urlList = avatarAssetsUrlList!;
      childrenList = _getAvatarList(context, urlList, false);
    } else {
      urlList = avatarNetUrlList!;
      childrenList = _getAvatarList(context, urlList, true);
    }

    return SizedBox(
        width: (size + (avatarsBorderWidth)) * childrenList.length -
            ((childrenList.length - 1) * avatarsPadding),
        height: size + (avatarsBorderWidth * 2),
        child: Stack(
          children: childrenList,
        ));
  }

  Widget buildAvatarBody(BuildContext context) {
    switch (modeEnum) {
      case MXAvatarModeEnum.icon:
        return _buildBaseAvatarBody(context, _getIcon(context));
      case MXAvatarModeEnum.text:
        return _buildBaseAvatarBody(context, _getText(context));
      case MXAvatarModeEnum.img:
        return _buildImgAvatar(context);
      case MXAvatarModeEnum.imgList:
        return _buildAvatarList(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildAvatarBody(context);
  }
}
