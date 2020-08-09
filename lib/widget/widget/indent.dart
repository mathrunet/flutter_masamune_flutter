import 'package:flutter/material.dart';

/// Indent in the list.
class Indent extends StatelessWidget {
  /// List of widgets to indent.
  final List<Widget> children;

  /// Indent size.
  final double indent;

  /// Indent in the list.
  ///
  /// [children]: List of widgets to indent.
  /// [width]: Indent size.
  Indent({@required this.children, this.indent = 20});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: this.indent),
        child: Column(
          children: this.children,
        ));
  }
}
