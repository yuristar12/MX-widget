import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/dropDownMenu/mx_drop_down_menu_item.dart';
import 'package:mx_widget/src/widgets/dropDownMenu/mx_drop_down_menu_options.dart';

import 'drop_down_menu_toast_wrap.dart';

class MXDropDownMenu extends StatefulWidget {
  const MXDropDownMenu(
      {super.key,
      required this.menuList,
      this.renderHeight = 400,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween});

  final List<DropDownMenuItemController> menuList;

  final MainAxisAlignment mainAxisAlignment;

  final double renderHeight;

  @override
  State<MXDropDownMenu> createState() => _MXDropDownMenuState();
}

class _MXDropDownMenuState extends State<MXDropDownMenu> {
  DropDownMenuToastWrap? dropDownMenuToastWrap;

  MXDropDownMenuOptions? mxDropDownMenuOptions;

  MXDropDownMenuOptionsState? mxDropDownMenuOptionsState;

  List<MXDropDownMenuItem> mxDropDownMenuItemList = [];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    mxDropDownMenuItemList = [];
    for (var element in widget.menuList) {
      mxDropDownMenuItemList.add(MXDropDownMenuItem(
        dropDownMenuItemController: element,
        onHandleMenuItem: () {
          _onRenderPopup(context, element);
        },
      ));
    }

    return Container(
      height: 48,
      decoration: BoxDecoration(
          color: MXTheme.of(context).whiteColor,
          border: Border(
              bottom: BorderSide(
                  width: 1, color: MXTheme.of(context).infoPrimaryColor))),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: widget.mainAxisAlignment,
          children: mxDropDownMenuItemList),
    );
  }

  void _onRenderPopup(BuildContext context,
      DropDownMenuItemController dropDownMenuItemController) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    Offset position = renderBox.localToGlobal(Offset.zero);

    double renderSelfHeight = renderBox.size.height;

    double renderWidth = renderBox.size.width;

    if (dropDownMenuToastWrap == null) {
      dropDownMenuToastWrap = DropDownMenuToastWrap();

      mxDropDownMenuOptions =
          _buildDropDownMenuOptions(dropDownMenuItemController);

      dropDownMenuToastWrap?.onRender(
          context: context,
          renderWidth: renderWidth,
          child: mxDropDownMenuOptions!,
          position: position,
          renderSelfHeight: renderSelfHeight,
          renderHeight: widget.renderHeight);
    } else {
      if (mxDropDownMenuOptions!.dropDownMenuItemController ==
          dropDownMenuItemController) {
        _onCloseMenuOptions();
      } else {
        for (var element in widget.menuList) {
          if (element != dropDownMenuItemController) {
            element.state?.onHandleActive(false);
          }
        }

        Future.delayed(Duration.zero, () {
          mxDropDownMenuOptions!
              .onUpdateDropDownMenuItemController(dropDownMenuItemController);

          mxDropDownMenuOptionsState?.onChangeController();
        });
      }
    }
  }

  MXDropDownMenuOptions _buildDropDownMenuOptions(
      DropDownMenuItemController dropDownMenuItemController) {
    return MXDropDownMenuOptions(
        height: widget.renderHeight,
        onConfirmCallback: () {
          _onCloseMenuOptions();
        },
        getMXDropDownMenuOptionsState: (p0) {
          mxDropDownMenuOptionsState = p0;
        },
        dropAnimationCallback: onMenuOptionsAnimationed,
        dropDownMenuItemController: dropDownMenuItemController);
  }

  void _onCloseMenuOptions() {
    if (dropDownMenuToastWrap != null && mxDropDownMenuOptionsState != null) {
      mxDropDownMenuOptionsState?.animationController.reverse();
    }
  }

  void onMenuOptionsAnimationed(DropAnimationStatusEnum statusEnum) {
    if (statusEnum == DropAnimationStatusEnum.remove) {
      dropDownMenuToastWrap?.onHiden();
      dropDownMenuToastWrap = null;

      for (var element in widget.menuList) {
        element.state?.onHandleActive(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) {
        if (dropDownMenuToastWrap != null) {
          if (!dropDownMenuToastWrap!.hasClickRange(event.position)) {
            _onCloseMenuOptions();
          }
        }
      },
      child: _buildBody(context),
    );
  }
}
