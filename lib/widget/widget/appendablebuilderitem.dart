import 'package:flutter/material.dart';

/// Item widget for AppendableBuilder.
class AppendableBuilderItem extends StatelessWidget {
  /// Icon data.
  final Icon icon;

  /// Child widget.
  final Widget child;

  /// What happens when a button is pressed.
  final Function onPressed;

  /// Item widget for AppendableBuilder.
  ///
  /// [icon]: Icon data.
  /// [child]: Child widget.
  /// [onPressed]: What happens when a button is pressed.
  AppendableBuilderItem({this.onPressed, this.child, this.icon})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(flex: 5, child: this.child),
      Flexible(
          flex: 1,
          child: Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: this.onPressed,
                  icon: this.icon ?? Icon(Icons.close))))
    ]);
  }
}
