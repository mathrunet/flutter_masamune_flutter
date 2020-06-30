import 'dart:async';

import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Show selecting dialog.
///
/// ```
/// UISelectDialog.show( context );
/// ```
class UISelectDialog {
  /// Show selecting dialog.
  ///
  /// [context]: Build context.
  /// [dialogTitlePath]: Dialog title path.
  /// [dialogTextPath]: Dialog text path.
  /// [dialogSubmitTextPath]: Dialog submit button text path.
  /// [dialogSubmitActionPath]: The path of action when the submit button of the dialog is pressed.
  /// [title]: Default title.
  /// [text]: Default text.
  /// [disableBackKey]: True to disable the back key.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future show(BuildContext context,
      {String dialogTitlePath = DefaultPath.dialogTitle,
      String title,
      String text,
      @required Map<String, VoidAction> selectors,
      bool disableBackKey = false,
      bool popOnPress = true,
      bool willShowRepetition = false}) async {
    if (context == null || selectors == null) return;
    String _title = context.read(dialogTitlePath, defaultValue: title);
    if (_title == null) return;
    bool clicked = false;
    try {
      do {
        List<SimpleDialogOption> options = ListPool.get();
        for (MapEntry<String, VoidAction> selector in selectors.entries) {
          if (selector == null) continue;
          options.add(SimpleDialogOption(
              onPressed: () {
                if (popOnPress)
                  Navigator.of(context, rootNavigator: true).pop();
                if (selector.value != null) selector.value();
                clicked = true;
              },
              child: Text(selector.key?.localize())));
        }
        await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return WillPopScope(
                  onWillPop: disableBackKey ? () async => null : null,
                  child: SimpleDialog(title: Text(title), children: options));
            });
      } while (willShowRepetition && !clicked);
    } catch (e) {
      Log.error(e.toString());
    }
  }
}
