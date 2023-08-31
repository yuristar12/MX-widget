import 'dart:io';
import 'package:dio/src/response.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_abstract_hooks.dart';

class MXUploadHooks extends MXUploadAbstractHooks {
  @override
  void onAllUploadByComplated() {}

  @override
  Future<bool> onBeforeUpload() async {
    return true;
  }

  @override
  void onSingleUploadByComplated(Response response) {}

  @override
  Future<Map<String, dynamic>> onStartUpload(File file) async {
    return {};
  }

  @override
  void onUploadError(Object? error) {}

  @override
  String getValueFromResopnse(Response response) {
    return '';
  }
}
