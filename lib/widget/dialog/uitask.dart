import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

class _UITask {
  static Future show(BuildContext context, Future task,
      {bool isShowDialog = true,
      bool isShowIndicator = true,
      String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String submitText = "OK",
      String title,
      String text,
      VoidAction submitAction,
      String errorTitle = "ERROR",
      String abortTitle = "ABORTED",
      String timeoutText}) async {
    if (context == null) return;
    if (task != null) {
      if (isShowIndicator) {
        task.whenComplete(() => Future.delayed(Duration.zero,
            () => Navigator.of(context, rootNavigator: true).pop()));
        await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return WillPopScope(
                  onWillPop: () async => false,
                  child: Center(
                      child: LoadingBouncingGrid.square(
                          backgroundColor: Colors.white.withOpacity(0.5))));
            });
      }
    }
    if (isShowDialog) {
      String _title = context.read(dialogTitlePath, defaultValue: title);
      String _text = context.read(dialogTextPath, defaultValue: text);
      if (task == null) {
        _title = errorTitle;
        _text = "This data is invalid.".localize();
      } else if (task is Future<ITask>) {
        ITask tmp = await task;
        if (tmp == null || tmp.isTimeout) {
          _title = errorTitle;
          _text = timeoutText ?? tmp?.message ?? "Timed out.".localize();
        } else if (tmp.isError) {
          _title = errorTitle;
          _text = tmp.message ?? Const.empty;
        } else if (tmp.isAbort) {
          _title = abortTitle;
          _text = tmp.message ?? Const.empty;
        }
      } else if (task is Future<List<ITask>>) {
        List<ITask> tmp = await task;
        if (tmp == null || tmp.isTimeout) {
          _title = errorTitle;
          _text = timeoutText ?? tmp?.message ?? "Timed out.".localize();
        } else if (tmp.isError) {
          _title = errorTitle;
          _text = tmp.message ?? Const.empty;
        } else if (tmp.isAbort) {
          _title = abortTitle;
          _text = tmp.message ?? Const.empty;
        }
      }
      if (_title == null || _text == null) return;
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(_title),
              content: Text(_text),
              actions: <Widget>[
                FlatButton(
                  child: Text(context.read(dialogSubmitTextPath,
                      defaultValue: submitText)),
                  onPressed: () {
                    PathMap.removeAllPath([
                      dialogTitlePath,
                      dialogTextPath,
                      dialogSubmitTextPath,
                      dialogSubmitActionPath
                    ]);
                    Navigator.of(context, rootNavigator: true).pop();
                    context.readAction(dialogSubmitActionPath,
                        defaultAction: submitAction)();
                  },
                ),
              ],
            );
          });
    }
    PathMap.removeAllPath([
      dialogTitlePath,
      dialogTextPath,
      dialogSubmitTextPath,
      dialogSubmitActionPath
    ]);
  }
}

/// Extension methods for ITask.
extension UITaskExtension<T extends ITask> on Future<T> {
  /// Show indicator and dialog.
  ///
  /// Display an indicator if you are waiting for the task to end,
  /// Display a dialog on exit on error or interruption.
  ///
  /// [context]: Build context.
  /// [isShowDialog]: True to display a dialog.
  /// [isShowIndicator]: True to display a indicator.
  /// [dialogTitlePath]: Dialog title path.
  /// [dialogTextPath]: Dialog text path.
  /// [dialogSubmitTextPath]: Dialog submit button text path.
  /// [dialogSubmitActionPath]: The path of action when the submit button of the dialog is pressed.
  /// [submitText]: Default submit button text.
  /// [submitAction]: Default submit button action.
  /// [title]: Default title.
  /// [text]: Default text.
  /// [errorTitle]: Title at the end of error.
  /// [abortTitle]: Title at the end of the break.
  /// [timeoutText]: Message when timed out.
  Future<T> showIndicatorAndDialog(BuildContext context,
      {bool isShowDialog = true,
      bool isShowIndicator = true,
      String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String submitText = "OK",
      String title,
      String text,
      VoidAction submitAction,
      String errorTitle = "ERROR",
      String abortTitle = "ABORTED",
      String timeoutText}) async {
    Future.delayed(
        Duration.zero,
        () => _UITask.show(context, this,
            isShowDialog: isShowDialog,
            isShowIndicator: isShowIndicator,
            dialogTitlePath: dialogTitlePath,
            dialogTextPath: dialogTextPath,
            dialogSubmitTextPath: dialogSubmitTextPath,
            dialogSubmitActionPath: dialogSubmitActionPath,
            title: title,
            text: text,
            submitAction: submitAction ?? () => context.navigator.pop(),
            submitText: submitText,
            errorTitle: errorTitle,
            abortTitle: abortTitle,
            timeoutText: timeoutText));
    return this;
  }
}

/// Extension methods for ITask.
extension UITaskListExtension<T extends ITask> on Future<List<T>> {
  /// Show indicator and dialog.
  ///
  /// Display an indicator if you are waiting for the task to end,
  /// Display a dialog on exit on error or interruption.
  ///
  /// [context]: Build context.
  /// [isShowDialog]: True to display a dialog.
  /// [isShowIndicator]: True to display a indicator.
  /// [dialogTitlePath]: Dialog title path.
  /// [dialogTextPath]: Dialog text path.
  /// [dialogSubmitTextPath]: Dialog submit button text path.
  /// [dialogSubmitActionPath]: The path of action when the submit button of the dialog is pressed.
  /// [submitText]: Default submit button text.
  /// [submitAction]: Default submit button action.
  /// [title]: Default title.
  /// [text]: Default text.
  /// [errorTitle]: Title at the end of error.
  /// [abortTitle]: Title at the end of the break.
  /// [timeoutText]: Message when timed out.
  Future<List<T>> showIndicatorAndDialog(BuildContext context,
      {bool isShowDialog = true,
      bool isShowIndicator = true,
      String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String submitText = "OK",
      String title,
      String text,
      VoidAction submitAction,
      String errorTitle = "ERROR",
      String abortTitle = "ABORTED",
      String timeoutText}) async {
    Future.delayed(
        Duration.zero,
        () => _UITask.show(context, this,
            isShowDialog: isShowDialog,
            isShowIndicator: isShowIndicator,
            dialogTitlePath: dialogTitlePath,
            dialogTextPath: dialogTextPath,
            dialogSubmitTextPath: dialogSubmitTextPath,
            dialogSubmitActionPath: dialogSubmitActionPath,
            title: title,
            text: text,
            submitAction: submitAction,
            submitText: submitText,
            errorTitle: errorTitle,
            abortTitle: abortTitle,
            timeoutText: timeoutText));
    return this;
  }
}
