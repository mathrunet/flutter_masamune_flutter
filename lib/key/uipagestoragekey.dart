part of masamune.flutter;

/// Key to specify the path.
class UIPageStorageKey extends PageStorageKey<String> {
  /// Key to specify the path.
  ///
  /// [path]: The path to use as the key.
  UIPageStorageKey(String path) : super(path?.applyTags());
}
