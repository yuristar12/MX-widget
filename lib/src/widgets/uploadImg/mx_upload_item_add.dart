import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

typedef OnUploadImgAdd = void Function(List<AssetEntity>?);

class MXUploadItemAdd extends StatelessWidget {
  const MXUploadItemAdd(
      {super.key,
      required this.size,
      required this.controller,
      required this.onUploadImgAdd});

  final MXUploadImgController controller;
  final double size;

  final OnUploadImgAdd onUploadImgAdd;

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        int hasNum = controller.modelList.length;

        final List<AssetEntity>? result = await AssetPicker.pickAssets(
          context,
          pickerConfig: AssetPickerConfig(
            maxAssets: controller.maxNum - hasNum,
            themeColor: MXTheme.of(context).brandPrimaryColor,
          ),
        );

        onUploadImgAdd(result);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: MXTheme.of(context).infoPrimaryColor,
            borderRadius:
                BorderRadius.circular(MXTheme.of(context).radiusMedium)),
        child: const Center(
          child: MXIcon(
            icon: Icons.add,
            iconFontSize: 36,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
