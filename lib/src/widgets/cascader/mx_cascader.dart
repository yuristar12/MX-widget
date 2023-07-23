import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';
import 'package:mx_widget/src/widgets/cascader/mx_cascader_anchor_by_vertical.dart';
import 'package:mx_widget/src/widgets/cascader/mx_cascader_content_item.dart';

typedef GetMXCascaderState = Function(MXCascaderState state);

class MXCascader extends StatefulWidget {
  const MXCascader({
    super.key,
    required this.controller,
    required this.getMXCascaderState,
  });

  final MXCascaderController controller;

  final GetMXCascaderState getMXCascaderState;

  @override
  State<MXCascader> createState() => MXCascaderState();
}

class MXCascaderState extends State<MXCascader> {
  @override
  void initState() {
    widget.getMXCascaderState.call(this);
    super.initState();
  }

  void onParamsUpdate() {
    setState(() {});
  }

  Widget _buildAnchor() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: MXTheme.of(context).infoPrimaryColor))),
      child: MXCascaderAnchorByVertical(
          controller: widget.controller.stepsController),
    );
  }

  Widget _buildOptionsContent() {
    return LayoutBuilder(builder: ((context, constraints) {
      double width = constraints.biggest.width;

      return Container(
        color: MXTheme.of(context).whiteColor,
        height: 320,
        child: Stack(
          children: [
            AnimatedPositioned(
              top: 0,
              left: -widget.controller.activityIndex * width,
              duration: const Duration(milliseconds: 300),
              curve: CurveUtil.curve_1(),
              child: _buildOptionsContentWrap(width),
            )
          ],
        ),
      );
    }));
  }

  Widget _buildOptionsContentWrap(double width) {
    List<Widget> children = [];

    widget.controller.values?.forEach((key, value) {
      children.add(MXCascaderContentItem(
        options: value,
        width: width,
        id: widget.controller.id,
        onCellTap: (option) {
          widget.controller.onCellTap(option);
        },
      ));
    });

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: children,
    );
  }

  Widget _buildBody() {
    List<Widget> children = [];

    children.add(_buildAnchor());

    children.add(_buildOptionsContent());
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
