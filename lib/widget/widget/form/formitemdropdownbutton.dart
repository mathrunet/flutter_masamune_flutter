import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'formitem.dart';

/// Widget that displays a dropdown button and generates an action when tapped.
class FormItemDropdownButton extends StatelessWidget implements FormItem {
  /// Action when tapped.
  final VoidAction onTap;

  /// Action when long pressed.
  final VoidAction onLongPress;

  /// Text edit controller.
  final TextEditingController controller;

  /// First value.
  final String initialValue;

  /// Input form decoration.
  final Decoration decoration;

  /// True if enabled.
  final bool enabled;

  /// Widget that displays a dropdown button and generates an action when tapped.
  ///
  /// [onTap]: Action when tapped.
  /// [onLongPress]: Action when long pressed.
  /// [controller]: Text edit controller.
  /// [initialValue]: First value.
  /// [decoration]: Input form decoration.
  FormItemDropdownButton(
      {@required this.onTap,
      this.controller,
      this.enabled = true,
      this.initialValue,
      this.onLongPress,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        onLongPress: this.enabled ? this.onLongPress : null,
        onTap: this.enabled ? this.onTap : null,
        child: Container(
          height: 60,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(12),
          decoration: this.decoration ??
              BoxDecoration(
                border: Border.all(color: context.theme.disabledColor),
                borderRadius: BorderRadius.circular(4.0),
              ),
          child: Stack(alignment: Alignment.centerLeft, children: [
            Text(this.controller?.text ?? this.initialValue ?? Const.empty,
                style: context.theme.inputDecorationTheme.helperStyle.copyWith(
                    color: this.enabled ? null : context.theme.disabledColor)),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down,
                  color: this.enabled ? null : context.theme.disabledColor),
            )
          ]),
        ),
      ),
    );
  }
}
