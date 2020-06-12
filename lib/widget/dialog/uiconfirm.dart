import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Show confirmation dialog.
///
/// ```
/// UIConfirm.show( context );
/// ```
class UIConfirm {
  /// Show confirmation dialog.
  ///
  /// ```
  /// UIConfirm.show( context );
  /// ```
  ///
  /// [context]: Build context.
  /// [dialogTitlePath]: Dialog title path.
  /// [dialogTextPath]: Dialog text path.
  /// [dialogSubmitTextPath]: Dialog submit button text path.
  /// [dialogSubmitActionPath]: The path of action when the submit button of the dialog is pressed.
  /// [dialogCancelTextPath]: Dialog cancel button text path.
  /// [dialogCancelActionPath]: The path of action when the cancel button of the dialog is pressed.
  /// [defaultSubmitText]: Default submit button text.
  /// [defaultCancelText]: Default cancel button text.
  /// [defaultSubmitAction]: Default submit button action.
  /// [defaultCancelAction]: Default cancel button action.
  /// [dialogTitle]: Default title.
  /// [dialogText]: Default text.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future show(BuildContext context,
      {String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String dialogCancelTextPath = DefaultPath.dialogCancelText,
      String dialogCancelActionPath = DefaultPath.dialogCancelAction,
      String defaultSubmitText = "Yes",
      String defaultCacnelText = "No",
      String defaultTitle,
      String defaultText,
      VoidAction defaultSubmitAction,
      VoidAction defaultCancelAction,
      bool popOnPress = true,
      bool willShowRepetition = false}) async {
    if (context == null) return;
    String title = context.read(dialogTitlePath, defaultValue: defaultTitle);
    String text = context.read(dialogTextPath, defaultValue: defaultText);
    if (title == null || text == null) return;
    bool clicked = false;
    OverlayState overlay = context.navigator.overlay;
    do {
      await showDialog(
          context: overlay.context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text(context.read(dialogCancelTextPath,
                      defaultValue: defaultCacnelText)),
                  onPressed: () {
                    PathMap.removeAllPath([
                      dialogTitlePath,
                      dialogTextPath,
                      dialogSubmitTextPath,
                      dialogSubmitActionPath,
                      dialogSubmitTextPath,
                      dialogCancelTextPath,
                      dialogCancelActionPath
                    ]);
                    if (popOnPress)
                      Navigator.of(context, rootNavigator: true).pop();
                    context.readAction(dialogCancelActionPath,
                        defaultAction: defaultCancelAction)();
                    clicked = true;
                  },
                ),
                FlatButton(
                  child: Text(context.read(dialogSubmitTextPath,
                      defaultValue: defaultSubmitText)),
                  onPressed: () {
                    PathMap.removeAllPath([
                      dialogTitlePath,
                      dialogTextPath,
                      dialogSubmitTextPath,
                      dialogSubmitActionPath,
                      dialogSubmitTextPath,
                      dialogCancelTextPath,
                      dialogCancelActionPath
                    ]);
                    if (popOnPress)
                      Navigator.of(context, rootNavigator: true).pop();
                    context.readAction(dialogSubmitActionPath,
                        defaultAction: defaultSubmitAction)();
                    clicked = true;
                  },
                )
              ],
            );
          });
    } while (willShowRepetition && !clicked);
    PathMap.removeAllPath([
      dialogTitlePath,
      dialogTextPath,
      dialogSubmitTextPath,
      dialogSubmitActionPath,
      dialogSubmitTextPath,
      dialogCancelTextPath,
      dialogCancelActionPath
    ]);
  }
}
