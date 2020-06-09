part of masamune.flutter;

/// NavigatorState extension methods.
extension NavigatorStateExtension on NavigatorState {
  /// Pops the page to the page with the specified path.
  ///
  /// [name]: Page path.
  Future popUntilNamed(String name) async {
    if (isEmpty(name)) return null;
    name = name.applyTags();
    this.popUntil((route) {
      return route.settings.name.applyTags() == name;
    });
  }
}
