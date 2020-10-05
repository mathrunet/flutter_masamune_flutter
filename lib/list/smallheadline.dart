part of masamune.list;

/// Small-Headline widget.
class SmallHeadline extends StatelessWidget {
  /// Small-Headline margin.
  final EdgeInsetsGeometry margin;

  /// Icon data.
  final IconData icon;

  /// Headline title.
  final String title;

  /// Small-Headline widget.
  ///
  /// [margin]: Headline margin.
  /// [icon]: Icon data.
  /// [title]: Headline title.
  SmallHeadline(this.title, {this.margin, this.icon});

  /// Build method.
  ///
  /// [BuildContext]: Build Context.
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: this.margin ?? const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
            color: context.theme.disabledColor,
            borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (this.icon != null) ...[
            Icon(this.icon, size: 16, color: context.theme.backgroundColor),
            Space.width(8),
          ],
          Text(
            this.title,
            style: TextStyle(color: context.theme.backgroundColor),
          )
        ]));
  }
}
