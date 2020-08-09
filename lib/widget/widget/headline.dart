import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Headline widget.
class Headline extends StatelessWidget {
  /// Headline margin.
  final EdgeInsetsGeometry margin;

  /// Headline height.
  final double elevation;

  /// Icon data.
  final IconData icon;

  /// Headline title.
  final String title;

  /// Headline widget.
  ///
  /// [margin]: Headline margin.
  /// [elevation]: Headline height.
  /// [icon]: Icon data.
  /// [title]: Headline title.
  Headline(this.title, {this.margin, this.elevation, this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(0),
        elevation: 8,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: context.theme.accentColor,
            child: Row(
              children: <Widget>[
                if (this.icon != null) ...[
                  Icon(this.icon, color: context.theme.backgroundColor),
                  Space.width(20),
                ],
                Text(this.title,
                    style: TextStyle(
                        color: context.theme.backgroundColor, fontSize: 20))
              ],
            )));
  }
}
