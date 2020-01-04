import 'package:chatarrera_flutter/main.dart';
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
    color: appTheme.dividerColor,
    width: width,
  );

  return Border(
    left: !left ? BorderSide.none : borderSide,
    right: !rigth ? BorderSide.none : borderSide,
    top: !top ? BorderSide.none : borderSide,
    bottom: !bottom ? BorderSide.none : borderSide,
  );
}