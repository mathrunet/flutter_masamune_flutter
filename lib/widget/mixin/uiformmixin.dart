import 'dart:async';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'uitextfieldcontrollermixin.dart';

/// Mixins for using forms on pages.
abstract class UIFormMixin {
  /// Key for form.
  final formKey = GlobalKey<FormState>();

  /// Data for the form.
  IDataDocument get form => this._form;
  final _form = DataDocument(DefaultPath.formData);

  /// Validate the data in the form.
  ///
  /// Returns True if the validation is successful.
  bool validate() {
    if (this.formKey == null || this.formKey.currentState == null) return false;
    if (!this.formKey.currentState.validate()) return false;
    this._form.clear();
    this.formKey.currentState.save();
    return true;
  }

  /// Save the data in the form.
  ///
  /// Specify the target document data in[target].
  ///
  /// You give [whiteList] a list of keys, only those keys will be overwritten.
  ///
  /// You give [blackList] a list of keys, they will not be overwritten.
  Future<IDataDocument> save(FutureOr<IDataDocument> target,
      {List<String> whiteList, List<String> blackList}) async {
    if (this.formKey == null ||
        this.formKey.currentState == null ||
        this.form == null) return target;
    if (target is Future<IDataDocument>) {
      IDataDocument document = await target;
      for (MapEntry<String, IDataField> tmp in this.form.entries) {
        if (isEmpty(tmp.key) || tmp.value == null) continue;
        if (whiteList != null &&
            whiteList.length > 0 &&
            !whiteList.contains(tmp.key)) continue;
        if (blackList != null &&
            blackList.length > 0 &&
            blackList.contains(tmp.key)) continue;
        document[tmp.key] = tmp.value.data;
      }
      await document.save();
      return document;
    } else if (target is IDataDocument) {
      for (MapEntry<String, IDataField> tmp in this.form.entries) {
        if (isEmpty(tmp.key) || tmp.value == null) continue;
        if (whiteList != null &&
            whiteList.length > 0 &&
            !whiteList.contains(tmp.key)) continue;
        if (blackList != null &&
            blackList.length > 0 &&
            blackList.contains(tmp.key)) continue;
        target[tmp.key] = tmp.value.data;
      }
      await target.save();
      return target;
    }
    return null;
  }
}
