part of masamune.list;

/// Button for list.
class ListButton extends StatelessWidget {
  /// Button margin.
  final EdgeInsetsGeometry margin;

  /// Button padding.
  final EdgeInsetsGeometry padding;

  /// The title of the button.
  final String title;

  /// The background color.
  final Color backgroundColor;

  /// Text color.
  final Color color;

  /// The action when the button is pressed.
  final VoidAction onPressed;

  /// Button for list.
  ///
  /// [margin]: Button margin.
  /// [padding]: Button padding.
  /// [title]: The title of the button.
  /// [color]: Text color.
  /// [backgroundColor]: List trailing.
  /// [onPressed]: The action when the button is pressed.
  ListButton(
      {this.margin,
      @required this.title,
      this.padding,
      this.backgroundColor,
      this.color,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: this.margin ?? const EdgeInsets.all(10),
        child: FlatButton(
          padding: this.padding,
          color: this.backgroundColor ?? context.theme.primaryColor,
          onPressed: this.onPressed,
          child: Text(this.title,
              style: TextStyle(
                  color: this.color ?? context.theme.backgroundColor)),
        ));
  }
}
