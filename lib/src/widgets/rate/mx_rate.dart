import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/rate/mx_rate_item.dart';

///-------------------------------------------------------------------rate评分组件
/// 用于对某行为/事物进行打分。
/// [initValue] 初始化的值
/// [useHalf] 是否开启半分评价
/// [count] 评分总数/默认总分为5分
/// [space] 评分之间的间距/默认间距为8
/// [size] 评分大小/默认24
/// [onchange] 改变值时的回调函数
/// [customSelectColor] 自定义选中后的颜色
/// [customUnSelectColor] 自定义未选中的颜色
/// [customUnselectIcon] 自定义未选中的icon图标
/// [customSelectIcon] 自定义选中的icon图标

class MXRate extends StatefulWidget {
  const MXRate({
    super.key,
    this.initValue,
    this.useHalf = false,
    this.count = 5,
    this.space = 8,
    this.size = 24,
    this.onchange,
    this.useEvent = true,
    this.customSelectColor,
    this.customUnSelectColor,
    this.customUnselectIcon,
    this.customSelectIcon,
  });

  /// [initValue] 初始化的值
  final double? initValue;

  /// [useHalf] 是否开启半分评价
  final bool useHalf;

  /// [count] 评分总数/默认总分为5分
  final int count;

  /// [space] 评分之间的间距/默认间距为8
  final double space;

  /// [size] 评分大小/默认24
  final double size;

  /// [customSelectIcon] 自定义选中的icon图标
  final IconData? customSelectIcon;

  /// [customUnselectIcon] 自定义未选中的icon图标
  final IconData? customUnselectIcon;

  /// [onchange] 改变值时的回调函数
  final MXRateOnchange? onchange;

  /// [customSelectColor] 自定义选中后的颜色
  final Color? customSelectColor;

  /// [customUnSelectColor] 自定义未选中的颜色
  final Color? customUnSelectColor;

  /// [useEvent] 是否开启事件
  final bool useEvent;

  @override
  State<MXRate> createState() => _MXRateState();
}

class _MXRateState extends State<MXRate> {
  double value = 0;

  GlobalKey key = GlobalKey();

  @override
  void initState() {
    if (widget.initValue != null) {
      if (widget.initValue! <= widget.count) {
        value = widget.initValue!;
      }
    }

    super.initState();
  }

  Widget _buildBody() {
    return Row(
      key: key,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildRateItemList(),
    );
  }

  List<Widget> _buildRateItemList() {
    List<Widget> children = [];

    List.generate(widget.count, (index) {
      children.add(MXRateItem(
        index: index + 1,
        value: value,
        size: widget.size,
        useEvent: widget.useEvent,
        useHalf: widget.useHalf,
        customSelectIcon: widget.customSelectIcon,
        customUnselectIcon: widget.customUnselectIcon,
        customSelectColor: widget.customSelectColor,
        customUnSelectColor: widget.customUnSelectColor,
        onTap: (details, itemIndex) {
          _onItemTap(details, itemIndex);
        },
      ));
      if (index != widget.count - 1) {
        children.add(SizedBox(width: widget.space));
      }
    });

    return children;
  }

  void _onItemTap(DragDownDetails details, int itemIndex) {
    if (!widget.useHalf) {
      value = itemIndex.toDouble();
    } else {
      RenderBox? renderObject =
          key.currentContext!.findRenderObject() as RenderBox?;

      if (renderObject != null) {
        double subSize = (widget.size + widget.space) * (itemIndex - 1);

        double positionSize = details.globalPosition.dx -
            renderObject.localToGlobal(Offset.zero).dx;

        if (positionSize - subSize >= (widget.size * 0.5)) {
          value = itemIndex.toDouble();
        } else {
          value = itemIndex.toDouble() - 0.5;
        }
      }
    }
    setState(() {
      widget.onchange?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
