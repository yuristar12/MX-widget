import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Decoration skeletonBoxDes(
  animation,
  bool isCircle,
) {
  return BoxDecoration(
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: const [
          Color.fromRGBO(239, 239, 239, 1),
          Color(0xffe9ebee),
          Color.fromRGBO(243, 243, 243, 1),
        ],
        stops: animation != null && animation != false
            ? [
                animation.value - 1,
                animation.value,
                animation.value + 1,
              ]
            : [-1.0, 0, 1]),
  );
}
