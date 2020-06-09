import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mixins for using text editor.
abstract class UITextEditingMixin implements UIWidget {
  static const String _focusKey = "focus";
  static const String _focusNodeKey = "focusNode";
  final _TextEditingController _textEditingController =
      _TextEditingController();

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

  /// Text edit controller.
  TextEditingController get textEditingController =>
      this._textEditingController.controller;

  /// Text edit controller.
  ///
  /// [controller]: Text edit controller.
  set textEditingController(TextEditingController controller) {
    this._textEditingController.controller = controller;
  }

  /// Select all strings in the text.
  ///
  /// You can delete all with the delete button.
  void select() {
    final newText = this.textEditingController.text;
    this.textEditingController.value = this
        .textEditingController
        .value
        .copyWith(
          text: newText,
          selection: TextSelection(baseOffset: 0, extentOffset: newText.length),
          composing: TextRange.empty,
        );
  }

  /// Focus at the end of the character.
  void focusLast() {
    final newText = this.textEditingController.text;
    this.textEditingController.value =
        this.textEditingController.value.copyWith(
              text: newText,
              selection: TextSelection(
                  baseOffset: newText.length, extentOffset: newText.length),
              composing: TextRange.empty,
            );
  }
}

class _TextEditingController {
  TextEditingController controller;
}
