import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'formitem.dart';

class SubmitFormItem extends StatelessWidget implements FormItem {
  final Widget label;
  final VoidAction onPressed;
  SubmitFormItem({this.label, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FlatButton(
            padding: const EdgeInsets.all(10),
            color: context.theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: this.label,
            onPressed: this.onPressed));
  }
}
