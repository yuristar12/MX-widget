import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_img_item_model.dart';

class MXUploadMask extends StatelessWidget {
  const MXUploadMask({
    super.key,
    required this.model,
  });

  final MXUploadImgItemModel model;

  Widget _buildLoading(BuildContext context) {
    return MXCircleLoading(
      circleColor: MXTheme.of(context).whiteColor,
    );
  }

  Widget _buildUploadProgressNum(BuildContext context) {
    return MXText(
      data: '${model.progressNum.toStringAsFixed(2)}%',
      isNumber: true,
      textColor: MXTheme.of(context).whiteColor,
      font: MXTheme.of(context).fontBodySmall,
    );
  }

  Widget _buildInfo(BuildContext context) {
    List<Widget> children = [];

    children.add(_buildLoading(context));

    children.add(SizedBox(
      height: MXTheme.of(context).space8,
    ));

    children.add(_buildUploadProgressNum(context));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        color: MXTheme.of(context).mask1, child: _buildInfo(context));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(child: _buildBody(context));
  }
}
