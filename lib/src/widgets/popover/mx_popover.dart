import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/popover/mx_popover_model.dart';
import 'package:mx_widget/src/widgets/popover/popover_position.dart';
import 'package:mx_widget/src/widgets/popover/popover_over_layer_controller.dart';

// ignore: must_be_immutable
class MXPopover extends StatefulWidget {
  MXPopover({
    super.key,
    this.contentByText,
    this.contentByWidget,
    this.popoverModel,
    required this.triggerWidget,
    this.positionEnum = MXPopoverPositionEnum.topCenter,
  }) {
    popoverModel ??= MXPopoverModel();
  }

  final Widget triggerWidget;

  final String? contentByText;
  final Widget? contentByWidget;

  MXPopoverModel? popoverModel;

  final MXPopoverPositionEnum positionEnum;

  @override
  State<MXPopover> createState() => _MXPopoverState();
}

class _MXPopoverState extends State<MXPopover> {
  final GlobalKey key = GlobalKey();

  late PopoverOverLayerController controller;

  late PopoverPosition position;

  @override
  void dispose() {
    controller.onRemove();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _initController();
      },
    );
    super.initState();
  }

  Widget _buildText() {
    return Text(
      widget.contentByText!,
      style: widget.popoverModel?.textStyle ??
          TextStyle(
              decoration: TextDecoration.none,
              fontSize: MXTheme.of(context).fontBodyMedium!.size,
              color: MXTheme.of(context).whiteColor),
    );
  }

  Widget? _buildRenderContent() {
    if (widget.contentByText != null) {
      return _buildText();
    } else if (widget.contentByWidget != null) {
      return widget.contentByWidget!;
    }
    return null;
  }

  PopoverPosition _initPopoverPosition() {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;

    final globalPosition = renderBox.localToGlobal(Offset.zero);

    return PopoverPosition(
        width: renderBox.size.width,
        height: renderBox.size.height,
        positionEnum: widget.positionEnum,
        dx: globalPosition.dx,
        dy: globalPosition.dy);
  }

  void _initController() {
    position = _initPopoverPosition();

    controller = PopoverOverLayerController(
        context: context,
        child: _buildRenderContent()!,
        position: position,
        popoverModel: widget.popoverModel);
  }

  Widget _buildChildren() {
    return GestureDetector(
        key: key,
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (controller.isRender) return;
          controller.setPosition(_initPopoverPosition());
          controller.toRenderContent();
        },
        child: IgnorePointer(
          child: widget.triggerWidget,
        ));
  }

  Widget _buildBody() {
    return Container(child: _buildChildren());
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
