import 'dart:async';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mix-in that provides the ability to handle forms.
///
/// Pass a [formKey] as the key to the [Form] widget.
///
/// Use [controller()] to get the controller of the form and store all changed values in [form].
///
/// Run [validate(context)] at the time of applying the changes to check if the values are correct.
///
/// Finally, save all changes to the specified document by running [save()].
mixin UIPageFormMixin on UIPage {
  /// Key for form.
  final formKey = GlobalKey<FormState>();

  /// Define the controller.
  ///
  /// You can enter an initial value in [initialText].
  TextEditingController textEditingController([String initialText]) {
    return useTextEditingController(text: initialText);
  }

  /// Data for the form.
  IDataDocument get form => this._form;
  final _form = DataDocument(DefaultPath.formData);

  /// Validate the data in the form.
  ///
  /// Returns True if the validation is successful.
  ///
  /// If you enter a value in [initial], you can set it to the initial value.
  bool validate(BuildContext context, {Map<String, dynamic> initial}) {
    context.unfocus();
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
          document[tmp.key] = tmp.value;
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
          target[tmp.key] = tmp.value;
        }
      }
      await target.save();
      return target;
    }
    return null;
  }
}
