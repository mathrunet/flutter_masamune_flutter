part of masamune.flutter;

/// Model for creating a document.
abstract class CollectionModel<T extends IDataCollection> extends Model<T> {
  /// Reads the value while monitoring it.
  ///
  /// [context]: Build context.
  T watch(BuildContext context) {
    CollectionModel<T> field =
        context.watch<CollectionModel<T>>(this.context.path);
    return field?.data;
  }

  /// Reads the value.
  ///
  /// [context]: Build context.
  T read(BuildContext context) {
    CollectionModel<T> field =
        context.read<CollectionModel<T>>(this.context.path);
    return field?.data;
  }

  /// True. if the value exists.
  ///
  /// [context]: Build context.
  bool exist(BuildContext context) {
    CollectionModel<T> field =
        PathMap.get<CollectionModel<T>>(this.context.path);
    return field?.data != null;
  }

  /// Get the number of elements of the value.
  ///
  /// [context]: Build context.
  int length(BuildContext context) {
    CollectionModel<T> field =
        PathMap.get<CollectionModel<T>>(this.context.path);
    if (field?.data == null) return 0;
    return field.data.length;
  }
}
