import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/indexes/model/mx_indexes_globalkey_and_index_model.dart';

typedef MXIndexesContentItemBuilder = Widget Function<T>(T params);
typedef MXIndexesHeaderBuilder = Widget Function(MXIndexesModel params);

class MXIndexesController {
  MXIndexesController(
      {this.itemClick,
      this.headerBuilder,
      required this.model,
      this.headerHeight = 40,
      required this.contentItemBuilder});

  final double headerHeight;

  final List<MXIndexesModel> model;

  final MXIndexesItemClick? itemClick;

  final MXIndexesHeaderBuilder? headerBuilder;

  final MXIndexesContentItemBuilder contentItemBuilder;

  MXIndexesGlobalkeyAndIndex? value;

  void setValue(MXIndexesGlobalkeyAndIndex value) {
    this.value = value;
  }
}
