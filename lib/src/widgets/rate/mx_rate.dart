import 'package:flutter/material.dart';
import 'package:mx_widget/mx_widget.dart';
import 'package:mx_widget/src/widgets/rate/mx_rate_item.dart';

class MXRate extends StatefulWidget {
  const MXRate({
    super.key,
    this.initValue,
    this.useHalf = false,
    this.count = 5,
    this.space = 8,
    this.size = 24,
    this.onchange,
    this.customSelectColor,
    this.customUnSelectColor,
    this.customUnselectIcon,
    this.customSelectIcon,
  });

  final double? initValue;

  final bool useHalf;

  final int count;

  final double space;

  final double size;

  final IconData? customSelectIcon;
  final IconData? customUnselectIcon;

  final MXRateOnchange? onchange;

  final Color? customSelectColor;

  final Color? customUnSelectColor;

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
