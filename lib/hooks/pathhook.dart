part of masamune.flutter;

/// You can use the Collection only within HookWidget.
///
/// It is possible to specify an initial value by specifying [initialData].
///
/// You can sort by specifying [orderBy], [orderByKey].
/// You can also specify [thenBy] and [thenByKey] to further sort the elements in the same order in the first sort.
T usePath<T extends Object>(String path, [T defaultValue]) {
  BuildContext context = useContext();
  return context?.watch<T>(path, defaultValue: defaultValue);
}
