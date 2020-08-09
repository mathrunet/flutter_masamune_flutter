import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masamune_core/masamune_core.dart';
import 'package:masamune_flutter/widget/widget/dropdowntextformfield.dart';
import 'formitem.dart';

class LabeledDropdownFieldFormItem extends FormItem {
  final TextEditingController controller;
  final String labelText;
  final Map<String, String> items;
  final Widget prefix;
  final Widget suffix;
  final void Function(String value) onSave;
  final void Function(String value) onChanged;

  LabeledDropdownFieldFormItem(
      {@required this.controller,
      @required this.items,
      this.labelText = "",
      this.prefix,
      this.suffix,
      this.onSave,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).disabledColor),
            borderRadius: BorderRadius.circular(4.0)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4.5),
        child: Row(children: [
          Expanded(flex: 4, child: Text(this.labelText)),
          Flexible(
              flex: 1,
              child: DropdownTextFormField(
                  controller: this.controller,
                  items: this.items,
                  style: TextStyle(
                      fontSize: 20, color: Colors.black, height: 1.25),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      prefix: this.prefix,
                      suffix: this.suffix),
                  autovalidate: false,
                  onChanged: (value) {
                    if (this.onChanged != null) this.onChanged(value);
                  },
                  onSaved: (value) {
                    if (isEmpty(value)) return;
                    if (this.onSave != null) this.onSave(value);
                  }))
        ]));
  }
}
