part of masamune.flutter;

/// Loads the data document for a page.
IDataDocument usePageDocument() {
  return PathMap.get<IDataDocument>(DefaultPath.pageData) ??
      TemporaryDocument();
}
