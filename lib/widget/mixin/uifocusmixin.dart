import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mixins for using focus on pages.
abstract class UIFocusMixin implements UIWidget {
  static const String _focusKey = "focus";
  static const String _focusNodeKey = "focusNode";

  /// Get the FocusNode.
  ///
  /// [context]: BuildContext.
  FocusNode focusNode(BuildContext context) {
    if (context.cache[_focusNodeKey] == null)
      context.cache[_focusNodeKey] = FocusNode();
    return context.cache[_focusNodeKey];
  }

  /// Executed when the widget is loaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  void onLoad(BuildContext context) {
    this.focusNode(context).addListener(() {
      context.cache[_focusKey] = this.focusNode(context).hasFocus;
    });
  }

  /// True if it has focus.
  ///
  /// [context]: BuildContext.
  bool hasFocus(BuildContext context) {
    return context.cache[_focusKey] ?? false;
  }
}
