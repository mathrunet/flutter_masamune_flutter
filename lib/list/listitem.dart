part of masamune.list;

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

  /// List tile dense.
  final bool dense;

  /// List tile padding.
  final EdgeInsetsGeometry padding;

  /// Processing when tapped.
  final Function onTap;

  /// List item.
  ///
  /// [leading]: Leading widget for items.
  /// [title]: The title of the item.
  /// [text]: The text of the item.
  /// [indent]: Title indent.
  /// [dense]: List tile dense.
  /// [padding]: List tile padding.
  /// [trailing]: List trailing.
  /// [onTap]: Processing when tapped.
  ListItem(
      {this.leading,
      this.onTap,
      @required this.title,
      this.text,
      this.dense = false,
      this.padding,
      this.indent = 0,
      this.trailing,
      this.textWidth = 200});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: this.leading,
      dense: this.dense,
      onTap: this.onTap,
      contentPadding: this.padding,
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
