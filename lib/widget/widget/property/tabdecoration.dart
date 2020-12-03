import 'package:flutter/material.dart';

/// Tab Decoration.
class TabDecoration extends BoxDecoration {
  /// Default TabDecoration.
  ///
  /// [color]: Border colors.
  /// [radius]: Border radius.
  /// [backgroundColor]: Background color.
  /// [width]: Border width.
  TabDecoration(
      {Color color,
      Color backgroundColor,
      double radius = 6.0,
      double width = 1})
      : super(
          color: backgroundColor,
          border: Border.all(color: color ?? Colors.black, width: width),
          borderRadius: radius <= 0
              ? null
              : BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius)),
        );
}
