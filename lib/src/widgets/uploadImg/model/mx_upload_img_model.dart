import 'dart:io';

enum MXUploadImgSrcType {
  netUrl,
  assetUrl,
}

class MXUploadImgModel {
  MXUploadImgModel({
    this.src,
    this.file,
    required this.srcType,
  });

  final MXUploadImgSrcType srcType;

  final String? src;

  final File? file;
}
