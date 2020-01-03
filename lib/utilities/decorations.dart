import 'package:flutter/material.dart';

Border borderGris({
  bool left = false,
  bool rigth = false,
  bool top = false,
  bool bottom = false,
  bool all = false,
  double width = 2.0,
}) {
  if (all) left = rigth = top = bottom = true;

  BorderSide borderSide = BorderSide(
    color: Colors.grey,
    width: width,
  );

  return Border(
    left: !left ? BorderSide.none : borderSide,
    right: !rigth ? BorderSide.none : borderSide,
    top: !top ? BorderSide.none : borderSide,
    bottom: !bottom ? BorderSide.none : borderSide,
  );
}

BoxDecoration decorationButtons() => BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    );
