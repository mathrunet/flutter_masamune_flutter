import 'package:flutter/material.dart';

/// List item.
class ListItem extends StatelessWidget {
  /// Leading widget for items.
  final Widget leading;

  /// The title of the item.
  final Widget title;

  /// The text of the item.
  final Widget text;

  /// Title indent.
  final int indent;

  /// List trailing.
  final Widget trailing;

  /// Horizontal size of the text side.
  final double textWidth;

  /// List item.
  ///
  /// [leading]: Leading widget for items.
  /// [title]: The title of the item.
  /// [text]: The text of the item.
  /// [indent]: Title indent.
  /// [trailing]: List trailing.
  ListItem(
      {this.leading,
      @required this.title,
      this.text,
      this.indent = 0,
      this.trailing,
      this.textWidth = 200});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: this.leading,
      title: Row(children: [
        Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.only(left: 20 * this.indent.toDouble()),
                child: this.title ?? Container())),
        Container(
            width: this.text == null ? 0 : this.textWidth,
            child: this.text ?? Container())
      ]),
      trailing: this.trailing,
    );
  }
}
