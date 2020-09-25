import 'package:flutter/material.dart';
import 'package:flutter_widget_model/flutter_widget_model.dart';

/// Mixin to provide focus node functionality.
abstract class UIPageFocusNodeMixin {
  /// Get the focus node.
  FocusNode get focusNode {
    return useFocusNode();
  }
}
