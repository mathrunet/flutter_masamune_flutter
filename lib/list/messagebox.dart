part of masamune.list;

/// Display a message box.
///
/// Please use it for notes of each item.
class MessageBox extends StatelessWidget {
  /// Text content.
  final String text;

  /// Icon.
  final IconData icon;

  /// Color. The whole color changes.
  final Color color;

  /// Processing when tapped.
  final Function onTap;

  /// Display a message box.
  ///
  /// Please use it for notes of each item.
  ///
  /// [text]: Text content.
  /// [icon]: Icon.
  /// [color]: Color. The whole color changes.
  /// [onTap]: Processing when tapped.
  MessageBox(this.text, {this.icon = Icons.info, this.color, this.onTap})
      : assert(text != null);

  /// Build method.
  ///
  /// [BuildContext]: Build Context.
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
            onTap: this.onTap,
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: this.color ?? context.theme.colorScheme.error,
                        width: 2),
                    borderRadius: BorderRadius.circular(4.0),
                    color: (this.color ?? context.theme.colorScheme.error)
                        .withOpacity(0.12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (this.icon != null) ...[
                      Icon(Icons.info,
                          color: this.color ?? context.theme.colorScheme.error),
                      Space.width(15),
                    ],
                    Flexible(
                        child: Text(this.text,
                            style: TextStyle(
                                color: this.color ??
                                    context.theme.colorScheme.error,
                                fontWeight: FontWeight.bold)))
                  ],
                ))));
  }
}
