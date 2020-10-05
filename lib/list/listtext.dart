part of masamune.list;

/// Text-only list.
class ListText extends StatelessWidget {
  /// Text.
  final Widget text;

  /// Processing when tapped.
  final Function onTap;

  /// Text-only list.
  ///
  /// [text]: Text.
  /// [onTap]: Processing when tapped.
  ListText({this.text, this.onTap});

  /// Build method.
  ///
  /// [BuildContext]: Build Context.
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.subtitle1,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: InkWell(onTap: this.onTap, child: this.text)));
  }
}
