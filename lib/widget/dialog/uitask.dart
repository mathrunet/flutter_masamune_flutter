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
      String defaultSubmitText = "OK",
      String defaultTitle,
      String defaultText,
      VoidAction defaultSubmitAction,
      String defaultErrorTitle = "ERROR",
      String defaultAbortTitle = "ABORTED",
      String defaultTimeoutText}) async {
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
      String title = context.get(dialogTitlePath, defaultValue: defaultTitle);
      String text = context.get(dialogTextPath, defaultValue: defaultText);
      if (task == null) {
        title = defaultErrorTitle;
        text = "This data is invalid.".localize();
      } else if (task is Future<ITask>) {
        ITask tmp = await task;
        if (tmp == null || tmp.isTimeout) {
          title = defaultErrorTitle;
          text = defaultTimeoutText ?? tmp?.message ?? "Timed out.".localize();
        } else if (tmp.isError) {
          title = defaultErrorTitle;
          text = tmp.message ?? Const.empty;
        } else if (tmp.isAbort) {
          title = defaultAbortTitle;
          text = tmp.message ?? Const.empty;
        }
      } else if (task is Future<List<ITask>>) {
        List<ITask> tmp = await task;
        if (tmp == null || tmp.isTimeout) {
          title = defaultErrorTitle;
          text = defaultTimeoutText ?? tmp?.message ?? "Timed out.".localize();
        } else if (tmp.isError) {
          title = defaultErrorTitle;
          text = tmp.message ?? Const.empty;
        } else if (tmp.isAbort) {
          title = defaultAbortTitle;
          text = tmp.message ?? Const.empty;
        }
      }
      if (title == null || text == null) return;
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text(context.get(dialogSubmitTextPath,
                      defaultValue: defaultSubmitText)),
                  onPressed: () {
                    PathMap.removeAllPath([
                      dialogTitlePath,
                      dialogTextPath,
                      dialogSubmitTextPath,
                      dialogSubmitActionPath
                    ]);
                    Navigator.of(context, rootNavigator: true).pop();
                    context.getAction(dialogSubmitActionPath,
                        defaultAction: defaultSubmitAction)();
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
  /// [defaultSubmitText]: Default submit button text.
  /// [defaultSubmitAction]: Default submit button action.
  /// [dialogTitle]: Default title.
  /// [dialogText]: Default text.
  /// [dialogErrorTitle]: Title at the end of error.
  /// [dialogAbortTitle]: Title at the end of the break.
  /// [defaultTimeoutText]: Message when timed out.
  Future<T> showIndicatorAndDialog(BuildContext context,
      {bool isShowDialog = true,
      bool isShowIndicator = true,
      String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String defaultSubmitText = "OK",
      String defaultTitle,
      String defaultText,
      VoidAction defaultSubmitAction,
      String defaultErrorTitle = "ERROR",
      String defaultAbortTitle = "ABORTED",
      String defaultTimeoutText}) async {
    Future.delayed(
        Duration.zero,
        () => _UITask.show(context, this,
            isShowDialog: isShowDialog,
            isShowIndicator: isShowIndicator,
            dialogTitlePath: dialogTitlePath,
            dialogTextPath: dialogTextPath,
            dialogSubmitTextPath: dialogSubmitTextPath,
            dialogSubmitActionPath: dialogSubmitActionPath,
            defaultTitle: defaultTitle,
            defaultText: defaultText,
            defaultSubmitAction:
                defaultSubmitAction ?? () => context.navigator.pop(),
            defaultSubmitText: defaultSubmitText,
            defaultErrorTitle: defaultErrorTitle,
            defaultAbortTitle: defaultAbortTitle,
            defaultTimeoutText: defaultTimeoutText));
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
  /// [defaultSubmitText]: Default submit button text.
  /// [defaultSubmitAction]: Default submit button action.
  /// [dialogTitle]: Default title.
  /// [dialogText]: Default text.
  /// [dialogErrorTitle]: Title at the end of error.
  /// [dialogAbortTitle]: Title at the end of the break.
  /// [defaultTimeoutText]: Message when timed out.
  Future<List<T>> showIndicatorAndDialog(BuildContext context,
      {bool isShowDialog = true,
      bool isShowIndicator = true,
      String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogTextPath = DefaultPath.dialogText,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String defaultSubmitText = "OK",
      String defaultTitle,
      String defaultText,
      VoidAction defaultSubmitAction,
      String defaultErrorTitle = "ERROR",
      String defaultAbortTitle = "ABORTED",
      String defaultTimeoutText}) async {
    Future.delayed(
        Duration.zero,
        () => _UITask.show(context, this,
            isShowDialog: isShowDialog,
            isShowIndicator: isShowIndicator,
            dialogTitlePath: dialogTitlePath,
            dialogTextPath: dialogTextPath,
            dialogSubmitTextPath: dialogSubmitTextPath,
            dialogSubmitActionPath: dialogSubmitActionPath,
            defaultTitle: defaultTitle,
            defaultText: defaultText,
            defaultSubmitAction: defaultSubmitAction,
            defaultSubmitText: defaultSubmitText,
            defaultErrorTitle: defaultErrorTitle,
            defaultAbortTitle: defaultAbortTitle,
            defaultTimeoutText: defaultTimeoutText));
    return this;
  }
}
