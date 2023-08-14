import 'package:mx_widget/mx_widget.dart';

class PopoverPosition {
  PopoverPosition(
      {required this.width,
      required this.height,
      required this.dx,
      required this.dy,
      required this.positionEnum});

  final double width;
  final double height;

  final double dx;
  final double dy;

  final MXPopoverPositionEnum positionEnum;
}
