import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';

enum DropAnimationStatusEnum {
  builded,
  remove,
}

typedef DropAnimationCallback = void Function(
    DropAnimationStatusEnum statusEnum);

typedef GetMXDropDownMenuOptionsState = void Function(
    MXDropDownMenuOptionsState);

double paddingSpace = MXTheme.getThemeConfig().space16;

double footerHeight = 85;
BorderSide borderSide =
    BorderSide(color: MXTheme.getThemeConfig().infoPrimaryColor, width: 1);

// ignore: must_be_immutable
class MXDropDownMenuOptions extends StatefulWidget {
  MXDropDownMenuOptions(
      {super.key,
      required this.height,
      required this.onConfirmCallback,
      required this.dropDownMenuItemController,
      required this.dropAnimationCallback,
      required this.getMXDropDownMenuOptionsState});

  final double height;

  final VoidCallback onConfirmCallback;

  final GetMXDropDownMenuOptionsState getMXDropDownMenuOptionsState;

  final DropAnimationCallback dropAnimationCallback;

  DropDownMenuItemController dropDownMenuItemController;

  @override
  State<MXDropDownMenuOptions> createState() => MXDropDownMenuOptionsState();

  void onUpdateDropDownMenuItemController(
      DropDownMenuItemController newDropDownMenuItemController) {
    dropDownMenuItemController = newDropDownMenuItemController;
  }
}

