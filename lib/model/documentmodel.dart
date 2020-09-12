part of masamune.flutter;

/// Model for creating a document.
abstract class DocumentModel<T extends IDataDocument> extends Model<T> {
  /// Reads the value while monitoring it.
  ///
  /// [context]: Build context.
  T watch(BuildContext context) {
    DocumentModel<T> field = context.watch<DocumentModel<T>>(this.context.path);
    return field?.data;
  }

  /// Reads the value.
  ///
  /// [context]: Build context.
  T read(BuildContext context) {
    DocumentModel<T> field = context.read<DocumentModel<T>>(this.context.path);
    return field?.data;
  }

  /// True. if the value exists.
  ///
  /// [context]: Build context.
  bool exist(BuildContext context) {
    DocumentModel<T> field = PathMap.get<DocumentModel<T>>(this.context.path);
    return field?.data != null;
  }

  /// Get the number of elements of the value.
  ///
  /// [context]: Build context.
  int length(BuildContext context) {
    DocumentModel<T> field = PathMap.get<DocumentModel<T>>(this.context.path);
    if (field?.data == null) return 0;
    return field.data.length;
  }
}
