import 'package:flutter/material.dart';
import 'package:flutter_widget_model/flutter_widget_model.dart';

/// Mix-in that provides the ability to handle a text controller.
abstract class UIPageTextEditingControllerMixin {
  /// Define the controller.
  ///
  /// You can enter an initial value in [initialText].
  TextEditingController controller([String initialText]) {
    return useTextEditingController(text: initialText);
  }
}
