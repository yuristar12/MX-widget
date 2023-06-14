import 'package:flutter/material.dart';
import 'package:mx_widget/src/export.dart';

/// checkBox点击事件
typedef OnCheckBoxSeriesValueChange = void Function(List<String> value);

class MXCheckBoxBaseSeries extends StatefulWidget {
  const MXCheckBoxBaseSeries(
      {super.key,
      this.checkIds,
      required this.child,
      this.onCheckBoxSeriesValueChange,
      this.contentBuilder,
      this.iconBuilder,
      this.max,
      this.onOverloadChcked,
      this.modeEnum,
      this.iconSpace,
      this.titleMaxLine,
      this.directionEnum,
      this.controller,
      this.direction = Axis.horizontal,
      required this.checkBoxs,
      this.useIndeterminate});

  final Widget? child;

  final int? max;

  final VoidCallback? onOverloadChcked;

  final List<String>? checkIds;

  final int? titleMaxLine;

  final OnCheckBoxSeriesValueChange? onCheckBoxSeriesValueChange;

  final ContentBuilder? contentBuilder;

  final IconBuilder? iconBuilder;

  final MXCheckBoxModeEnum? modeEnum;

  final double? iconSpace;

  final MXCheckBoxDirectionEnum? directionEnum;

  final MXCheckBoxSeriesController? controller;

  final List<MXCheckBox> checkBoxs;

  final Axis direction;

  final bool? useIndeterminate;

  @override
  State<MXCheckBoxBaseSeries> createState() => MXCheckBoxBaseSeriesState();
}

class MXCheckBoxBaseSeriesState extends State<MXCheckBoxBaseSeries> {
  Map<String, bool> checkedIds = {};

  @override
  void initState() {
    super.initState();

    widget.controller?.state = this;

    _syncStateCheckIds(widget.checkIds);
  }

  /// 同步state的选中checkedIds的值
  _syncStateCheckIds(List<String>? ids) {
    if (ids != null) {
      checkedIds.clear();
      for (var element in ids) {
        checkedIds[element] = true;
      }
    }
  }

  @override
  void didUpdateWidget(covariant MXCheckBoxBaseSeries oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldIds = oldWidget.checkIds;
    final newIds = widget.checkIds;

    if (oldIds != newIds) {
      _syncStateCheckIds(newIds);
    }
  }

  /// 通过id获取某一个checkBox选中的状态
  bool? getCheckBoxById(String id) {
    if (checkedIds[id] == null) {
      return null;
    } else {
      return checkedIds[id];
    }
  }

  void registerCheckBoxById(String id, bool value) {
    if (checkedIds[id] == null) {
      checkedIds[id] = value;
    }
  }

  /// 通过id变更checkBox的值
  /// [notify] 是否存放setState方法
  /// [useChange] 是否触发传入的onCheckBoxSeriesValueChange的方法
  bool toggleBySingle(String id, bool value,
      {bool notify = false, bool useChange = true}) {
    // 需要判断是否操作可选的最大数量

    if (widget.max != null && value) {
      int count = 0;

      checkedIds.forEach((key, value) {
        if (checkedIds[key] == true) {
          count++;
        }
      });

      if (count >= widget.max!) {
        return false;
      }
    }

    checkedIds[id] = value;

    if (notify) {
      setState(() {});
    }

    // 触发传入的变更方法

    if (useChange) {
      onSeriesValueChange();
    }

    return true;
  }

  /// 勾选所有
  void toggleByAll(bool check, [bool notify = true]) {
    bool isChange = false;
    bool canNext = true;

    checkedIds.forEach((key, value) {
      if (check) {
        if (canNext) {
          if (!toggleBySingle(key, check, notify: true, useChange: false)) {
            canNext = false;
          } else {
            isChange = true;
          }
        }
      } else {
        toggleBySingle(key, check, notify: true, useChange: false);
        isChange = true;
      }
    });

    if (isChange && notify) {
      onSeriesValueChange();
    }
  }

  /// 反选
  void reverseAll() {
    checkedIds.forEach((key, value) {
      // ignore: no_leading_underscores_for_local_identifiers
      bool _value = !value;
      toggleBySingle(key, _value, useChange: false, notify: false);
    });

    setState(() {});
    onSeriesValueChange();
  }

  void onSeriesValueChange() {
    final change = widget.onCheckBoxSeriesValueChange;

    if (change != null) {
      final List<String> ids = [];

      checkedIds.forEach((key, value) {
        if (checkedIds[key] == true) {
          ids.add(key);
        }
      });

      change.call(ids);
    }
  }

  Widget _buildIndeterminate() {
    return MXCheckBox(
      title: "全选",
      showDivide: false,
      directionEnum: MXCheckBoxDirectionEnum.left,
      onCheckBoxValueChange: (checkValue) {
        bool isAll = _getIsAll();

        if (isAll) {
          widget.controller!.reverseAll();
        } else {
          widget.controller!.toggleAll(true);
        }
      },
      backgroundColor: Colors.transparent,
      sizeEnum: MXCheckBoxSizeEnum.small,
      iconBuilder: (context, isCheck) {
        bool isAll = _getIsAll();
        var ids = widget.controller!.allCheckedIds();
        IconData icon = Icons.check_box_outline_blank;

        if (ids.isNotEmpty && !isAll) {
          icon = Icons.indeterminate_check_box_rounded;
        } else if (isAll) {
          icon = Icons.check_box;
        }

        return MXIcon(
          icon: icon,
          iconColor: icon == Icons.check_box_outline_blank
              ? MXTheme.of(context).infoColor5
              : MXTheme.of(context).brandColor8,
          iconFontSize: 22,
        );
      },
    );
  }

  bool _getIsAll() {
    var ids = widget.controller!.allCheckedIds();

    bool isAll = ids.length == widget.checkBoxs.length;
    return isAll;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Widget _child;

    if (widget.child != null) {
      _child = widget.child!;
    } else {
      _child = _buildDefaultChild();
    }
    return MXCheckBoxBaseSeriesInherited(this, _child);
  }

  Widget _buildDefaultChild() {
    Widget current = SizedBox(
      width: double.infinity,
      child: widget.direction == Axis.horizontal
          ? Container(
              child: widget.modeEnum == MXCheckBoxModeEnum.card
                  ? Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: widget.checkBoxs
                          .map((e) => SizedBox(
                                width: 114,
                                child: e,
                              ))
                          .toList(),
                    )
                  : Row(
                      children: widget.checkBoxs
                          .map((e) => Expanded(child: e))
                          .toList(),
                    ))
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  child: widget.checkBoxs[index],
                );
              },
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, index) {
                if (widget.modeEnum == MXCheckBoxModeEnum.card) {
                  return SizedBox(
                    height: MXTheme.of(context).space12,
                  );
                }
                return const SizedBox.shrink();
              },
              itemCount: widget.checkBoxs.length),
    );

    if (widget.useIndeterminate != null) {
      current = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIndeterminate(),
          SizedBox(
            height: MXTheme.of(context).space16,
          ),
          current,
        ],
      );
    }

    return current;
  }
}

class MXCheckBoxBaseSeriesInherited extends InheritedWidget {
  final MXCheckBoxBaseSeriesState state;

  static MXCheckBoxBaseSeriesInherited? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MXCheckBoxBaseSeriesInherited>();
  }

  const MXCheckBoxBaseSeriesInherited(this.state, Widget child, {Key? key})
      : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant MXCheckBoxBaseSeriesInherited oldWidget) {
    return true;
  }
}
