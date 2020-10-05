part of masamune.list;

/// Headline with an image in the background.
class ImageHeadline extends StatelessWidget {
  /// Height.
  final double height;

  /// Image border color.
  final double dividerColor;

  /// Image.
  final ImageProvider image;

  /// Headline label.
  final String label;

  /// Label color.
  final Color labelColor;

  /// Label outline color.
  final Color outlineColor;

  /// The size of the label outline.
  final double outlineWidth;

  /// Font size.
  final double fontSize;

  /// Font weight.
  final FontWeight fontWeight;

  /// Padding.
  final EdgeInsetsGeometry padding;

  /// Headline with an image in the background.
  ImageHeadline(
      {this.height = 50,
      this.dividerColor,
      @required this.image,
      @required this.label,
      this.outlineWidth = 2,
      this.fontSize = 18,
      this.outlineColor,
      this.labelColor,
      this.padding,
      this.fontWeight = FontWeight.bold});

  /// Build widget.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.height,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: this.dividerColor ?? context.theme.dividerColor,
                    width: 1),
                bottom: BorderSide(
                    color: this.dividerColor ?? context.theme.dividerColor,
                    width: 1)),
            image: DecorationImage(image: this.image, fit: BoxFit.cover)),
        alignment: Alignment.bottomLeft,
        padding: this.padding ??
            const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: BorderedText(
            strokeWidth: this.outlineWidth,
            strokeColor:
                this.outlineColor ?? context.theme.colorScheme.onBackground,
            child: Text(this.label,
                style: TextStyle(
                    color:
                        this.labelColor ?? context.theme.colorScheme.background,
                    fontSize: this.fontSize,
                    fontWeight: this.fontWeight))));
  }
}
