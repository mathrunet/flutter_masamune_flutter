import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:masamune_core/masamune_core.dart';
import 'package:masamune_flutter/widget/widget/datetimetextformfield.dart';
import 'formitem.dart';

class DateTimeFieldFormItem extends FormItem {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final String hintText;
  final String labelText;
  final String counterText;
  final Widget prefix;
  final Widget suffix;
  final bool readOnly;
  final bool obscureText;
  final DateTime initialDateTime;
  final DateFormat _format;
  final DateTimeFieldFormItemPickerType type;
  final Future<DateTime> Function(BuildContext, DateTime) _onShowPicker;
  final void Function(DateTime value) onSave;

  Future<DateTime> Function(BuildContext, DateTime) get onShowPicker {
    if (this._onShowPicker != null) return this._onShowPicker;
    switch (this.type) {
      case DateTimeFieldFormItemPickerType.date:
        return DateTimeTextFormField.datePicker();
      case DateTimeFieldFormItemPickerType.time:
        return DateTimeTextFormField.timePicker();
      default:
        return DateTimeTextFormField.dateTimePicker();
    }
  }

  DateFormat get format {
    if (this._format != null) return this._format;
    switch (this.type) {
      case DateTimeFieldFormItemPickerType.date:
        return DateFormat("yyyy/MM/dd(E)");
      case DateTimeFieldFormItemPickerType.time:
        return DateFormat("HH:mm:ss");
      default:
        return DateFormat("yyyy/MM/dd(E) HH:mm:ss");
    }
  }

  DateTimeFieldFormItem(
      {@required this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLength = 100,
      this.maxLines = 1,
      this.minLines = 1,
      this.hintText = "",
      this.labelText = "",
      this.counterText = "",
      this.prefix,
      this.suffix,
      this.readOnly = false,
      this.obscureText = false,
      this.type = DateTimeFieldFormItemPickerType.dateTime,
      @required this.initialDateTime,
      DateFormat format,
      Future<DateTime> onShowPicker(BuildContext context, DateTime dateTime),
      this.onSave})
      : this._format = format,
        this._onShowPicker = onShowPicker {
    if (this.controller == null) return;
    this.controller.text = this.format == null
        ? this.initialDateTime.toIso8601String()
        : this.format.format(this.initialDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: DateTimeTextFormField(
          controller: this.controller,
          keyboardType: TextInputType.text,
          initialValue: this.initialDateTime,
          maxLength: this.maxLength,
          maxLines: this.maxLines,
          minLines: this.minLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: this.hintText,
            counterText: this.counterText,
            labelText: this.labelText,
            prefix: this.prefix,
            suffix: this.suffix,
          ),
          obscureText: this.obscureText,
          readOnly: this.readOnly,
          format: this.format,
          autovalidate: false,
          validator: (value) {
            if (isEmpty(value)) return this.hintText;
            return null;
          },
          onSaved: (value) {
            if (isEmpty(value)) return;
            if (this.onSave != null) this.onSave(value);
          },
          onShowPicker:
              this.onShowPicker ?? DateTimeTextFormField.dateTimePicker(),
        ));
  }
}

enum DateTimeFieldFormItemPickerType { date, time, dateTime }
