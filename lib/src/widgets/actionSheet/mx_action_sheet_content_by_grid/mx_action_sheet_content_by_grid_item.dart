import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/actionSheet/mx_action_sheet_content_by_list_item.dart';

class MXActionSheetContentByGridItem extends StatelessWidget {
  const MXActionSheetContentByGridItem(
      {super.key, required this.model, required this.optionClick});

  final MXActionSheetListModelByGrid model;

  final MXActionOptionClick optionClick;

  Widget _buildTop(BuildContext context) {
    List<Widget> children = [];
    Widget child;

    if (model.netImgUrl != null) {
      child = MXImage(
        netUrl: model.netImgUrl,
        width: 40,
        height: 40,
      );
    } else {
      child = MXIcon(
        icon: model.icon!,
        iconFontSize: MXTheme.of(context).space24,
        iconColor: MXTheme.of(context).fontUsePrimaryColor,
      );
    }

    children.add(
      Center(
        child: child,
      ),
    );

    if (model.badge != null) {
      children.add(Positioned(right: -3, top: -3, child: model.badge!));
    }

    child = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: MXTheme.of(context).infoColor3,
            borderRadius:
                BorderRadius.circular(MXTheme.of(context).radiusDefault)),
        child: Stack(
          clipBehavior: Clip.none,
          children: children,
        ));

    if (model.disabled) {
      child = Opacity(
        opacity: .4,
        child: child,
      );
    }

    return child;
  }

  Widget _buildLabel(BuildContext context) {
    return MXText(
      isLine: true,
      data: model.label,
      font: MXTheme.of(context).fontInfoLarge,
      textColor: model.disabled
          ? MXTheme.of(context).fontUseDisabledColor
          : MXTheme.of(context).fontUsePrimaryColor,
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    children.add(_buildTop(context));

    children.add(SizedBox(
      height: MXTheme.of(context).space8,
    ));

    children.add(_buildLabel(context));

    return SizedBox(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (model.disabled) return;
        optionClick.call(model);
      },
      child: _buildBody(context),
    );
  }
}
