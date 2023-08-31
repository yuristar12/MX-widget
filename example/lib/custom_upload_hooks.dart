import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:mx_widget/mx_widget.dart';

class CustomUploadHooks extends MXUploadAbstractHooks {
  dynamic ossData;

  String uploadComplatedUrl = '';

  @override
  void onAllUploadByComplated() {
    print('allComplated');
  }

  @override
  Future<bool> onBeforeUpload() async {
    dynamic res = await Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Authorization': 'Bearer 780c47be-3e1b-4007-b63b-b6b3736eb264'},
    )).post(
      'https://mxproduct.meixioa.com/api/files/osssource/common/oss/policy',
      queryParameters: <String, String>{'filepath': 'Web/OA/2023830/'},
    );

    ossData = res.data['data'];

    return true;
  }

  @override
  void onSingleUploadByComplated(Response response) {
    // TODO: implement onSingleUploadByComplated
  }

  @override
  Future<Map<String, dynamic>> onStartUpload(File file) async {
    String url = '${ossData['dir']}${Random().nextInt(100)}.jpg';

    return {
      "OSSAccessKeyId": ossData['accessKeyId'],
      "signature": ossData['signature'],
      "policy": ossData['policy'],
      "key": url,
      "url": "https://mx-admin-oa.oss-cn-hangzhou.aliyuncs.com",
      "success_action_status": 200,
      "file": file
    };
  }

  @override
  void onUploadError(Object? error) {
    // TODO: implement onUploadError
  }

  @override
  String getValueFromResopnse(Response response) {
    FormData data = response.requestOptions.data;

    String prefix = '';

    String suffix = '';

    List fields = data.fields;

    for (var element in fields) {
      if (element.key == 'url') {
        prefix = element.value;
      } else if (element.key == 'key') {
        suffix = element.value;
      }
    }

    return '$prefix/$suffix';
  }
}
