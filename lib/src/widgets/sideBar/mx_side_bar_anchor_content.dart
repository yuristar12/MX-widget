import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/util/curve_util.dart';

typedef MXSideBarAnchorInitCallback = Function(
    MXSideBarAnchorContentState state);

class MXSideBarAnchorContent extends StatefulWidget {
  const MXSideBarAnchorContent({
    super.key,
    required this.width,
    required this.controller,
    required this.sideBarItemList,
    required this.anchorInitCallback,
  });

  final double width;

  final MXSideBarController controller;

  final List<MXSideBarItemModel> sideBarItemList;

  final MXSideBarAnchorInitCallback anchorInitCallback;

  @override
  State<MXSideBarAnchorContent> createState() => MXSideBarAnchorContentState();
}

class MXSideBarAnchorContentState extends State<MXSideBarAnchorContent> {
  double totalHeight = 0;

  double? contentHeight;

  bool isComputedHeight = false;

  bool scrollListenLock = false;

  late ScrollController scrollController;

  Map<String, GlobalKey> globalKeyMapById = {};

  Map<String, double> contentItemHeightMap = {};

  @override
  void initState() {
    scrollController = ScrollController();

    widget.anchorInitCallback.call(this);

    scrollController.addListener(scrollOnListener);

    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollOnListener);
    super.dispose();
  }

  void scrollOnListener() {
    if (!isComputedHeight) {
      computedHeight();
    }

    if (scrollListenLock) return;

    onScrollLinkSideBarItem();
  }

  /// 滚动时联动sideBar的item
  void onScrollLinkSideBarItem() {
    // 判断是否到了底部
    if (scrollController.offset + contentHeight! == totalHeight) {
      widget.controller.onTabChangeToLast();

      return;
    } else {
      List<double> heightList = [];
      contentItemHeightMap.forEach((key, value) {
        heightList.add(value);
      });

      int lenght = heightList.length;

      double offset = scrollController.offset;

      for (var i = 0; i < lenght; i++) {
        double heightItem = heightList[i];
        if (offset > heightItem) {
          if (i == lenght - 1) {
            widget.controller.onTabChangeToLast();
            return;
          } else if (offset <= heightList[i + 1]) {
            widget.controller.onTabChange(i);
            return;
          }
        }
      }
    }
  }

  /// 当sideBarItem的选中的下标变化时，触发滚动到指定位置
  void onSideBarChangeLinkScrollOffset(String id) {
    computedHeight();

    double? contentHeight = contentItemHeightMap[id];

    if (contentHeight != null) {
      // 需要锁住监听listener的方法
      scrollListenLock = true;
      scrollController
          .animateTo(contentHeight,
              curve: CurveUtil.curve_1(),
              duration: const Duration(milliseconds: 100))
          .then((value) {
        scrollListenLock = false;

        // scrollOnListener();
      });
    }
  }

  /// 计算高度
  void computedHeight() {
    if (contentHeight == null) {
      RenderBox renderBox = context.findRenderObject() as RenderBox;

      contentHeight = renderBox.paintBounds.bottom;
    }

    if (totalHeight == 0) {
      totalHeight = scrollController.position.maxScrollExtent;
    }

    String preKey = '';

    globalKeyMapById.forEach((key, value) {
      if (contentItemHeightMap[key] == null) {
        if (preKey.isEmpty) {
          contentItemHeightMap[key] = 0;
        } else {
          RenderObject? box =
              globalKeyMapById[preKey]?.currentContext?.findRenderObject();

          if (box != null) {
            contentItemHeightMap[key] =
                box.paintBounds.bottom + contentItemHeightMap[preKey]!;
          }
        }
        preKey = key;
      }
    });

    if (totalHeight != 0 && contentHeight != null) {
      isComputedHeight = true;
    }
  }

  Widget _buildAnchorContent() {
    globalKeyMapById.clear();

    List<Widget> children = [];

    int lenght = widget.sideBarItemList.length;

    for (var i = 0; i < lenght; i++) {
      var item = widget.sideBarItemList[i];
      GlobalKey key = GlobalKey();
      globalKeyMapById['${item.id}'] = key;
      Widget child = item.builder!.call(i);
      children.add(SizedBox(
        key: key,
        width: widget.width,
        child: child,
      ));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: _buildAnchorContent(),
    );
  }
}
