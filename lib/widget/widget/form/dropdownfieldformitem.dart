import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masamune_core/masamune_core.dart';
import 'package:masamune_flutter/widget/widget/dropdowntextformfield.dart';
import 'formitem.dart';

class DropdownFieldFormItem extends FormItem {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String counterText;
  final Map<String, String> items;
  final Widget prefix;
  final Widget suffix;
  final bool readOnly;
  final bool obscureText;
  final void Function(String value) onSave;

  DropdownFieldFormItem(
      {@required this.controller,
      this.hintText = "",
      @required this.items,
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
        child: DropdownTextFormField(
            controller: this.controller,
            items: this.items,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: this.hintText,
              labelText: this.labelText,
              counterText: this.counterText,
              prefix: this.prefix,
              suffix: this.suffix,
            ),
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
