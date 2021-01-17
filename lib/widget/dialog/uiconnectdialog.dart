import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// A dialog box that checks for connections and gives an error when no connection is made and waits for the next step.
///
/// ```
/// UIConnectDialog.show( context );
/// ```
class UIConnectDialog {
  /// Show dialog.
  ///
  /// [context]: Build context.
  /// [dialogTitlePath]: Dialog title path.
  /// [dialogTextPath]: Dialog text path.
  /// [dialogRetryTextPath]: Dialog retry button text path.
  /// [dialogRetryActionPath]: The path of action when the retry button of the dialog is pressed.
  /// [dialogBackTextPath]: Dialog back button text path.
  /// [dialogBackActionPath]: The path of action when the back button of the dialog is pressed.
  /// [retryText]: Default retry button text.
  /// [onRetry]: Default retry button action.
  /// [backText]: Default back button text.
  /// [onBack]: Default back button action.
  /// [title]: Default title.
  /// [text]: Default text.
  /// [showBackButton]: If true, the back button is displayed.
  /// [disableBackKey]: True to disable the back key.
  static Future show(BuildContext context,
      {String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogRetryTextPath = DefaultPath.dialogSubmitText,
      String dialogRetryActionPath = DefaultPath.dialogSubmitAction,
      String dialogBackTextPath = DefaultPath.dialogCancelText,
      String dialogBackActionPath = DefaultPath.dialogCancelAction,
      String retryText = "Retry",
      String backText = "Back",
      String title = "Error",
      String text = "Unable to connect to the network.",
      VoidAction onRetry,
      VoidAction onBack,
      bool showBackButton = true,
      bool disableBackKey = false}) async {
    if (context == null) return;
    String _title = (PathMap.get<String>(dialogTitlePath) ?? title)?.localize();
    String _text = (PathMap.get<String>(dialogTextPath) ?? text)?.localize();
    if (_title == null || _text == null) return;
    bool clicked = false;
    OverlayState overlay = context.navigator.overlay;
    while (await Config.connect() == ConnectivityResult.none && !clicked) {
      await showDialog(
          context: overlay.context,
          barrierDismissible: false,
          builder: (context) {
            return WillPopScope(
                onWillPop: disableBackKey ? () async => null : null,
                child: AlertDialog(
                  title: Text(_title),
                  content: SingleChildScrollView(child: Text(_text)),
                  actions: <Widget>[
                    FlatButton(
                      child: Text((PathMap.get<String>(dialogRetryTextPath) ??
                              retryText)
                          ?.localize()),
                      onPressed: () {
                        PathMap.removeAllPath([
                          dialogTitlePath,
                          dialogTextPath,
                          dialogRetryTextPath,
                          dialogRetryActionPath,
                          dialogBackTextPath,
                          dialogBackActionPath
                        ]);
                        Navigator.of(context, rootNavigator: true).pop();
                        (PathMap.get<VoidAction>(dialogRetryActionPath) ??
                                onRetry)
                            ?.call();
                      },
                    ),
                    if (showBackButton)
                      FlatButton(
                        child: Text((PathMap.get<String>(dialogBackTextPath) ??
                                backText)
                            ?.localize()),
                        onPressed: () {
                          PathMap.removeAllPath([
                            dialogTitlePath,
                            dialogTextPath,
                            dialogRetryTextPath,
                            dialogRetryActionPath,
                            dialogBackTextPath,
                            dialogBackActionPath
                          ]);
                          Navigator.of(context, rootNavigator: true).pop();
                          (PathMap.get<VoidAction>(dialogBackActionPath) ??
                                  onBack)
                              ?.call();
                          clicked = true;
                        },
                      )
                  ],
                ));
          });
    }
    PathMap.removeAllPath([
      dialogTitlePath,
      dialogTextPath,
      dialogRetryTextPath,
      dialogRetryActionPath,
      dialogBackTextPath,
      dialogBackActionPath
    ]);
  }
}
