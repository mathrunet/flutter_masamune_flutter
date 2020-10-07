import 'package:flutter/material.dart';
import 'package:flutter_widget_model/flutter_widget_model.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mixin to provide focus node functionality.
mixin UIPageFocusNodeMixin on UIHookWidget {
  /// Get the focus node.
  FocusNode get focusNode {
    return useFocusNode();
  }
}
