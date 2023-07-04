import 'package:flutter/cupertino.dart';
import 'package:mx_widget/mx_widget.dart';

class MXSwiperCellHandle extends StatelessWidget {
  const MXSwiperCellHandle(
      {super.key,
      required this.swiperCellHandleController,
      required this.width});

  final SwiperCellHandleController swiperCellHandleController;
  final double width;

  Widget _buildBody(BuildContext context) {
    List<Widget> list = [];

    if (swiperCellHandleController.icon != null) {
      list.add(_buildIcon(context));
    }

    if (swiperCellHandleController.text != null) {
      if (list.isNotEmpty) {
        list.add(SizedBox(
          width: MXTheme.of(context).space8,
        ));
      }

      list.add(_buildText(context));
    }

    // AnimatedSize(duration: Duration(milliseconds: 600),curve: Cubic(a, b, c, d),);
    return GestureDetector(
        onTap: () {
          swiperCellHandleController.onTap?.call();
        },
        child: Container(
          width: width,
          padding: EdgeInsets.all(mxSwiperCellPadding),
          color: _buildBackgroundColor(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: list,
          ),
        ));
  }

  Widget _buildText(BuildContext context) {
    return Text(
      swiperCellHandleController.text!,
      style: TextStyle(
          fontSize: mxSwiperCellFontSize,
          color: MXTheme.of(context).whiteColor),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return MXIcon(
      useDefaultPadding: false,
      iconFontSize: mxSwiperCellFontSize,
      icon: swiperCellHandleController.icon!,
      iconColor: MXTheme.of(context).whiteColor,
    );
  }

  Color _buildBackgroundColor(BuildContext context) {
    switch (swiperCellHandleController.theme!) {
      case MXButtonThemeEnum.error:
        return MXTheme.of(context).errorPrimaryColor;
      case MXButtonThemeEnum.primary:
        return MXTheme.of(context).brandPrimaryColor;
      case MXButtonThemeEnum.info:
        return MXTheme.of(context).infoPrimaryColor;
      case MXButtonThemeEnum.warn:
        return MXTheme.of(context).warnPrimaryColor;
      case MXButtonThemeEnum.success:
        return MXTheme.of(context).successPrimaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
