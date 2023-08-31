import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_hooks.dart';
import 'package:mx_widget/src/widgets/uploadImg/model/mx_upload_img_item_model.dart';

class MXUploadImgController {
  MXUploadImgController({
    required this.actionUrl,
    this.maxNum = 1,
    this.hooks,
    this.defaultValue,
    this.uploadType = MXUploadImgType.single,
  }) : assert(() {
          if (defaultValue != null && uploadType == MXUploadImgType.single) {
            if (defaultValue.length > 1) {
              throw FlutterError('类型为单选时，上传数量不能超过1！');
            }
          }
          return true;
        }()) {
    if (defaultValue != null) {
      value = [];

      for (var element in defaultValue!) {
        if (uploadType == MXUploadImgType.multiply &&
            defaultValue!.length > maxNum) {
          break;
        }
        value?.add(element);
      }
    }
    _init();
  }

  // 上传上限
  final int maxNum;

  List<String>? defaultValue;
  // 类型多选/单选
  MXUploadImgType uploadType;
  // 用于回显图片的链接
  static List<String>? value;

  final String actionUrl;

  MXUploadAbstractHooks? hooks;

  // modellist用于widget循环渲染子widget
  List<MXUploadImgItemModel> modelList = [];
  // 初始化项目
  _init() {
    hooks ?? MXUploadHooks();

    if (value != null && value!.isNotEmpty) {
      value?.forEach((element) {
        modelList.add(MXUploadImgItemModel(
            actionUrl: actionUrl,
            netUrl: element,
            type: UploadType.success,
            progressNum: 100));
      });
    }
  }

  Future<bool> onAddUpload(List<AssetEntity>? list) async {
    if (list != null) {
      for (var i = 0; i < list.length; i++) {
        if (modelList.length <= maxNum) {
          AssetEntity item = list[i];

          File? file = await item.file;

          if (file != null) {
            modelList.add(MXUploadImgItemModel(
                actionUrl: actionUrl,
                entity: item,
                file: file,
                hooks: hooks,
                type: UploadType.wait,
                uploadComplated: onUploadSingleComplated,
                progressNum: 0));
          }
        }
      }
    }

    return true;
  }

// 开始全部上传
  void toStartAllUnUpload() {
    for (var i = 0; i < modelList.length; i++) {
      MXUploadImgItemModel item = modelList[i];

      if (item.type == UploadType.wait) {
        item.toStartUpload();
      }
    }
  }

  // 删除方法
  void onDeleteUploadItem(int index) {
    modelList.removeAt(index);
  }

  // 当单个文件上传完成执行的回调
  void onUploadSingleComplated(Response response) {
    String? responseValue = hooks?.getValueFromResopnse(response);

    if (responseValue != null && responseValue.isNotEmpty) {
      print(responseValue);
      value?.add(responseValue);
    }

    bool isAllComplated = modelList.every((element) {
      return element.type != UploadType.start;
    });

    if (isAllComplated) {
      hooks?.onAllUploadByComplated();
    }
  }
}
