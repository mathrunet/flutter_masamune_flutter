import 'dart:async';

import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mixin for using multiple text edit controllers.
abstract class UITextFieldControllerMixin {
  final Completer<IDataDocument> _completer = Completer();

  /// Timeout time.
  Duration get timeout => Const.timeout;

  /// Flag that exits when the controller is fully loaded.
  Future<IDataDocument> get initialized => this._completer.future;

  /// Text Editing Controller.
  final Map<String, TextEditingController> controllers = MapPool.get();

  /// Initialize the controller.
  ///
  /// [initial]: Enter the controller key in the key and
  /// the initial value in the value.
  /// [document]: The document to read.
  /// The value of the controller is updated when reading is completed.
  /// [filter]: Callback when the document is updated.
  Future init(Map<String, String> initial,
      {FutureOr<IDataDocument> document,
      Map<String, String Function(dynamic value)> filter}) async {
    initial?.forEach((key, value) {
      if (isEmpty(key)) return;
      controllers[key] = TextEditingController(text: value ?? Const.empty);
    });
    if (document is Future<IDataDocument>) {
      IDataDocument doc = await document.timeout(this.timeout);
      doc?.forEach((key, value) {
        if (isEmpty(key)) return;
        String val = filter != null && filter.containsKey(key)
            ? filter[key](value.data)
            : value.data?.toString() ?? Const.empty;
        if (!controllers.containsKey(key)) {
          controllers[key] = TextEditingController(text: val);
        } else {
          controllers[key].text = val;
        }
      });
      _completer.complete(doc);
    } else if (document is IDataDocument) {
      document?.forEach((key, value) {
        if (isEmpty(key)) return;
        String val = filter != null && filter.containsKey(key)
            ? filter[key](value.data)
            : value.data?.toString() ?? Const.empty;
        if (!controllers.containsKey(key)) {
          controllers[key] = TextEditingController(text: val);
        } else {
          controllers[key].text = val;
        }
      });
    }
  }

  /// Update the controller.
  ///
  /// [initial]: Enter the controller key in the key and
  /// the initial value in the value.
  /// [document]: The document to read.
  /// The value of the controller is updated when reading is completed.
  /// [filter]: Callback when the document is updated.
  Future update(FutureOr<IDataDocument> document,
      {Map<String, String> initial,
      Map<String, String Function(dynamic value)> filter}) async {
    if (document is Future<IDataDocument>) {
      initial?.forEach((key, value) {
        if (isEmpty(key)) return;
        if (!controllers.containsKey(key)) {
          controllers[key] = TextEditingController(text: value ?? Const.empty);
        } else {
          controllers[key].text = value ?? Const.empty;
        }
      });
      IDataDocument doc = await document.timeout(this.timeout);
      doc?.forEach((key, value) {
        if (isEmpty(key)) return;
        String val = filter != null && filter.containsKey(key)
            ? filter[key](value.data)
            : value.data?.toString() ?? Const.empty;
        if (!controllers.containsKey(key)) {
          controllers[key] = TextEditingController(text: val);
        } else {
          controllers[key].text = val;
        }
      });
      _completer.complete(doc);
    } else if (document is IDataDocument) {
      initial?.forEach((key, value) {
        if (isEmpty(key)) return;
        if (!controllers.containsKey(key)) {
          controllers[key] = TextEditingController(text: value ?? Const.empty);
        } else {
          controllers[key].text = value ?? Const.empty;
        }
      });
      document?.forEach((key, value) {
        if (isEmpty(key)) return;
        String val = filter != null && filter.containsKey(key)
            ? filter[key](value.data)
            : value.data?.toString() ?? Const.empty;
        if (!controllers.containsKey(key)) {
          controllers[key] = TextEditingController(text: val);
        } else {
          controllers[key].text = val;
        }
      });
    }
  }
}
