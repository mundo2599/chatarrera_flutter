import 'package:flutter/material.dart';

Border borderGris({
  bool left = false,
  bool rigth = false,
  bool top = false,
  bool bottom = false,
  bool all = false,
}) {
  if (all) {
    left = rigth = top = bottom = true;
  }
  return Border(
    left: !left
        ? BorderSide.none
        : BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
    right: !rigth
        ? BorderSide.none
        : BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
    top: !top
        ? BorderSide.none
        : BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
    bottom: !bottom
        ? BorderSide.none
        : BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
  );
}

BoxDecoration decorationButtons() => BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    );
