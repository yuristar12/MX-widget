import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';

const Duration animationDuration = Duration(milliseconds: 300);

class MXSideBarPageContent extends StatefulWidget {
  const MXSideBarPageContent(
      {super.key,
      required this.height,
      required this.activityIndex,
      required this.sideBarList});

  final double height;

  final int activityIndex;

  final List<MXSideBarItemModel> sideBarList;

  @override
  State<MXSideBarPageContent> createState() => _MXSideBarPageContentState();
}

class _MXSideBarPageContentState extends State<MXSideBarPageContent> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildAnimationContent(double width) {
    return AnimatedPositioned(
        curve: CurveUtil.curve_1(),
        duration: animationDuration,
        top: -widget.activityIndex * widget.height,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: _buildSideBarSelectionWrap(width),
        ));
  }

  Widget _buildSideBarSelectionWrap(double width) {
    List<Widget> children = [];

    for (var i = 0; i < widget.sideBarList.length; i++) {
      children.add(SizedBox(
        width: width,
        height: widget.height,
        child: _buildSideBarSelection(i),
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildSideBarSelection(int index) {
    return SingleChildScrollView(
      child: _buildSideBarSelectionChild(index),
    );
  }

  Widget _buildSideBarSelectionChild(int index) {
    return widget.sideBarList[index].builder!.call(index);
  }

  Widget _buildBody() {
    return LayoutBuilder(builder: ((context, constraints) {
      return SizedBox(
          height: widget.height,
          child: Stack(
            children: [_buildAnimationContent(constraints.maxWidth)],
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
