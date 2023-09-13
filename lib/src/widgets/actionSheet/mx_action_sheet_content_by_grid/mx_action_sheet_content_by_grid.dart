import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/actionSheet/mx_action_sheet_content_by_grid/mx_action_sheet_content_by_grid_item.dart';
import 'package:mx_widget/src/widgets/actionSheet/mx_action_sheet_content_by_grid/mx_action_sheet_content_by_grid_nav_bottom.dart';
import 'package:mx_widget/src/widgets/actionSheet/mx_action_sheet_footer_button.dart';

class MXActionSheetContentByGrid extends StatefulWidget {
  const MXActionSheetContentByGrid({
    super.key,
    required this.modelList,
    required this.closeText,
    this.onClose,
    this.onConfirm,
  });

  final List<MXActionSheetListModelByGrid> modelList;

  final String closeText;

  final VoidCallback? onClose;

  final MXActionSheetConfirm? onConfirm;

  @override
  State<MXActionSheetContentByGrid> createState() =>
      _MXActionSheetContentByGridState();
}

class _MXActionSheetContentByGridState
    extends State<MXActionSheetContentByGrid> {
  late PageController pageController;

  int currentPage = 0;

  @override
  void initState() {
    pageController = PageController();

    super.initState();
  }

  Widget _buildPageSheet(List<MXActionSheetListModelByGrid> list) {
    return GridView.count(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 1,
      children: <Widget>[
        ...list.map((model) => MXActionSheetContentByGridItem(
              model: model,
              optionClick: onOptionsClick,
            ))
      ],
    );
  }

  void onOptionsClick(MXActionSheetListModel model) {
    widget.onConfirm?.call(model);
  }

  Widget _buildPageView() {
    int count = (widget.modelList.length / 8).ceil();

    List<Widget> children = [];

    for (var i = 0; i < count; i++) {
      if (i == count - 1) {
        children.add(_buildPageSheet(
            widget.modelList.sublist(i * 8, widget.modelList.length)));
      } else {
        children.add(_buildPageSheet(
            widget.modelList.sublist(i == 0 ? i : i * 8, (i + 1) * 8)));
      }
    }

    return PageView(
      controller: pageController,
      children: children,
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
    );
  }

  Widget _buildContent() {
    return LayoutBuilder(builder: (context, constraints) {
      Widget child;
      double size = constraints.maxWidth / 4;

      if (widget.modelList.length > 8) {
        child = _buildPageView();
      } else {
        child = _buildPageSheet(widget.modelList);
      }

      return SizedBox(
        height: size * 2,
        child: child,
      );
    });
  }

  Widget _buildBody() {
    List<Widget> children = [];

    children.add(_buildContent());

// 底部nav导航

    if (widget.modelList.length > 8) {
      int count = (widget.modelList.length / 8).ceil();
      children.add(MXActionSheetContentByGridNavBottom(
          activityIndex: currentPage, totalNum: count));
    }

// 取消按钮
    children.add(Container(
      decoration: BoxDecoration(
          border: Border(
              top:
                  BorderSide(width: 1, color: MXTheme.of(context).infoColor1))),
      child: MXActionSheetFooterButton(
        closeText: widget.closeText,
        onClose: () {
          widget.onClose?.call();
        },
      ),
    ));

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
