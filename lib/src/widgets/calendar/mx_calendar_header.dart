import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';

class MXCalendarHeader extends StatelessWidget {
  const MXCalendarHeader({
    super.key,
    required this.headerList,
  });

  final List<String> headerList;

  Widget _buildWeekItem(
    String str,
    BuildContext context,
  ) {
    return SizedBox(
      child: Center(
        child: MXText(
          data: str,
          style: TextStyle(
              color: MXTheme.of(context).fontUseSecondColors,
              fontSize: MXTheme.of(context).fontBodySmall!.size),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<String> list = headerList;

    List<Widget> children = [];

    return LayoutBuilder(
      builder: (BuildContext content, BoxConstraints constraints) {
        double width = constraints.biggest.width;

        double size = width / list.length;

        for (var i = 0; i < list.length; i++) {
          children.add(SizedBox(
            width: size,
            height: size,
            child: _buildWeekItem(list[i], context),
          ));
        }

        return Wrap(
          children: children,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(context),
    );
  }
}
