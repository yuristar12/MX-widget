import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/indexes/model/mx_indexes_anchor_controller.dart';
import 'package:mx_widget/src/widgets/indexes/model/mx_indexes_globalkey_and_index_model.dart';

class MXIndexesAnchor extends StatefulWidget {
  const MXIndexesAnchor(
      {super.key, required this.controller, required this.anchorController});

  final MXIndexesController controller;

  final MXIndexesAnchorController anchorController;

  @override
  State<MXIndexesAnchor> createState() => MXIndexesAnchorState();
}

class MXIndexesAnchorState extends State<MXIndexesAnchor> {
  @override
  void initState() {
    widget.anchorController.setState(this);
    super.initState();
  }

  void updateLayout() {
    setState(() {});
  }

  List<Widget> _getAnchorList() {
    List<Widget> children = [];

    List<MXIndexesModel> modelList = widget.controller.model;

    MXIndexesGlobalkeyAndIndex? value = widget.controller.value;

    for (var element in modelList) {
      bool isActivity = false;

      if (value != null && value.index == element.index) isActivity = true;

      children.add(_buildAnchorItem(isActivity, element.index));
    }

    return children;
  }

  Widget _buildAnchorItem(bool isActivity, String index) {
    MXThemeConfig mxThemeConfig = MXTheme.of(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 25,
        height: 25,
        margin: EdgeInsets.only(top: mxThemeConfig.space4),
        decoration: BoxDecoration(
            color:
                isActivity ? mxThemeConfig.brandClickColor : Colors.transparent,
            borderRadius:
                BorderRadius.all(Radius.circular(mxThemeConfig.radiusRound))),
        child: Center(
          child: MXText(
            data: index,
            font: mxThemeConfig.fontInfoLarge,
            textColor: isActivity
                ? mxThemeConfig.whiteColor
                : mxThemeConfig.fontUsePrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _getAnchorList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(right: 16, child: _buildBody());
  }
}
