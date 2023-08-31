import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/uploadImg/mx_upload_item.dart';
import 'package:mx_widget/src/widgets/uploadImg/mx_upload_item_add.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MXUploadImg extends StatefulWidget {
  const MXUploadImg(
      {super.key, required this.controller, this.useTitle = true});

  final MXUploadImgController controller;

  final bool useTitle;

  @override
  State<MXUploadImg> createState() => _MXUploadImgState();
}

class _MXUploadImgState extends State<MXUploadImg> {
  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: MXTheme.of(context).space8),
      child: MXText(
        data: widget.controller.uploadType == MXUploadImgType.multiply
            ? "多选上传"
            : '单选上传',
        textColor: MXTheme.of(context).fontUsePrimaryColor,
        font: MXTheme.of(context).fontBodyMedium,
        isLine: true,
      ),
    );
  }

  Widget _buildContent() {
    return LayoutBuilder(
        builder: ((BuildContext context, BoxConstraints constraints) {
      double size = (constraints.biggest.width / 4) - 6;

      List<Widget> children = [];

      for (int i = 0; i < widget.controller.modelList.length; i++) {
        var model = widget.controller.modelList[i];

        children.add(MXUploadItem(
          model: model,
          size: size,
          onDeleteUpload: () {
            widget.controller.onDeleteUploadItem(i);
            setState(() {});
          },
        ));
      }

      if (children.length < widget.controller.maxNum) {
        children.add(MXUploadItemAdd(
          size: size,
          controller: widget.controller,
          onUploadImgAdd: onAddUpload,
        ));
      }

      return SizedBox(
        width: constraints.maxWidth,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 8,
          runSpacing: 16,
          children: children,
        ),
      );
    }));
  }

  void onAddUpload(List<AssetEntity>? list) {
    widget.controller.onAddUpload(list).then((value) {
      setState(() {
        widget.controller.toStartAllUnUpload();
      });
    });
  }

  Widget _buildBody() {
    MXThemeConfig mxThemeConfig = MXTheme.of(context);

    List<Widget> children = [];

    if (widget.useTitle) {
      children.add(_buildTitle());
    }

    children.add(_buildContent());

    return Container(
      padding: EdgeInsets.only(
          top: mxThemeConfig.space12,
          left: mxThemeConfig.space16,
          right: mxThemeConfig.space16),
      decoration: BoxDecoration(
        color: mxThemeConfig.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
