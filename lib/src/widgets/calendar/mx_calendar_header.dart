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
        child: Text(
          str,
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

    for (var i = 0; i < list.length; i++) {
      children.add(_buildWeekItem(list[i], context));
    }

    return LayoutBuilder(
      builder: (BuildContext content, BoxConstraints constraints) {
        double width = constraints.biggest.width;

        double height = width / list.length;
        return Container(
          width: width,
          height: height,
          child: GridView.count(
            crossAxisCount: list.length,
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: _buildBody(context),
    );
  }
}
