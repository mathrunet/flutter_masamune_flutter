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
      Color backgroundColor,
      Color color,
      String title,
      String text,
      VoidAction onSubmit,
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
                      child: context.widgetTheme.loadingIndicator(
                              context, Colors.white.withOpacity(0.5)) ??
                          LoadingBouncingGrid.square(
                              backgroundColor: Colors.white.withOpacity(0.5))));
            });
      }
    }
    if (isShowDialog) {
      String _title = PathMap.get<String>(dialogTitlePath) ?? title;
      String _text = PathMap.get<String>(dialogTextPath) ?? text;
      if (task == null) {
        _title = errorTitle;
        _text = "This data is invalid.".localize();
      } else if (task is Future<IPath>) {
        IPath tmp = await task;
        if (tmp is ITask) {
          if (tmp.isTimeout) {
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
      } else if (task is Future<List<IPath>>) {
        List<IPath> tmp = await task;
        if (tmp is List<ITask>) {
          if (tmp.isTimeout) {
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
      }
      if (_title == null || _text == null) return;
      await showDialog(
          context: context,
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
                      PathMap.get<String>(dialogSubmitTextPath) ?? submitText),
                  onPressed: () {
                    PathMap.removeAllPath([
                      dialogTitlePath,
                      dialogTextPath,
                      dialogSubmitTextPath,
                      dialogSubmitActionPath
                    ]);
                    Navigator.of(context, rootNavigator: true).pop();
                    (PathMap.get<VoidAction>(dialogSubmitActionPath) ??
                            onSubmit)
                        ?.call();
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

/// Extension methods for IPath.
extension UITaskExtension<T extends IPath> on Future<T> {
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
  /// [onSubmit]: Default submit button action.
  /// [backgroundColor]: Background color.
  /// [color]: Text color.
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
      Color backgroundColor,
      Color color,
      String title,
      String text,
      VoidAction onSubmit,
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
            backgroundColor: backgroundColor,
            color: color,
            title: title,
            text: text,
            onSubmit: onSubmit ?? () => context.navigator.pop(),
            submitText: submitText,
            errorTitle: errorTitle,
            abortTitle: abortTitle,
            timeoutText: timeoutText));
    return this.then((value) async {
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);
      return value;
    });
  }
}

/// Extension methods for IPath.
extension UITaskPathListExtension<T extends IPath> on Future<List<T>> {
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
  /// [onSubmit]: Default submit button action.
  /// [backgroundColor]: Background color.
  /// [color]: Text color.
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
      Color backgroundColor,
      Color color,
      String title,
      String text,
      VoidAction onSubmit,
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
            backgroundColor: backgroundColor,
            color: color,
            title: title,
            text: text,
            onSubmit: onSubmit,
            submitText: submitText,
            errorTitle: errorTitle,
            abortTitle: abortTitle,
            timeoutText: timeoutText));
    return this.then((value) async {
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);
      return value;
    });
  }
}

/// Extension methods for ITask.
extension UITaskTaskListExtension<T extends ITask> on Future<List<T>> {
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
  /// [onSubmit]: Default submit button action.
  /// [backgroundColor]: Background color.
  /// [color]: Text color.
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
      Color backgroundColor,
      Color color,
      String title,
      String text,
      VoidAction onSubmit,
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
            backgroundColor: backgroundColor,
            color: color,
            title: title,
            text: text,
            onSubmit: onSubmit,
            submitText: submitText,
            errorTitle: errorTitle,
            abortTitle: abortTitle,
            timeoutText: timeoutText));
    return this.then((value) async {
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);
      return value;
    });
  }
}
