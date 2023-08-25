import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/indexes/model/mx_indexes_controller.dart';

class MXIndexesContentItem extends StatelessWidget {
  const MXIndexesContentItem(
      {super.key, required this.itemParams, required this.controller});

  final dynamic itemParams;

  final MXIndexesController controller;

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: controller.contentItemBuilder.call(itemParams),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
