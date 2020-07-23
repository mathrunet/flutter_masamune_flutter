import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masamune_core/masamune_core.dart';
import 'formitem.dart';

class TextFieldFormItem extends FormItem {
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
  final void Function(String value) onSave;

  TextFieldFormItem(
      {@required this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLength = 100,
      this.maxLines = 1,
      this.minLines = 1,
      this.hintText = "",
      this.labelText = "",
      this.prefix,
      this.suffix,
      this.readOnly = false,
      this.obscureText = false,
      this.counterText = "",
      this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
            controller: this.controller,
            keyboardType: TextInputType.text,
            maxLength: this.maxLength,
            maxLines: this.maxLines,
            minLines: this.minLines,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: this.hintText,
              labelText: this.labelText,
              counterText: this.counterText,
              prefix: this.prefix,
              suffix: this.suffix,
            ),
            obscureText: this.obscureText,
            readOnly: this.readOnly,
            autovalidate: false,
            validator: (value) {
              if (isEmpty(value)) return this.hintText;
              return null;
            },
            onSaved: (value) {
              if (isEmpty(value)) return;
              if (this.onSave != null) this.onSave(value);
            }));
  }
}
