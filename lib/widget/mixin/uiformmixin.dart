import 'dart:async';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

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
  ///
  /// If you enter a value in [initial], you can set it to the initial value.
  bool validate({Map<String, dynamic> initial}) {
    if (this.formKey == null || this.formKey.currentState == null) return false;
    if (!this.formKey.currentState.validate()) return false;
    this._form.clear();
    initial?.forEach((key, value) {
      if (isEmpty(key) || value == null) return;
      this._form[key] = value;
    });
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
  ///
  /// Data can be processed by using [filter].
  ///
  /// You can save additional data by defining [additional].
  Future<IDataDocument> save(FutureOr<IDataDocument> target,
      {List<String> whiteList,
      List<String> blackList,
      Map<String, Future<dynamic> Function(dynamic value)> filter,
      Map<String, dynamic> additional}) async {
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
        var data = tmp.value.data;
        if (filter != null && filter.containsKey(tmp.key))
          data = await filter[tmp.key](data);
        document[tmp.key] = data;
      }
      if (additional != null) {
        for (MapEntry<String, dynamic> tmp in additional.entries) {
          if (isEmpty(tmp.key)) continue;
          if (tmp.value is String) {
            document[tmp.key] = (tmp.value as String).applyTags();
          } else {
            document[tmp.key] = tmp.value;
          }
        }
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
        var data = tmp.value.data;
        if (filter != null && filter.containsKey(tmp.key))
          data = await filter[tmp.key](data);
        target[tmp.key] = data;
      }
      if (additional != null) {
        for (MapEntry<String, dynamic> tmp in additional.entries) {
          if (isEmpty(tmp.key)) continue;
          if (tmp.value is String) {
            target[tmp.key] = (tmp.value as String).applyTags();
          } else {
            target[tmp.key] = tmp.value;
          }
        }
      }
      await target.save();
      return target;
    }
    return null;
  }
}
