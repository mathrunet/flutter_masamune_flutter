import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mix-in that provides the ability to handle a text controller.
mixin UIPageTextEditingControllerMixin on UIPage {
  /// Define the controller.
  ///
  /// You can enter an initial value in [initialText].
  TextEditingController textEditingController([String initialText]) {
    return useTextEditingController(text: initialText);
  }
}
