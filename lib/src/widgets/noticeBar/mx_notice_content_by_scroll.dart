import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/marquee/mx_marquee_by_horizontal.dart';
import 'package:mx_widget/src/widgets/marquee/mx_marquee_by_vertical.dart';

class MXNoticeContentByScroll extends StatefulWidget {
  const MXNoticeContentByScroll({
    super.key,
    required this.width,
    this.content,
    this.contentList,
    required this.scrollDirection,
  });

  final double width;
  final String? content;
  final List<String>? contentList;
  final MXNoticeBarScrollDirectionEnum scrollDirection;

  @override
  State<MXNoticeContentByScroll> createState() =>
      _MXNoticeContentByScrollState();
}

class _MXNoticeContentByScrollState extends State<MXNoticeContentByScroll> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.scrollDirection == MXNoticeBarScrollDirectionEnum.horizontal) {
        (key.currentState as MXMarqueeByHorizontalState).startMarquee();
      } else if (widget.scrollDirection ==
          MXNoticeBarScrollDirectionEnum.vertical) {
        (key.currentState as MXMarqueeByVerticalState).startTimer();
      }
    });

    super.initState();
  }

  final GlobalKey key = GlobalKey();

  List<Widget> _getVerticalList() {
    List<Widget> children = [];

    widget.contentList!.forEach((element) {
      children.add(MXText(
        isLine: true,
        data: element,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        font: MXTheme.of(context).fontBodySmall,
      ));
    });

    return children;
  }

  Widget _buildBody() {
    if (widget.scrollDirection == MXNoticeBarScrollDirectionEnum.horizontal) {
      return MXMarqueeByHorizontal(
          key: key,
          width: widget.width,
          child: MXText(
            isLine: true,
            data: widget.content,
            font: MXTheme.of(context).fontBodySmall,
          ));
    } else {
      List<Widget> children = _getVerticalList();
      return SizedBox(
          height: 24,
          child: Center(
            child: MXMarqueeByVertical(
              key: key,
              children: children,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
