import 'dart:io';

import 'package:dio/dio.dart';

abstract class MXUploadAbstractHooks {
  // 开始上传前的操作
  Future<bool> onBeforeUpload();

  // 开始上传时
  Future<Map<String, dynamic>> onStartUpload(File file);

  // 当单个文件上传完成的回调事件
  void onSingleUploadByComplated(Response<dynamic> response);

  // 所有文件上传完成的事件
  void onAllUploadByComplated();

  // 上传出错的事件
  void onUploadError(Object? error);

  // 从resopone中获取上传后的值

  String getValueFromResopnse(Response response);
}
