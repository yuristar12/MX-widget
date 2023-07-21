import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/cascader/mx_cascader_content_cell_item.dart';

typedef MXcascaderCellOnTap = void Function(MXCascaderOptions option);

class MXCascaderContentItem extends StatelessWidget {
  const MXCascaderContentItem({
    super.key,
    required this.options,
    required this.width,
    required this.id,
    required this.onCellTap,
  });

  final List<MXCascaderOptions> options;
  final double width;
  final String? id;

  final MXcascaderCellOnTap onCellTap;

  Widget _buildCellItem(MXCascaderOptions item, int index) {
    return MXCascaderContentCellItem(
      model: item,
      isActivity: item.value == id,
      onTap: () {
        onCellTap.call(item);
      },
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: ((context, index) {
        return _buildCellItem(options[index], index);
      }),
      itemCount: options.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: width,
      color: MXTheme.of(context).whiteColor,
      child: _buildBody(),
    );
  }
}
