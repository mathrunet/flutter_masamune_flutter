import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mixins for using focus on pages.
mixin UIFocusMixin on Widget implements UIWidget {
  /// [provider]: Save the object to UIValue.
  ///
  /// The saved value is getting by [context.consume].
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  @mustCallSuper
  List provider(BuildContext context) {
    return [FocusNode(), _FocusState()];
  }

  /// Get the FocusNode.
  ///
  /// [context]: BuildContext.
  FocusNode focusNode(BuildContext context) {
    return context.consume<FocusNode>();
  }

  /// Executed when the widget is loaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  void onLoad(BuildContext context) {
    this.focusNode(context).addListener(() {
      context.consume<_FocusState>().hasFocus =
          this.focusNode(context).hasFocus;
    });
  }

  /// True if it has focus.
  ///
  /// [context]: BuildContext.
  bool hasFocus(BuildContext context) {
    return context.consume<_FocusState>()?.hasFocus ?? false;
  }
}

class _FocusState {
  bool hasFocus;
}
