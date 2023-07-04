import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';

final double paddingSpace = MXTheme.getThemeConfig().space8;

class MXDropDownMenuItem extends StatefulWidget {
  const MXDropDownMenuItem(
      {super.key,
      required this.dropDownMenuItemController,
      required this.onHandleMenuItem});

  final DropDownMenuItemController dropDownMenuItemController;

  final VoidCallback onHandleMenuItem;

  @override
  State<MXDropDownMenuItem> createState() => MXDropDownMenuItemState();
}

class MXDropDownMenuItemState extends State<MXDropDownMenuItem>
    with TickerProviderStateMixin {
  bool isActive = false;

  late AnimationController animationController;

  Tween<double> tween = Tween(begin: 0.0, end: 0.0);

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    super.initState();

    widget.dropDownMenuItemController.setState(this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Color _getFontColor() {
    if (widget.dropDownMenuItemController.disabled) {
      return MXTheme.of(context).fontUseDisabledColor;
    } else {
      if (isActive) {
        return MXTheme.of(context).brandPrimaryColor;
      } else {
        return MXTheme.of(context).fontUsePrimaryColor;
      }
    }
  }

  void onHandleActive(bool value) {
    if (isActive == value || widget.dropDownMenuItemController.disabled) return;
    isActive = value;

    setState(() {
      if (isActive) {
        tween = Tween(begin: 0, end: 0.5);
      } else {
        tween = Tween(begin: 0.5, end: 0);
      }
      animationController.forward(from: 0.0);
    });
  }

  Widget _buildBody() {
    Color fontColor = _getFontColor();
    return Container(
        padding: EdgeInsets.symmetric(horizontal: paddingSpace * 2),
        child: GestureDetector(
          onTap: () {
            if (widget.dropDownMenuItemController.disabled) return;
            onHandleActive(!isActive);
            widget.onHandleMenuItem();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MXText(
                data: widget.dropDownMenuItemController.label,
                font: MXTheme.of(context).fontBodySmall,
                textColor: fontColor,
              ),
              SizedBox(
                width: paddingSpace,
              ),
              RotationTransition(
                turns: tween.animate(CurvedAnimation(
                    parent: animationController, curve: CurveUtil.curve_1())),
                child: MXIcon(
                  icon: Icons.keyboard_arrow_down_rounded,
                  useDefaultPadding: false,
                  iconFontSize: 22,
                  iconColor: fontColor,
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
