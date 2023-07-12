import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/steps/mx_steps_item.dart';

class MXSteps extends StatefulWidget {
  MXSteps(
      {super.key,
      this.axis = Axis.horizontal,
      required this.controller,
      this.type = MXStepsTypeEnum.number})
      : assert(() {
          if (type == MXStepsTypeEnum.pattern) {
            bool flag =
                controller.stepsItems.any((element) => element.icon != null);

            if (!flag) {
              throw FlutterError('当类型为图形时，请确保每个item的icon不为空');
            }
          }

          return true;
        }());

  /// [controller] 控制器
  final MXStepsController controller;

  /// [type] 类型
  final MXStepsTypeEnum type;

  /// [axis] 排列方向
  final Axis axis;

  @override
  State<MXSteps> createState() => MXStepsState();
}

class MXStepsState extends State<MXSteps> {
  @override
  void initState() {
    MXStepsController controller = widget.controller;

    super.initState();

    controller.setState(this);
  }

  List<Widget> _getItemList(double width) {
    List<Widget> children = [];

    int length = widget.controller.stepsItems.length;

    int activityIndex = widget.controller.activityIndex;

    for (var i = 0; i < length; i++) {
      MXStepsItemModel model = widget.controller.stepsItems[i];

      children.add(MXStepsItem(
          index: i,
          maxLength: length,
          activityIndex: activityIndex,
          type: widget.type,
          axis: widget.axis,
          width: width,
          model: model,
          onTap: widget.controller.onAction != null
              ? () {
                  widget.controller.setActivityIndex(i);
                }
              : null));
    }

    return children;
  }

  void onActivityChange() {
    setState(() {});
  }

  Widget _buildBody(BuildContext context) {
    Widget child;

    if (widget.axis == Axis.vertical) {
      child = LayoutBuilder(builder: (((context, constraints) {
        double width = constraints.biggest.width;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getItemList(width),
        );
      })));
    } else {
      child = LayoutBuilder(builder: ((context, constraints) {
        double avaWidth =
            constraints.biggest.width / widget.controller.stepsItems.length;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: _getItemList(avaWidth),
        );
      }));
    }

    return child;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
