import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Show snack bar.
///
/// ```
/// UISnackBar.show( context );
/// ```
class UISnackBar {
  /// Show snack bar.
  ///
  /// [context]: Build context.
  /// [dialogTextPath]: Dialog text path.
  /// [dialogSubmitTextPath]: Dialog submit button text path.
  /// [dialogSubmitActionPath]: The path of action when the submit button of the dialog is pressed.
  /// [submitText]: Default submit button text.
  /// [onSubmit]: Default submit button action.
  /// [text]: Default text.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future show(BuildContext context,
      {String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String submitText = "OK",
      String text,
      VoidAction onSubmit,
      bool willShowRepetition = false}) async {
    if (context == null) return;
    String _text = PathMap.get<String>(dialogTextPath) ?? text;
    if (_text == null) return;
    bool clicked = false;
    do {
      ScaffoldState scaffold = Scaffold.of(context);
      if (scaffold == null) return;
      await scaffold
          .showSnackBar(SnackBar(
              content: Text(_text),
              action: SnackBarAction(
                label: PathMap.get<String>(dialogSubmitTextPath) ?? submitText,
                onPressed: () {
                  PathMap.removeAllPath([
                    dialogTextPath,
                    dialogSubmitTextPath,
                    dialogSubmitActionPath,
                    dialogSubmitTextPath
                  ]);
                  (PathMap.get<VoidAction>(dialogSubmitActionPath) ?? onSubmit)
                      ?.call();
                  clicked = true;
                },
              )))
          .closed
          .then((value) {
        clicked = true;
      });
    } while (willShowRepetition && !clicked);
    PathMap.removeAllPath([
      dialogTextPath,
      dialogSubmitTextPath,
      dialogSubmitActionPath,
      dialogSubmitTextPath
    ]);
  }
}
