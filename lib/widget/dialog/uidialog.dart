import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Show dialog.
///
/// ```
/// UIDialog.show( context );
/// ```
class UIDialog {
  /// Check the value and display a dialog when it is [false].
  ///
  /// [context]: Build context.
  /// [validator]: Validator. Shows a dialog when the value is false.
  /// [dialogTitlePath]: Dialog title path.
  /// [dialogTextPath]: Dialog text path.
  /// [dialogSubmitTextPath]: Dialog submit button text path.
  /// [dialogSubmitActionPath]: The path of action when the submit button of the dialog is pressed.
  /// [defaultSubmitText]: Default submit button text.
  /// [defaultSubmitAction]: Default submit button action.
  /// [dialogTitle]: Default title.
  /// [dialogText]: Default text.
  /// [disableBackKey]: True to disable the back key.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future<bool> validate(BuildContext context,
      {@required bool validator(),
      String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String defaultSubmitText = "OK",
      String defaultTitle = "ERROR",
      String defaultText = "This data is invalid.",
      VoidAction defaultSubmitAction,
      bool disableBackKey = false,
      bool popOnPress = true,
      bool willShowRepetition = false}) async {
    if (validator()) return true;
    await Future.delayed(
        Duration.zero,
        () => show(context,
            dialogTitlePath: dialogTitlePath,
            dialogTextPath: dialogTextPath,
            dialogSubmitActionPath: dialogSubmitActionPath,
            dialogSubmitTextPath: dialogSubmitTextPath,
            defaultSubmitText: defaultSubmitText,
            defaultTitle: defaultTitle,
            defaultText: defaultText,
            defaultSubmitAction:
                defaultSubmitAction ?? () => context.navigator.pop(),
            disableBackKey: disableBackKey,
            popOnPress: popOnPress,
            willShowRepetition: willShowRepetition));
    return false;
  }

  /// Show dialog.
  ///
  /// [context]: Build context.
  /// [dialogTitlePath]: Dialog title path.
  /// [dialogTextPath]: Dialog text path.
  /// [dialogSubmitTextPath]: Dialog submit button text path.
  /// [dialogSubmitActionPath]: The path of action when the submit button of the dialog is pressed.
  /// [defaultSubmitText]: Default submit button text.
  /// [defaultSubmitAction]: Default submit button action.
  /// [dialogTitle]: Default title.
  /// [dialogText]: Default text.
  /// [disableBackKey]: True to disable the back key.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future show(BuildContext context,
      {String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String defaultSubmitText = "OK",
      String defaultTitle,
      String defaultText,
      VoidAction defaultSubmitAction,
      bool disableBackKey = false,
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
            return WillPopScope(
                onWillPop: disableBackKey ? () async => null : null,
                child: AlertDialog(
                  title: Text(title),
                  content: Text(text),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(context.read(dialogSubmitTextPath,
                          defaultValue: defaultSubmitText)),
                      onPressed: () {
                        PathMap.removeAllPath([
                          dialogTitlePath,
                          dialogTextPath,
                          dialogSubmitTextPath,
                          dialogSubmitActionPath,
                          dialogSubmitTextPath
                        ]);
                        if (popOnPress)
                          Navigator.of(context, rootNavigator: true).pop();
                        context.readAction(dialogSubmitActionPath,
                            defaultAction: defaultSubmitAction)();
                        clicked = true;
                      },
                    )
                  ],
                ));
          });
    } while (willShowRepetition && !clicked);
    PathMap.removeAllPath([
      dialogTitlePath,
      dialogTextPath,
      dialogSubmitTextPath,
      dialogSubmitActionPath,
      dialogSubmitTextPath
    ]);
  }
}
