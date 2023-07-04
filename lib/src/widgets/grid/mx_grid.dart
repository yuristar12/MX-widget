import 'package:flutter/widgets.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/grid/mx_grid_item.dart';

double paddingSpace = MXTheme.getThemeConfig().space8;

/// -----------------------------------------------------------------gird宫格组件
/// [column] 一行展示几个item的数量,当为0时item的大小为固定大小同时容器出现滚动条
/// [useBorder] item是否开启border
/// [theme] norma与card 圆角
/// [size] 每个item的大小
/// [itemList] 需要渲染的item的列表
/// [space] 间距 竖轴与横轴之间的间距默认为0
/// [gridItemAxis] item的排列方式默认是垂直布局
/// [mxGirdItemClickCallback] item的点击事件

class MXGrid extends StatelessWidget {
  const MXGrid(
      {super.key,
      this.space = 0,
      this.column = 4,
      required this.itemList,
      this.useBorder = false,
      this.theme = MXGirdThemeEnum.norma,
      this.size = MXGirdSizeEnum.medium,
      this.gridItemAxis = Axis.vertical,
      this.margin,
      this.mxGirdItemClickCallback});

  /// [column] 一行展示几个item的数量,当为0时item的大小为固定大小同时容器出现滚动条
  final int column;

  /// [useBorder] item是否开启border
  final bool useBorder;

  /// [theme] norma与card 圆角
  final MXGirdThemeEnum theme;

  /// [size] 每个item的大小
  final MXGirdSizeEnum size;

  /// [itemList] 需要渲染的item的列表
  final List<MXGridItemModel> itemList;

  /// [space] 间距 竖轴与横轴之间的间距默认为0
  final double space;

  /// [gridItemAxis] item的排列方式默认是垂直布局
  final Axis gridItemAxis;

  /// [mxGirdItemClickCallback] item的点击事件
  final MXGirdItemClickCallback? mxGirdItemClickCallback;

  /// [margin] 容器外边距，只有当类型为才生效
  final double? margin;

  List<Widget> _getItems() {
    int count = itemList.length;
    bool useWidth = column == 0;
    List<Widget> list = [];
    int bottomLimit = 0;

    if (!useBorder || itemList.length / column < 1 || useWidth) {
      bottomLimit = 0;
    } else if (itemList.length / column > 1) {
      bottomLimit = (column * (itemList.length ~/ column));
    }

    for (var i = 0; i < count; i++) {
      bool useRightBorder = false;

      if (useBorder) {
        if (i == 0) {
          useRightBorder = true;
        } else {
          if (useWidth) {
            useRightBorder = i < (count - 1);
          } else {
            useRightBorder = ((i + 1) % column) != 0;
          }
        }
      }

      bool useBottomBorder = useBorder
          ? bottomLimit == 0
              ? false
              : i / bottomLimit < 1
          : false;

      list.add(MXGirdItem(
        useBottomBorder: useBottomBorder,
        useRightBorder: useRightBorder,
        size: size,
        model: itemList[i],
        width: useWidth ? _getBaseSize() : null,
        useBorder: useBorder,
        gridItemAxis: gridItemAxis,
        onClick: () {
          mxGirdItemClickCallback?.call(i);
        },
      ));
    }

    return list;
  }

  double _getBaseSize() {
    switch (size) {
      case MXGirdSizeEnum.mini:
        return gridItemAxis == Axis.horizontal ? 32 : 82;
      case MXGirdSizeEnum.medium:
        return gridItemAxis == Axis.horizontal ? 40 : 94;
      case MXGirdSizeEnum.large:
        return gridItemAxis == Axis.horizontal ? 48 : 104;
    }
  }

  Widget _buildRowBody(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext content, BoxConstraints constraints) {
      double width = double.parse(constraints.biggest.width.toStringAsFixed(1));

      return Container(
          width: width,
          color: MXTheme.of(content).whiteColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getItems(),
            ),
          ));
    });
  }

  Widget _buildGridBody(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext content, BoxConstraints constraints) {
      /// 用于计算高度，如果父widget是column，会导致报错，所以需要计算高度
      double height = 0;
      double width = double.parse(constraints.biggest.width.toStringAsFixed(1));

      if (theme == MXGirdThemeEnum.card) {
        width -= (margin ?? (paddingSpace)) * 2;
      }

      double avaWidth = width / column;

      bool isLine = true;

      int columns = 1;

      if (column != 0) {
        if (itemList.length > column) {
          isLine = false;
          columns = (itemList.length / column).ceilToDouble().toInt();
          height += (avaWidth) * columns;

          /// 这里需要加上border的高度
          height += (columns - 1) * 1;
        } else {
          if (gridItemAxis == Axis.horizontal) {
            height += _getBaseSize() + paddingSpace * 4;
          } else {
            height += _getBaseSize() + paddingSpace;
          }
        }
      }

      return Container(
        width: width,
        height: height,
        margin: theme == MXGirdThemeEnum.card
            ? EdgeInsets.all(margin ?? paddingSpace)
            : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(theme != MXGirdThemeEnum.card
              ? 0
              : MXTheme.of(content).radiusMedium),
          color: MXTheme.of(content).whiteColor,
        ),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: space,
          mainAxisSpacing: space,
          crossAxisCount: column,
          childAspectRatio: isLine ? avaWidth / height : 1,
          children: _getItems(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (column == 0) {
      return _buildRowBody(context);
    } else {
      return _buildGridBody(context);
    }
  }
}
