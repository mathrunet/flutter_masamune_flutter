import 'package:flutter/material.dart';

/// Mixins for using forms on pages.
abstract class UIFormMixin {
  /// Key for form.
  final formKey = GlobalKey<FormState>();

  /// Validate and save the data in the form.
  ///
  /// Returns True if the validation is successful.
  bool validateAndSave() {
    if (this.formKey == null || this.formKey.currentState == null) return false;
    if (!this.formKey.currentState.validate()) return false;
    this.formKey.currentState.save();
    return true;
  }
}
