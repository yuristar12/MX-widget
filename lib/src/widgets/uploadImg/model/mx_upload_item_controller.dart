import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_abstract_hooks.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_img_item_model.dart';

typedef OnUploadingCallback = void Function(double progress);

class MXUploadItemController {
  MXUploadItemController({
    this.hooks,
    required this.onError,
    required this.actionUrl,
    required this.onSuccess,
    required this.onUploading,
  });

  final MXUploadAbstractHooks? hooks;

  final MXUploadImgModelUploadComplated onSuccess;
  final VoidCallback onError;

  final OnUploadingCallback onUploading;

  final String actionUrl;

  void onStartUpload(File file) async {
    try {
      await hooks?.onBeforeUpload();

      final Map<String, dynamic>? paramsMap = await hooks?.onStartUpload(file);

      if (paramsMap != null) {
        paramsMap['file'] = await MultipartFile.fromFile(file.path);
      }

      FormData formData = FormData.fromMap(paramsMap ?? {});

      Dio().post(
        actionUrl,
        data: formData,
        onSendProgress: (count, total) {
          onUploading((count / total) * 100);
        },
      ).then((resoponse) {
        onSuccess(resoponse);
        hooks?.onSingleUploadByComplated(resoponse);
      }).onError((error, stackTrace) {
        onError();
        hooks?.onUploadError(error);
      });
    } catch (e) {
      onError();
    }
  }
}
