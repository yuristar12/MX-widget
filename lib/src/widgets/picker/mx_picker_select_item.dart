import 'package:flutter/cupertino.dart';
import 'package:mx_widget/src/export.dart';

import 'mx_picker_select_style.dart';

class MXPickerSelectItem extends StatefulWidget {
  const MXPickerSelectItem(
      {super.key,
      required this.index,
      required this.fixedExtentScrollController,
      required this.selectColumnCount,
      required this.text,
      required this.itemHeight});

  final String text;

  final double itemHeight;

  final int index;

  final int selectColumnCount;

  final FixedExtentScrollController fixedExtentScrollController;

  @override
  State<MXPickerSelectItem> createState() => _MXPickerSelectItemState();
}

class _MXPickerSelectItemState extends State<MXPickerSelectItem> {
  late MXPickerSelectStyle mxPickerSelectStyle;
  controllerListen() {
    setState(() {});
  }

  @override
  void initState() {
    widget.fixedExtentScrollController.addListener(controllerListen);
    mxPickerSelectStyle = MXPickerSelectStyle();

    super.initState();
  }

  @override
  void dispose() {
    widget.fixedExtentScrollController.removeListener(controllerListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FixedExtentScrollController fixedExtentScrollController =
        widget.fixedExtentScrollController;

    double distance =
        (fixedExtentScrollController.offset / widget.itemHeight - widget.index)
            .abs()
            .toDouble();

    return Text(
      widget.text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: MXTheme.of(context).fontBodyMedium!.size,
        fontWeight: mxPickerSelectStyle.selectStyleByFontWeight(distance),
        color: mxPickerSelectStyle.selectStyleByFontColor(context, distance),
      ),
    );
  }
}
