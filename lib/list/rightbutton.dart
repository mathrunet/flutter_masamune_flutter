part of masamune.list;

/// Place button on the right.
///
/// Please use it in the list.
class RightButton extends StatelessWidget {
  /// What happens when a button is pressed.
  final Function onPressed;

  /// The collection path to read.
  final Color color;

  /// Button label.
  final String label;

  /// Place button on the right.
  ///
  /// Please use it in the list.
  RightButton(
      {this.color = Colors.blue,
      @required this.label,
      @required this.onPressed});

  /// Build method.
  ///
  /// [BuildContext]: Build Context.
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
            onPressed: this.onPressed,
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.all(0),
            child: Text(this.label, style: TextStyle(color: this.color))));
  }
}
