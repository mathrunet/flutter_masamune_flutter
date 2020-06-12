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
  /// [defaultSubmitText]: Default submit button text.
  /// [defaultSubmitAction]: Default submit button action.
  /// [dialogText]: Default text.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future show(
      {String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String defaultSubmitText = "OK",
      String defaultText,
      VoidAction defaultSubmitAction,
      bool willShowRepetition = false}) async {
    BuildContext context = UIPage.current?.context;
    if (context == null) return;
    String text = context.read(dialogTextPath, defaultValue: defaultText);
    if (text == null) return;
    bool clicked = false;
    do {
      context = UIPage.current?.context;
      ScaffoldState scaffold = ((UIPage.current?.widget as UIPageScaffold)
          ?.scaffold
          ?.currentState as ScaffoldState);
      await scaffold
          .showSnackBar(SnackBar(
              content: Text(text),
              action: SnackBarAction(
                label: context.read(dialogSubmitTextPath,
                    defaultValue: defaultSubmitText),
                onPressed: () {
                  PathMap.removeAllPath([
                    dialogTextPath,
                    dialogSubmitTextPath,
                    dialogSubmitActionPath,
                    dialogSubmitTextPath
                  ]);
                  context.readAction(dialogSubmitActionPath,
                      defaultAction: defaultSubmitAction)();
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
