part of masamune.flutter;

/// Key to specify the path.
class UIValueKey extends ValueKey<String> {
  /// Key to specify the path.
  ///
  /// [path]: The path to use as the key.
  UIValueKey(String path) : super(path?.applyTags());
}
