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
  /// [backgroundColor]: Background color.
  /// [color]: Text color.
  /// [title]: Default title.
  /// [selected]: The element that is selected.
  /// [disableBackKey]: True to disable the back key.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  /// [willShowRepetition]: True if the dialog will continue to be displayed unless you press the regular close button.
  static Future show(BuildContext context,
      {String dialogTitlePath = DefaultPath.dialogTitle,
      Color backgroundColor,
      Color color,
      String title,
      String selected,
      @required Map<String, VoidAction> selectors,
      bool disableBackKey = false,
      bool popOnPress = true,
      bool willShowRepetition = false}) async {
    if (context == null || selectors == null) return;
    String _title = PathMap.get<String>(dialogTitlePath) ?? title;
    if (_title == null) return;
    bool clicked = false;
    try {
      do {
        List<SimpleDialogOption> options = ListPool.get();
        for (MapEntry<String, VoidAction> selector in selectors.entries) {
          if (selector == null) continue;
          options.add(SimpleDialogOption(
              onPressed: () {
                if (selector.value != null) selector.value();
                if (popOnPress)
                  Navigator.of(context, rootNavigator: true).pop();
                clicked = true;
              },
              child: Text(selector.key?.localize(),
                  style: TextStyle(
                      color: color ?? context.theme.colorScheme.onSurface,
                      fontWeight:
                          selected == selector.key ? FontWeight.bold : null))));
        }
        await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return WillPopScope(
                  onWillPop: disableBackKey ? () async => null : null,
                  child: SimpleDialog(
                    title: Text(title,
                        style: TextStyle(
                            color:
                                color ?? context.theme.colorScheme.onSurface)),
                    children: options,
                    backgroundColor:
                        backgroundColor ?? context.theme.colorScheme.surface,
                  ));
            });
      } while (willShowRepetition && !clicked);
    } catch (e) {
      Log.error(e.toString());
    }
  }
}
