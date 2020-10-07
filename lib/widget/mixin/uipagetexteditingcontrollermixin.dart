import 'package:flutter/material.dart';
import 'package:flutter_widget_model/flutter_widget_model.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mix-in that provides the ability to handle a text controller.
mixin UIPageTextEditingControllerMixin on UIHookWidget {
  /// Define the controller.
  ///
  /// You can enter an initial value in [initialText].
  TextEditingController textEditingController([String initialText]) {
    return useTextEditingController(text: initialText);
  }
}
