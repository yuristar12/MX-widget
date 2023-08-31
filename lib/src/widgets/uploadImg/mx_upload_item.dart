import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/uploadImg/mx_upload_mask.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_img_model.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_img_item_model.dart';
import 'package:mx_widget/src/widgets/uploadImg/mx_upload_mask_by_error.dart';

class MXUploadItem extends StatefulWidget {
  const MXUploadItem(
      {super.key,
      required this.model,
      required this.size,
      required this.onDeleteUpload});

  final MXUploadImgItemModel model;

  final double size;

  final VoidCallback onDeleteUpload;

  @override
  State<MXUploadItem> createState() => MXUploadItemState();
}

class MXUploadItemState extends State<MXUploadItem> {
  @override
  void didUpdateWidget(covariant MXUploadItem oldWidget) {
    if (oldWidget.model != widget.model) {
      widget.model.setState(this);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.model.setState(this);
    super.initState();
  }

  void onUpdateLayout() {
    try {
      setState(() {});
    } catch (e) {
      widget.model.setState(this);
    }
  }

  // 优先获取本地地址，如果没有再获取网络地址
  MXUploadImgModel get imgModel {
    return widget.model.file != null
        ? MXUploadImgModel(
            file: widget.model.file, srcType: MXUploadImgSrcType.assetUrl)
        : MXUploadImgModel(
            src: widget.model.netUrl!, srcType: MXUploadImgSrcType.netUrl);
  }

  Widget _buildImg() {
    MXUploadImgModel privateImgModel = imgModel;

    return privateImgModel.srcType == MXUploadImgSrcType.assetUrl
        ? MXImage(
            width: widget.size,
            height: widget.size,
            file: privateImgModel.file,
          )
        : MXImage(
            width: widget.size,
            height: widget.size,
            netUrl: privateImgModel.src,
          );
  }

  Widget _buildCloseIcon() {
    MXThemeConfig config = MXTheme.of(context);

    return Positioned(
        top: 0,
        right: 0,
        child: GestureDetector(
            onTap: () {
              widget.onDeleteUpload();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: config.mask2,
                  borderRadius:
                      BorderRadius.circular(MXTheme.of(context).radiusSmall)),
              child: MXIcon(
                iconFontSize: 12,
                icon: Icons.close,
                iconColor: config.whiteColor,
              ),
            )));
  }

  Widget? _buildMosk() {
    Widget? child;

    switch (widget.model.type) {
      case UploadType.error:
        child = const MXUploadMaskByError();
        break;

      case UploadType.start:
        child = MXUploadMask(
          model: widget.model,
        );
        break;
      default:
        child = null;
    }

    return child;
  }

  Widget _buildBody() {
    List<Widget> children = [];

    children.add(_buildImg());

    Widget? mock = _buildMosk();

    if (mock != null) {
      children.add(mock);
    }

    if (widget.model.type != UploadType.start) {
      children.add(_buildCloseIcon());
    }

    return Container(
      width: widget.size,
      height: widget.size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: MXTheme.of(context).infoPrimaryColor,
          borderRadius:
              BorderRadius.circular(MXTheme.of(context).radiusMedium)),
      child: Stack(
        alignment: Alignment.center,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
