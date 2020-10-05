part of masamune.list;

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

  /// Headline tailing widget.
  final Widget tailing;

  /// Background color.
  final Color backgroundColor;

  /// Text / Icon color.
  final Color color;

  /// Padding.
  final EdgeInsetsGeometry padding;

  /// Headline widget.
  ///
  /// [margin]: Headline margin.
  /// [elevation]: Headline height.
  /// [icon]: Icon data.
  /// [title]: Headline title.
  /// [tailing]: Headline tailing widget.
  /// [color]: Text / Icon color.
  /// [backgroundColor]: Background color.
  /// [padding]: Padding.
  Headline(this.title,
      {this.margin,
      this.elevation,
      this.icon,
      this.tailing,
      this.color,
      this.backgroundColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(0),
        elevation: 8,
        child: Container(
            padding: this.padding ??
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: this.backgroundColor ?? context.theme.accentColor,
            child: Row(
              children: <Widget>[
                if (this.icon != null) ...[
                  Icon(this.icon,
                      color: this.color ?? context.theme.backgroundColor),
                  Space.width(20),
                ],
                Expanded(
                    child: Text(this.title,
                        style: TextStyle(
                            color: this.color ?? context.theme.backgroundColor,
                            fontSize: 20))),
                if (this.tailing != null) this.tailing
              ],
            )));
  }
}
