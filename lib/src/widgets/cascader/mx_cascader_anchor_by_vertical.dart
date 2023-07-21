import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXCascaderAnchorByVertical extends StatefulWidget {
  const MXCascaderAnchorByVertical({super.key, required this.controller});

  final MXStepsController controller;

  @override
  State<MXCascaderAnchorByVertical> createState() =>
      _MXCascaderAnchorByVerticalState();
}

class _MXCascaderAnchorByVerticalState
    extends State<MXCascaderAnchorByVertical> {
  @override
  void didUpdateWidget(covariant MXCascaderAnchorByVertical oldWidget) {
    if (oldWidget.controller != widget.controller) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MXTheme.of(context).space8),
      child: MXSteps(
        axis: Axis.vertical,
        type: MXStepsTypeEnum.simple,
        controller: widget.controller,
      ),
    );
  }
}
