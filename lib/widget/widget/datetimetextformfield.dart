import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

/// Date and time selection form that can be handled like TextField.
class DateTimeTextFormField extends StatelessWidget {
  /// Calculate DateTime from [millisecondsSinceEpoch].
  static DateTime value(int millisecondsSinceEpoch) {
    return millisecondsSinceEpoch == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }

  /// Picker definition that selects only dates.
  static Future<DateTime> Function(BuildContext, DateTime) datePicker(
      {DateTime startDate, DateTime currentDate, DateTime endDate}) {
    return (context, dateTime) async {
      final date = await showDatePicker(
          context: context,
          firstDate: startDate ?? DateTime.now().subtract(Duration(days: 365)),
          initialDate: currentDate ?? DateTime.now(),
          lastDate: endDate ?? DateTime.now().add(Duration(days: 365)));
      return date;
    };
  }

  /// Definition of a picker to select time.
  static Future<DateTime> Function(BuildContext, DateTime) timePicker(
      {DateTime currentTime}) {
    return (context, dateTime) async {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentTime ?? DateTime.now()),
      );
      return DateTimeField.combine(DateTime.now(), time);
    };
  }

  /// Picker definition that selects the date and time.
  static Future<DateTime> Function(BuildContext, DateTime) dateTimePicker(
      {DateTime startDate, DateTime current, DateTime endDate}) {
    return (context, dateTime) async {
      final date = await showDatePicker(
          context: context,
          firstDate: startDate ?? DateTime.now().subtract(Duration(days: 365)),
          initialDate: current ?? DateTime.now(),
          lastDate: endDate ?? DateTime.now().add(Duration(days: 365)));
      if (date != null) {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(current ?? DateTime.now()),
        );
        return DateTimeField.combine(date, time);
      } else {
        return current ?? DateTime.now();
      }
    };
  }

  /// Date and time selection form that can be handled like TextField.
  DateTimeTextFormField({
    @required this.format,
    @required this.onShowPicker,
    Key key,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidate = false,
    this.enabled = true,
    this.resetIcon = const Icon(Icons.close),
    this.onChanged,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.readOnly = true,
    this.showCursor,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLengthEnforced = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.buildCounter,
  }) : super(key: key);
  final DateFormat format;
  final Future<DateTime> Function(BuildContext context, DateTime currentValue)
      onShowPicker;
  final Icon resetIcon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;
  final void Function(DateTime value) onChanged;
  final FormFieldSetter<DateTime> onSaved;
  final FormFieldValidator<DateTime> validator;
  final DateTime initialValue;
  final bool autovalidate;
  final bool enabled;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool showCursor;
  final bool obscureText;
  final bool autocorrect;
  final bool maxLengthEnforced;
  final int maxLines;
  final int minLines;
  final bool expands;
  final int maxLength;
  final VoidCallback onEditingComplete;
  final ValueChanged<DateTime> onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
        format: this.format,
        onShowPicker: this.onShowPicker,
        onSaved: this.onSaved,
        validator: this.validator,
        initialValue: this.initialValue,
        autovalidate: this.autovalidate,
        enabled: this.enabled,
        resetIcon: this.resetIcon,
        onChanged: this.onChanged,
        controller: this.controller,
        focusNode: this.focusNode,
        decoration: this.decoration,
        keyboardType: this.keyboardType,
        textCapitalization: this.textCapitalization,
        textInputAction: this.textInputAction,
        style: this.style,
        strutStyle: this.strutStyle,
        textDirection: this.textDirection,
        textAlign: this.textAlign,
        autofocus: this.autofocus,
        readOnly: this.readOnly,
        showCursor: this.showCursor,
        obscureText: this.obscureText,
        autocorrect: this.autocorrect,
        maxLengthEnforced: this.maxLengthEnforced,
        maxLines: this.maxLines,
        minLines: this.minLines,
        expands: this.expands,
        maxLength: this.maxLength,
        onEditingComplete: this.onEditingComplete,
        onFieldSubmitted: this.onFieldSubmitted,
        inputFormatters: this.inputFormatters,
        cursorWidth: this.cursorWidth,
        cursorRadius: this.cursorRadius,
        cursorColor: this.cursorColor,
        keyboardAppearance: this.keyboardAppearance,
        scrollPadding: this.scrollPadding,
        enableInteractiveSelection: this.enableInteractiveSelection,
        buildCounter: this.buildCounter);
  }
}
