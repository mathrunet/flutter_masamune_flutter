part of masamune.flutter;

/// Class that inherits from [HookWidget].
/// You can treat it like a regular [HookWidget].
///
/// Please use StatelessWidget below this.
abstract class UIWidget extends HookWidget {
  /// Class that inherits from [HookWidget].
  /// You can treat it like a regular [HookWidget].
  ///
  /// Please use StatelessWidget below this.
  ///
  /// [key]: Key.
  const UIWidget({Key key}) : super(key: key);

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  Widget build(BuildContext context);
}
