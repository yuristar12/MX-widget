import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/indexes/model/mx_indexes_controller.dart';
import 'package:mx_widget/src/widgets/indexes/model/mx_indexes_globalkey_and_index_model.dart';
import 'package:mx_widget/src/widgets/indexes/model/mx_indexes_model.dart';
import 'package:mx_widget/src/widgets/indexes/mx_indexes_content_item.dart';
import 'package:mx_widget/src/widgets/indexes/mx_indexes_header.dart';

typedef MXIndexesAddGlobalKey = void Function(
    MXIndexesGlobalkeyAndIndex keyItem);

class MXIndexesContent extends StatelessWidget {
  const MXIndexesContent({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.addGlobalKey,
  });

  final MXIndexesController controller;

  final ScrollController scrollController;

  final MXIndexesAddGlobalKey addGlobalKey;

  Widget _buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: _buildSlivers(context),
      controller: scrollController,
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    return controller.model.map((e) {
      GlobalKey key = GlobalKey();
      MXIndexesGlobalkeyAndIndex keyAndIndex =
          MXIndexesGlobalkeyAndIndex(globalKey: key, index: e.index);

      addGlobalKey.call(keyAndIndex);

      return _buildScrollContent(e, key);
    }).toList();
  }

  Widget _buildScrollContent(
    MXIndexesModel modelItem,
    GlobalKey key,
  ) {
    return SliverMainAxisGroup(key: key, slivers: [
      SliverPersistentHeader(
          pinned: true,
          delegate: MXIndexesHeader(
            modelItem: modelItem,
            controller: controller,
          )),
      SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => MXIndexesContentItem(
                    controller: controller,
                    itemParams: modelItem.children[index],
                  ),
              childCount: modelItem.children.length))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
