part of masamune.flutter;

/// Abstract class for creating pages.
///
/// It is inherited and used by the class that displays the page.
///
/// Scaffold is built in by default, and the provided method is overridden and used.
///
/// Normally, please override body.
///
/// Please inherit and use.
abstract class UIPage extends UIWidget with UIPageDataMixin {
  /// Abstract class for creating pages.
  ///
  /// [key]: Widget key.
  UIPage({Key key}) : super(key: key, child: null);

  /// Creating a body.
  ///
  /// [context]: Build context.
  @protected
  Widget body(BuildContext context) {
    return null;
  }

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => context.unfocus(), child: this.body(context));
  }

  /// Gets the UIValue of current page.
  static UIValue get current => _current;
  static UIValue _current;
}