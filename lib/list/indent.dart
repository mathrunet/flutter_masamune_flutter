part of masamune.list;

/// Indent in the list.
class Indent extends StatelessWidget {
  /// List of widgets to indent.
  final List<Widget> children;

  /// Indent size.
  final double indent;

  /// Specifies all padding.
  final EdgeInsetsGeometry padding;

  /// Column crossAxisAlignment.
  final CrossAxisAlignment crossAxisAlignment;

  /// Column mainAxisAlignment.
  final MainAxisAlignment mainAxisAlignment;

  /// Column mainAxisSize.
  final MainAxisSize mainAxisSize;

  /// Indent in the list.
  ///
  /// [children]: List of widgets to indent.
  /// [width]: Indent size.
  /// [padding]: Specifies all padding.
  Indent(
      {@required this.children,
      this.indent = 20,
      this.padding,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.min});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: this.padding ?? EdgeInsets.only(left: this.indent),
        child: Column(
          crossAxisAlignment: this.crossAxisAlignment,
          mainAxisAlignment: this.mainAxisAlignment,
          mainAxisSize: this.mainAxisSize,
          children: this.children,
        ));
  }
}
