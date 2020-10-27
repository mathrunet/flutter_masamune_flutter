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

  /// Headline leagding widget.
  final Widget leading;

  /// Vertical placement.
  final CrossAxisAlignment crossAxisAlignment;

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
  /// [leading]: Headline leagding widget.
  /// [tailing]: Headline tailing widget.
  /// [color]: Text / Icon color.
  /// [crossAxisAlignment]: Vertical placement.
  /// [backgroundColor]: Background color.
  /// [padding]: Padding.
  Headline(this.title,
      {this.margin,
      this.elevation,
      this.icon,
      this.tailing,
      this.color,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.leading,
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
              crossAxisAlignment: this.crossAxisAlignment,
              children: <Widget>[
                if (this.icon != null) ...[
                  Icon(this.icon,
                      color: this.color ?? context.theme.backgroundColor),
                  Space.width(20),
                ],
                if (this.leading != null) ...[
                  this.leading,
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
