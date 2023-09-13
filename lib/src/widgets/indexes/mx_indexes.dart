import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/indexes/mx_indexes_anchor.dart';
import 'package:mx_widget/src/widgets/indexes/mx_indexes_content.dart';
import 'package:mx_widget/src/widgets/indexes/model/mx_indexes_anchor_controller.dart';
import 'package:mx_widget/src/widgets/indexes/model/mx_indexes_globalkey_and_index_model.dart';

class MXIndexes extends StatefulWidget {
  const MXIndexes({super.key, required this.height, required this.controller});

  final double height;

  final MXIndexesController controller;

  @override
  State<MXIndexes> createState() => _MXIndexesState();
}

class _MXIndexesState extends State<MXIndexes> {
  List<MXIndexesGlobalkeyAndIndex> keysList = [];

  late ScrollController scrollController;

  late MXIndexesAnchorController anchorController;

  @override
  void initState() {
    scrollController = ScrollController();
    anchorController = MXIndexesAnchorController();

    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    children.add(MXIndexesContent(
      controller: widget.controller,
      scrollController: scrollController,
      addGlobalKey: _addKeyItem,
      onUpdateFloating: (modelItem) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          int index = keysList.indexWhere((element) {
            return element.index == modelItem.index;
          });

          if (index > -1) {
            widget.controller.setValue(keysList[index]);
            anchorController.state?.updateLayout();
          }
        });
      },
    ));

    children.add(MXIndexesAnchor(
      controller: widget.controller,
      anchorController: anchorController,
    ));
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.centerRight,
        children: children,
      ),
    );
  }

  void _addKeyItem(MXIndexesGlobalkeyAndIndex item) {
    keysList.add(item);

    if (keysList.length == 1) {
      widget.controller.setValue(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    keysList.clear();

    return _buildBody(context);
  }
}
