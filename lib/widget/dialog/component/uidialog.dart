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
  /// [submitText]: Default submit button text.
  /// [onSubmit]: Default submit button action.
  /// [backgroundColor]: Background color.
  /// [color]: Text color.
  /// [title]: Default title.
  /// [text]: Default text.
  /// [disableBackKey]: True to disable the back key.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future<bool> validate(BuildContext context,
      {@required Future<bool> validator(),
      String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String submitText = "OK",
      Color backgroundColor,
      Color color,
      String title = "ERROR",
      String text = "This data is invalid.",
      VoidAction onSubmit,
      bool disableBackKey = false,
      bool popOnPress = true,
      bool willShowRepetition = false}) async {
    if (await validator()) return true;
    await Future.delayed(
        Duration.zero,
        () => show(context,
            dialogTitlePath: dialogTitlePath,
            dialogTextPath: dialogTextPath,
            dialogSubmitActionPath: dialogSubmitActionPath,
            dialogSubmitTextPath: dialogSubmitTextPath,
            submitText: submitText,
            backgroundColor: backgroundColor,
            color: color,
            title: title,
            text: text,
            onSubmit: onSubmit ?? () => context.navigator.pop(),
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
  /// [submitText]: Default submit button text.
  /// [onSubmit]: Default submit button action.
  /// [backgroundColor]: Background color.
  /// [color]: Text color.
  /// [title]: Default title.
  /// [text]: Default text.
  /// [disableBackKey]: True to disable the back key.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future show(BuildContext context,
      {String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String submitText = "OK",
      Color backgroundColor,
      Color color,
      String title,
      String text,
      VoidAction onSubmit,
      bool disableBackKey = false,
      bool popOnPress = true,
      bool willShowRepetition = false}) async {
    if (context == null) return;
    String _title = PathMap.get<String>(dialogTitlePath) ?? title;
    String _text = PathMap.get<String>(dialogTextPath) ?? text;
    if (_title == null || _text == null) return;
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
                  title: Text(_title,
                      style: TextStyle(
                          color: color ?? context.theme.colorScheme.onSurface)),
                  content: SingleChildScrollView(
                      child: UIText(_text,
                          color: color ?? context.theme.colorScheme.onSurface)),
                  backgroundColor:
                      backgroundColor ?? context.theme.colorScheme.surface,
                  actions: <Widget>[
                    FlatButton(
                      child: Text(PathMap.get<String>(dialogSubmitTextPath) ??
                          submitText),
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
                        (PathMap.get<VoidAction>(dialogSubmitActionPath) ??
                                onSubmit)
                            ?.call();
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
