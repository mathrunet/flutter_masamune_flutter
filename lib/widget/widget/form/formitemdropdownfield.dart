import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masamune_core/masamune_core.dart';
import 'package:masamune_flutter/widget/widget/component/dropdowntextformfield.dart';
import 'formitem.dart';

class FormItemDropdownField extends StatelessWidget implements FormItem {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String counterText;
  final Map<String, String> items;
  final Widget prefix;
  final Widget suffix;
  final bool enabled;
  final void Function(String value) onSave;
  final void Function(String value) onChanged;

  FormItemDropdownField(
      {@required this.controller,
      this.hintText = "",
      @required this.items,
      this.enabled = true,
      this.labelText = "",
      this.prefix,
      this.suffix,
      this.counterText = "",
      this.onSave,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: DropdownTextFormField(
            controller: this.controller,
            items: this.items,
            enabled: this.enabled,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(17.5),
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
            onChanged: (value) {
              if (this.onChanged != null) this.onChanged(value);
            },
            onSaved: (value) {
              if (isEmpty(value)) return;
              if (this.onSave != null) this.onSave(value);
            }));
  }
}