class MXDropDownMenuOptionsState extends State<MXDropDownMenuOptions>
    with TickerProviderStateMixin {
  double widthFactor = 1;

  late AnimationController animationController;

  bool isBuildAnimationOvered = false;

  @override
  void initState() {
    _onInit();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    animationController.addStatusListener((status) {
      DropAnimationStatusEnum statusEnum;
      if (status == AnimationStatus.completed) {
        isBuildAnimationOvered = true;
        statusEnum = DropAnimationStatusEnum.builded;
        widget.dropAnimationCallback(statusEnum);
        setState(() {});
      } else if (status == AnimationStatus.dismissed) {
        statusEnum = DropAnimationStatusEnum.remove;
        widget.dropAnimationCallback(statusEnum);
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MXDropDownMenuOptions oldWidget) {
    if (oldWidget.dropDownMenuItemController !=
        widget.dropDownMenuItemController) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onInitValue() {
    List<String>? initValue = widget.dropDownMenuItemController.initValue;

    if (initValue != null) {
      for (var element in initValue) {
        widget.dropDownMenuItemController.value.add(element);
      }
    }
  }

  void _onInit() {
    _setWidthFactor();
    //  需要初始化默认值
    _onInitValue();
  }

  void onChangeController() {
    _onInit();
    setState(() {});
  }

  void _setWidthFactor() {
    switch (widget.dropDownMenuItemController.columnsEnum) {
      case MXDropDownMenuItemColumnsEnum.one:
        widthFactor = 1;
        break;
      case MXDropDownMenuItemColumnsEnum.two:
        widthFactor = 0.5;
        break;
      case MXDropDownMenuItemColumnsEnum.three:
        widthFactor = 1 / 3;
        break;
      default:
    }
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildMiddle(), _buildFooter()],
    );
  }

  void _onHandleOptions(Map<MXDropDownMenuOptionsEnum, String> item) {
    // 需要判断是否支持多选还是单选
    int index = widget.dropDownMenuItemController.value
        .indexOf(item[MXDropDownMenuOptionsEnum.value]!);
    if (widget.dropDownMenuItemController.multiple) {
      if (index > -1) {
        widget.dropDownMenuItemController.value.removeAt(index);
      } else {
        widget.dropDownMenuItemController.value
            .add(item[MXDropDownMenuOptionsEnum.value]!);
      }
    } else {
      if (widget.dropDownMenuItemController.value.isNotEmpty) {
        widget.dropDownMenuItemController.value.clear();
        if (index > -1) {
          _onHandleOver();
          return;
        }
      }
      widget.dropDownMenuItemController.value
          .add(item[MXDropDownMenuOptionsEnum.value]!);
    }
    _onHandleOver();
  }

  void _onHandleOver() {
    widget.dropDownMenuItemController.onChange
        ?.call(widget.dropDownMenuItemController.value);

    setState(() {});
  }

  Widget _buildButton(Map<MXDropDownMenuOptionsEnum, String> item) {
    // 判断是否选中
    bool isActive = _getOptionsItemIsActive(item);

    bool isDisabled = false;
    // 如果不是选中判断是否是禁用的
    if (!isActive) {
      isDisabled = _getOptionsItemIsDisabled(item);
    }

    return FractionallySizedBox(
        widthFactor: widthFactor,
        child: isActive
            ? _buildActiveButton(item, isDisabled)
            : _buildNormalButton(item, isDisabled));
  }

  Widget _buildActiveButton(
      Map<MXDropDownMenuOptionsEnum, String> item, bool disabled) {
    return MXButton(
      afterClickButtonCallback: () {
        if (disabled) return;
        _onHandleOptions(item);
      },
      disabled: disabled,
      customMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      text: item[MXDropDownMenuOptionsEnum.label]!,
      themeEnum: MXButtonThemeEnum.primary,
      typeEnum: MXButtonTypeEnum.plain,
      textStyle: TextStyle(
          fontSize: MXTheme.of(context).fontBodySmall!.size,
          color: disabled
              ? MXTheme.of(context).brandDisabledColor
              : MXTheme.of(context).brandPrimaryColor),
    );
  }

  Widget _buildNormalButton(
      Map<MXDropDownMenuOptionsEnum, String> item, bool disabled) {
    return MXButton(
      afterClickButtonCallback: () {
        if (disabled) return;
        _onHandleOptions(item);
      },
      disabled: disabled,
      customMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      text: item[MXDropDownMenuOptionsEnum.label]!,
      themeEnum: MXButtonThemeEnum.info,
      typeEnum: MXButtonTypeEnum.fill,
      textStyle: TextStyle(
          fontSize: MXTheme.of(context).fontBodySmall!.size,
          color: disabled
              ? MXTheme.of(context).fontUseDisabledColor
              : MXTheme.of(context).fontUsePrimaryColor),
    );
  }

  bool _getOptionsItemIsActive(Map<MXDropDownMenuOptionsEnum, String> item) {
    int index = widget.dropDownMenuItemController.value.indexWhere((element) {
      return item[MXDropDownMenuOptionsEnum.value] == element;
    });

    if (index > -1) {
      return true;
    }
    return false;
  }

  bool _getOptionsItemIsDisabled(Map<MXDropDownMenuOptionsEnum, String> item) {
    if (widget.dropDownMenuItemController.disabledIds != null) {
      int index =
          widget.dropDownMenuItemController.disabledIds!.indexWhere((element) {
        return item[MXDropDownMenuOptionsEnum.value] == element;
      });

      if (index > -1) {
        return true;
      }
      return false;
    }

    return false;
  }

  Widget _buildMiddle() {
    List<Widget> children = [];

    if (isBuildAnimationOvered) {
      for (var element in widget.dropDownMenuItemController.options) {
        children.add(_buildButton(element));
      }
    }

    return Container(
      padding: EdgeInsets.all(paddingSpace / 2),
      height: widget.height - footerHeight,
      child: SingleChildScrollView(
        child: Wrap(children: children),
      ),
    );
  }

  Widget _buildFooter() {
    const margin = EdgeInsets.all(0);

    bool isHandleButtonDisabled =
        widget.dropDownMenuItemController.value.isEmpty;

    return Container(
      decoration: BoxDecoration(border: Border(top: borderSide)),
      padding: EdgeInsets.all(paddingSpace),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: MXButton(
              isLine: true,
              disabled: widget.dropDownMenuItemController.initValue != null
                  ? false
                  : isHandleButtonDisabled,
              sizeEnum: MXButtonSizeEnum.large,
              customMargin: margin,
              text: "重置",
              themeEnum: MXButtonThemeEnum.primary,
              typeEnum: MXButtonTypeEnum.plain,
              afterClickButtonCallback: () {
                widget.dropDownMenuItemController.value = [];
                _onInitValue();
                setState(() {});
              },
            ),
          ),
          SizedBox(
            width: paddingSpace,
          ),
          Flexible(
              child: MXButton(
            text: "确定",
            isLine: true,
            disabled: isHandleButtonDisabled,
            sizeEnum: MXButtonSizeEnum.large,
            customMargin: margin,
            themeEnum: MXButtonThemeEnum.primary,
            typeEnum: MXButtonTypeEnum.fill,
            afterClickButtonCallback: () {
              widget.dropDownMenuItemController.onConfirm
                  ?.call(widget.dropDownMenuItemController.value);

              // animationController.reverse();

              widget.onConfirmCallback.call();
            },
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();

    widget.getMXDropDownMenuOptionsState(this);
    return AnimatedBuilder(
      animation: CurvedAnimation(
          parent: animationController, curve: CurveUtil.curve_1()),
      builder: (context, child) {
        return Opacity(
          opacity: animationController.value,
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
                color: MXTheme.of(context).whiteColor,
                border: Border(
                    right: borderSide, left: borderSide, bottom: borderSide)),
            child: _buildBody(),
          ),
        );
      },
    );
  }
}
