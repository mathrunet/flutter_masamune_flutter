import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class _UIFuture {
  static Future<T> show<T extends Object>(BuildContext context, Future<T> task,
      {void actionOnFinish(T value)}) async {
    T val;
    if (context == null || task == null) return val;
    task.then((v) => val = v).whenComplete(() => Future.delayed(
        Duration.zero, () => Navigator.of(context, rootNavigator: true).pop()));
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
    if (actionOnFinish != null) actionOnFinish(val);
    return val;
  }
}

/// Extension methods for UIFuture.
extension UIFutureExtension<T extends Object> on Future<T> {
  /// Show indicator and dialog.
  ///
  /// Display an indicator if you are waiting for the task to end.
  ///
  /// [context]: Build context.
  /// [actionOnFinish]: Action after the task is finished.
  Future<T> showIndicator(BuildContext context,
      {void actionOnFinish(T value)}) async {
    Future.delayed(Duration.zero,
        () => _UIFuture.show<T>(context, this, actionOnFinish: actionOnFinish));
    return this.then((value) async {
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);
      return value;
    });
  }
}

/// Extension methods for UIFuture.
extension UIFutureListExtension<T extends Object> on Future<List<T>> {
  /// Show indicator and dialog.
  ///
  /// Display an indicator if you are waiting for the task to end.
  ///
  /// [context]: Build context.
  /// [actionOnFinish]: Action after the task is finished.
  Future<List<T>> showIndicator(BuildContext context,
      {void actionOnFinish(List<T> value)}) async {
    Future.delayed(
        Duration.zero,
        () => _UIFuture.show<List<T>>(context, this,
            actionOnFinish: actionOnFinish));
    return this.then((value) async {
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);
      return value;
    });
  }
}
