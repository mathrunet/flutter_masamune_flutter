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
  /// [submitText]: Default submit button text.
  /// [cancelText]: Default cancel button text.
  /// [onSubmit]: Default submit button action.
  /// [onCancel]: Default cancel button action.
  /// [backgroundColor]: Background color.
  /// [color]: Text color.
  /// [title]: Default title.
  /// [text]: Default text.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future show(BuildContext context,
      {String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String dialogCancelTextPath = DefaultPath.dialogCancelText,
      String dialogCancelActionPath = DefaultPath.dialogCancelAction,
      Color backgroundColor,
      Color color,
      String submitText = "Yes",
      String cacnelText = "No",
      String title,
      String text,
      VoidAction onSubmit,
      VoidAction onCancel,
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
            return AlertDialog(
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
                  child: Text(
                      PathMap.get<String>(dialogCancelTextPath) ?? cacnelText),
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
                    (PathMap.get<VoidAction>(dialogCancelActionPath) ??
                            onCancel)
                        ?.call();
                    clicked = true;
                  },
                ),
                FlatButton(
                  child: Text(
                      PathMap.get<String>(dialogSubmitTextPath) ?? submitText),
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
                    (PathMap.get<VoidAction>(dialogSubmitActionPath) ??
                            onSubmit)
                        ?.call();
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
