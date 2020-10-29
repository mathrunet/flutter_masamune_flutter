import 'package:flutter/material.dart';

/// Default BoxDecoration.
class DefaultBoxDecoration extends BoxDecoration {
  /// Default BoxDecoration.
  ///
  /// [color]: Border colors.
  /// [radius]: Border radius.
  /// [backgroundColor]: Background color.
  /// [width]: Border width.
  DefaultBoxDecoration(
      {Color color,
      Color backgroundColor,
      double radius = 6.0,
      double width = 1})
      : super(
          color: backgroundColor,
          border: Border.all(color: color ?? Colors.black, width: 1),
          borderRadius: BorderRadius.circular(radius),
        );
}
