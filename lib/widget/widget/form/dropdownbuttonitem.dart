import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'formitem.dart';

/// Widget that displays a dropdown button and generates an action when tapped.
class DropdownButtonItem extends StatelessWidget implements FormItem {
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

  /// Widget that displays a dropdown button and generates an action when tapped.
  ///
  /// [onTap]: Action when tapped.
  /// [onLongPress]: Action when long pressed.
  /// [controller]: Text edit controller.
  /// [initialValue]: First value.
  /// [decoration]: Input form decoration.
  DropdownButtonItem(
      {@required this.onTap,
      this.controller,
      this.initialValue,
      this.onLongPress,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        onLongPress: this.onLongPress,
        onTap: this.onTap,
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
                style: context.theme.inputDecorationTheme.helperStyle),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            )
          ]),
        ),
      ),
    );
  }
}
