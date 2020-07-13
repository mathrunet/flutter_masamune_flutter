import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mixin for using multiple text edit controllers.
abstract class UITextFieldControllerMixin {
  /// Text Editing Controller.
  final Map<String, TextEditingController> controllers = MapPool.get();

  /// Initialize the controller.
  ///
  /// [data]: Enter the controller key in the key and the initial value in the value.
  void init(Map<String, String> data) {
    data?.forEach((key, value) {
      if (isEmpty(key)) return;
      controllers[key] = TextEditingController(text: value ?? Const.empty);
    });
  }

  /// Upload the controller text all at once.
  ///
  /// [data]: Enter the controller key in the key and the update value in the value.
  void update(Map<String, String> data) {
    data?.forEach((key, value) {
      if (isEmpty(key) || !controllers.containsKey(key)) return;
      controllers[key].text = value ?? Const.empty;
    });
  }
}
