import 'dart:math';
import 'package:flutter/material.dart';

extension OffsetFloatingActionButtonLocation on FloatingActionButtonLocation {
  static FloatingActionButtonLocation offset(
          {@required double aspectX, double offsetY}) =>
      DockedFloatingActionButtonLocation(aspectX: aspectX, offsetY: offsetY);
}

class DockedFloatingActionButtonLocation extends FloatingActionButtonLocation {
  const DockedFloatingActionButtonLocation(
      {@required this.aspectX, this.offsetY = 0});

  final double aspectX;
  final double offsetY;

  @protected
  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;

    double fabY = contentBottom - fabHeight / 2.0;
    if (snackBarHeight > 0.0)
      fabY = min(
          fabY,
          contentBottom -
              snackBarHeight -
              fabHeight -
              kFloatingActionButtonMargin);
    if (bottomSheetHeight > 0.0)
      fabY = min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);

    final double maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight;
    return min(maxFabY, fabY) + offsetY;
  }

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        aspectX;
    return Offset(fabX, getDockedY(scaffoldGeometry));
  }

  @override
  String toString() => 'FloatingActionButtonLocation.centerDocked';
}
