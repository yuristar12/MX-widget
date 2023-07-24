import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXCellGroup extends StatefulWidget {
  const MXCellGroup(
      {super.key,
      this.padding = 16,
      required this.cellList,
      this.type = MXCellGroupType.normal});

  final double padding;

  final MXCellGroupType type;

  final List<MXCellModel> cellList;

  @override
  State<MXCellGroup> createState() => _MXCellGroupState();
}

class _MXCellGroupState extends State<MXCellGroup> {
  List<Widget> _cellList() {
    List<Widget> list = [];

    int length = widget.cellList.length;

    for (var i = 0; i < length; i++) {
      var model = widget.cellList[i];

      if (i == length - 1) {
        model.useBorder = false;
      }

      list.add(MXCell(
        model: model,
        padding: widget.padding,
      ));
    }

    return list;
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
          color: MXTheme.of(context).whiteColor,
          borderRadius: BorderRadius.circular(
              widget.type == MXCellGroupType.cadr
                  ? MXTheme.of(context).radiusMedium
                  : 0)),
      padding: EdgeInsets.symmetric(horizontal: widget.padding),
      child: Column(children: _cellList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
