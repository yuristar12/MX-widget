import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_abstract_hooks.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_item_controller.dart';
import 'package:mx_widget/src/widgets/uploadImg/mx_upload_item.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum UploadType {
  wait,
  start,
  error,
  success,
}

typedef MXUploadImgModelUploadComplated = void Function(Response response);

class MXUploadImgItemModel {
  MXUploadImgItemModel(
      {this.file,
      this.netUrl,
      this.entity,
      required this.actionUrl,
      this.type = UploadType.wait,
      this.uploadComplated,
      this.hooks,
      this.progressNum = 0}) {
    if (type == UploadType.wait) {
      controller = MXUploadItemController(
          hooks: hooks,
          onError: _onError,
          actionUrl: actionUrl,
          onSuccess: _onSuccess,
          onUploading: _onUploading);
    }
  }

  final MXUploadAbstractHooks? hooks;

  final File? file;

  String? netUrl;

  UploadType type;

  double progressNum;

  final AssetEntity? entity;

  final String actionUrl;

  MXUploadItemState? state;

  MXUploadItemController? controller;

  MXUploadImgModelUploadComplated? uploadComplated;

  void setState(MXUploadItemState state) {
    this.state = state;
  }

  void toStartUpload() async {
    if (type == UploadType.wait) {
      type = UploadType.start;

      controller!.onStartUpload(file!);
    }
  }

  void _onError() {
    type = UploadType.error;
    state?.onUpdateLayout();
  }

  void _onSuccess(Response response) {
    type = UploadType.success;
    state?.onUpdateLayout();
    uploadComplated?.call(response);
  }

  void _onUploading(double progress) {
    progressNum = progress;
    state?.onUpdateLayout();
  }
}
