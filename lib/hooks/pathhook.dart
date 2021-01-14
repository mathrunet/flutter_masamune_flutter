part of masamune.flutter;

/// Use this when you want to use a pathmap object.
///
/// [T] can be a primitive object or a class that inherits from [IPath].
///
/// Enter the path of the object you want to retrieve in [path],
/// and specify a default value if the object is not found in [defaultValue].
T usePath<T extends Object>(String path, [T defaultValue]) {
  BuildContext context = useContext();
  return context?.watch<T>(path, defaultValue: defaultValue);
}
