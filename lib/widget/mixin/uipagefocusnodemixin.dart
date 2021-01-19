import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mixin to provide focus node functionality.
mixin UIPageFocusNodeMixin on UIPage {
  /// Get the focus node.
  FocusNode get focusNode {
    return useFocusNode();
  }
}
