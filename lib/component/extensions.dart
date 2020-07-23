part of masamune.flutter;

/// BuildContext extension methods.
extension BuildContextExtension on BuildContext {
  /// Forces the widget to update.
  void refresh() {
    UIValue value = UIValue.of(this);
    if (value == null) return;
    value.refresh();
  }

  /// Get object from pathmap in conjunction with UIWidget.
  ///
  /// You can get any IPath object other than String.
  ///
  /// Please use it for update processing in the widget.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  T watch<T extends Object>(String path, {T defaultValue, T filter(T value)}) {
    UIValue value = UIValue.of(this);
    if (value == null)
      return filter != null ? filter(defaultValue) : defaultValue;
    return value.watch<T>(path, defaultValue: defaultValue, filter: filter);
  }

  /// Get object from pathmap in conjunction with UIWidget.
  ///
  /// You can get any IPath object other than String.
  ///
  /// Please use it for update processing in the widget.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  T read<T extends Object>(String path, {T defaultValue, T filter(T value)}) {
    UIValue value = UIValue.of(this);
    if (value == null)
      return filter != null ? filter(defaultValue) : defaultValue;
    return value.read<T>(path, defaultValue: defaultValue, filter: filter);
  }

  /// Get text from pathmap in conjunction with UIWidget.
  ///
  /// Displays anything as long as Path is Unit and can be converted to text.
  ///
  /// If not, [defaultValue] will be displayed.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  String watchText(String path,
      {String defaultValue = Const.empty, String filter(String value)}) {
    UIValue value = UIValue.of(this);
    if (value == null)
      return filter != null ? filter(defaultValue) : defaultValue;
    return value.watchText(path, defaultValue: defaultValue, filter: filter);
  }

  /// Get text from pathmap in conjunction with UIWidget.
  ///
  /// Displays anything as long as Path is Unit and can be converted to text.
  ///
  /// If not, [defaultValue] will be displayed.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  String readText(String path,
      {String defaultValue = Const.empty, String filter(String value)}) {
    UIValue value = UIValue.of(this);
    if (value == null)
      return filter != null ? filter(defaultValue) : defaultValue;
    return value.readText(path, defaultValue: defaultValue, filter: filter);
  }

  /// Get localized text from pathmap in conjunction with UIWidget.
  ///
  /// Displays anything as long as Path is Unit and can be converted to text.
  ///
  /// If not, [defaultValue] will be displayed.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  String watchLocalized(String path,
      {String defaultValue = Const.empty, String filter(String value)}) {
    UIValue value = UIValue.of(this);
    if (value == null) {
      return filter != null
          ? filter(defaultValue?.localize())
          : defaultValue?.localize();
    }
    return value.watchLocalized(path,
        defaultValue: defaultValue, filter: filter);
  }

  /// Get localized text from pathmap in conjunction with UIWidget.
  ///
  /// Displays anything as long as Path is Unit and can be converted to text.
  ///
  /// If not, [defaultValue] will be displayed.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  String readLocalized(String path,
      {String defaultValue = Const.empty, String filter(String value)}) {
    UIValue value = UIValue.of(this);
    if (value == null) {
      return filter != null
          ? filter(defaultValue?.localize())
          : defaultValue?.localize();
    }
    return value.readLocalized(path,
        defaultValue: defaultValue, filter: filter);
  }

  /// Get number from pathmap in conjunction with UIWidget.
  ///
  /// Displays anything as long as Path is Unit and can be converted to double.
  ///
  /// If not, [defaultValue] will be displayed.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  double watchNumber(
    String path, {
    double defaultValue = 0,
    double filter(double value),
  }) {
    UIValue value = UIValue.of(this);
    if (value == null)
      return filter != null ? filter(defaultValue) : defaultValue;
    return value.watchNumber(path, defaultValue: defaultValue, filter: filter);
  }

  /// Get number from pathmap in conjunction with UIWidget.
  ///
  /// Displays anything as long as Path is Unit and can be converted to double.
  ///
  /// If not, [defaultValue] will be displayed.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  double readNumber(
    String path, {
    double defaultValue = 0,
    double filter(double value),
  }) {
    UIValue value = UIValue.of(this);
    if (value == null)
      return filter != null ? filter(defaultValue) : defaultValue;
    return value.readNumber(path, defaultValue: defaultValue, filter: filter);
  }

  /// Get boolean flag from pathmap in conjunction with UIWidget.
  ///
  /// Displays anything as long as Path is Unit and can be converted to double.
  ///
  /// If not, [defaultValue] will be displayed.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  bool watchBoolean(String path,
      {bool defaultValue = false, bool filter(bool value)}) {
    UIValue value = UIValue.of(this);
    if (value == null)
      return filter != null ? filter(defaultValue) : defaultValue;
    return value.watchBoolean(path, defaultValue: defaultValue, filter: filter);
  }

  /// Get boolean flag from pathmap in conjunction with UIWidget.
  ///
  /// Displays anything as long as Path is Unit and can be converted to double.
  ///
  /// If not, [defaultValue] will be displayed.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  bool readBoolean(String path,
      {bool defaultValue = false, bool filter(bool value)}) {
    UIValue value = UIValue.of(this);
    if (value == null)
      return filter != null ? filter(defaultValue) : defaultValue;
    return value.readBoolean(path, defaultValue: defaultValue, filter: filter);
  }

  /// Get the action callback from pathmap in conjunction with UIWidget.
  ///
  /// If it does not exist, the action that does nothing is called.
  ///
  /// [path]: The path to get.
  /// [defaultAction]: Default callback when no value exists in path.
  VoidAction watchAction(String path, {VoidAction defaultAction}) {
    UIValue value = UIValue.of(this);
    if (value == null) return defaultAction ?? () {};
    return value.watchAction(path, defaultAction: defaultAction);
  }

  /// Get the action callback from pathmap in conjunction with UIWidget.
  ///
  /// If it does not exist, the action that does nothing is called.
  ///
  /// [path]: The path to get.
  /// [defaultAction]: Default callback when no value exists in path.
  VoidAction readAction(String path, {VoidAction defaultAction}) {
    UIValue value = UIValue.of(this);
    if (value == null) return defaultAction ?? () {};
    return value.readAction(path, defaultAction: defaultAction);
  }

  /// Writes the value to the specified path.
  ///
  /// It is possible to enter one of the [value] is
  /// [bool], [int], [double], [String], [Map<String, dynamic>].
  ///
  /// [Map] the case of [DataDocument] other than the [DataField] will be saved as.
  ///
  /// [path]: The path to write.
  /// [value]: The value to write.
  void write<T extends Object>(String path, T value) {
    assert(value != null);
    if (value == null) return;
    if (value is bool || value is double || value is int || value is String) {
      DataField(path, value);
    } else if (value is Map<String, dynamic>) {
      DataDocument.fromMap(path, value);
    } else if (!(value is IPath)) {
      WidgetData<T>(path, this, value);
    }
  }

  /// Get the object given by [provider].
  ///
  /// Be sure to define the type.
  T consume<T extends Object>() {
    UIValue value = UIValue.of(this);
    if (value == null) return null;
    return value.consume<T>();
  }

  /// True if the next data is available.
  ///
  /// The next data is acquired by [next()].
  ///
  /// [path]: The target path.
  /// The path object must be [IDataCollection].
  bool canNext(String path) {
    assert(path != null);
    if (path == null) return false;
    return this.watch<IDataCollection>(path)?.canNext() ?? false;
  }

  /// Outputs the theme related to the context.
  ThemeData get theme => Theme.of(this);

  /// Get the form data.
  IDataDocument get form => UIValue.of(this).form;

  /// Set the form data.
  set form(IDataDocument document) => UIValue.of(this)._form = document;

  /// Get the Navigator related to context.
  NavigatorState get navigator => Navigator.of(this);

  /// Get the Flavor.
  String get flavor => FlavorScope.of(this)?.flavor;

  /// Get the data passed to the page.
  IDataDocument get data =>
      (ModalRoute.of(this)?.settings?.arguments as IDataDocument) ??
      TemporaryDocument();

  /// Get the media qury related to context
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Releases focus such as text field.
  void unfocus() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}

/// Extension methods of IPath.
extension IPathExtension<TPath extends IPath> on TPath {
  /// Listen for the path with the Widget.
  ///
  /// [context]: BuildContext.
  TPath listenWidget(BuildContext context) {
    if (this == null) return this;
    context.watch(this.path);
    return this;
  }

  /// Set to dispose when the widget related to [context] is destroyed.
  ///
  /// [context]: BuildContext.
  TPath willDispose(BuildContext context) {
    UIValue.of(context).willDisposePathList.add(this);
    return this;
  }
}

/// Extension methods of IPath.
extension IPathFutureExtension<TPath extends IPath> on Future<TPath> {
  /// Listen for the path with the Widget.
  ///
  /// [context]: BuildContext.
  Future<TPath> listenWidget(BuildContext context) {
    this?.then((value) {
      if (value == null) return value;
      context.watch(value?.path);
      return value;
    });
    return this;
  }

  /// Set to dispose when the widget related to [context] is destroyed.
  ///
  /// [context]: BuildContext.
  Future<TPath> willDispose(BuildContext context) {
    if (this == null) return this;
    UIValue.of(context).willDisposePathList.add(this);
    return this;
  }
}

/// Extension methods of Future<IDataDocument>.
extension IDataDocumentFutureExtension<TDocument extends IDataDocument>
    on Future<TDocument> {
  /// Fill the form with data.
  ///
  /// [context]: BuildContext.
  Future<TDocument> createForm(BuildContext context) {
    return this.then((document) {
      if (context == null) return document;
      context.form = document;
      return document;
    });
  }
}

/// Extension methods of IDataCollection
extension IDataCollectionExtension<TDocument extends IDataDocument>
    on IDataCollection<TDocument> {
  /// Set the items in the loop.
  ///
  /// [index]: Loop index number.
  /// [indexPath]: Index path that can be referenced in the loop.
  /// [documentPath]: Document path that can be referenced in the loop.
  /// [tapPath]: Tap action path that can be referenced in the loop.
  /// [longTapPath]: Long tap action path that can be referenced in the loop.
  /// [doubleTapPath]: Double tap action path that can be referenced in the loop.
  /// [onTap]: Action when tapped.
  /// [onLongTap]: Action when long-tapped.
  /// [onDoubleTap]: Action when double-tapped.
  void setLoop(int index,
      {String indexPath = DefaultPath.loopIndex,
      String documentPath = DefaultPath.loopItem,
      String tapPath = DefaultPath.loopTap,
      String longTapPath = DefaultPath.loopTapLong,
      String doubleTapPath = DefaultPath.loopTapDouble,
      VoidAction onTap,
      VoidAction onLongTap,
      VoidAction onDoubleTap}) {
    if (isEmpty(indexPath)) return;
    if (index < 0 || this.length <= index) return;
    IDataDocument document = this[index];
    if (document == null) return;
    DataField(indexPath, index);
    if (isNotEmpty(documentPath)) document.linkTo(documentPath);
    if (onTap != null && isNotEmpty(tapPath)) {
      DataField(tapPath, () {
        DataField(indexPath, index);
        if (isNotEmpty(documentPath)) document.linkTo(documentPath);
        onTap();
      });
    }
    if (onLongTap != null && isNotEmpty(longTapPath)) {
      DataField(longTapPath, () {
        DataField(indexPath, index);
        if (isNotEmpty(documentPath)) document.linkTo(documentPath);
        onLongTap();
      });
    }
    if (onDoubleTap != null && isNotEmpty(doubleTapPath)) {
      DataField(doubleTapPath, () {
        DataField(indexPath, index);
        if (isNotEmpty(documentPath)) document.linkTo(documentPath);
        onDoubleTap();
      });
    }
  }
}

/// Extension methods of IDataDocument.
extension IDataDocumentExtension<TField extends IDataField>
    on IDataDocument<TField> {
  /// Fill the form with data.
  ///
  /// [context]: BuildContext.
  IDataDocument<TField> createForm(BuildContext context) {
    if (context == null) return this;
    context.form = this;
    return this;
  }

  /// Set the items in the loop.
  ///
  /// [index]: Loop index number.
  /// [indexPath]: Index path that can be referenced in the loop.
  /// [documentPath]: Document path that can be referenced in the loop.
  /// [tapPath]: Tap action path that can be referenced in the loop.
  /// [longTapPath]: Long tap action path that can be referenced in the loop.
  /// [doubleTapPath]: Double tap action path that can be referenced in the loop.
  /// [onTap]: Action when tapped.
  /// [onLongTap]: Action when long-tapped.
  /// [onDoubleTap]: Action when double-tapped.
  void setLoop(int index,
      {String indexPath = DefaultPath.loopIndex,
      String documentPath = DefaultPath.loopItem,
      String tapPath = DefaultPath.loopTap,
      String longTapPath = DefaultPath.loopTapLong,
      String doubleTapPath = DefaultPath.loopTapDouble,
      VoidAction onTap,
      VoidAction onLongTap,
      VoidAction onDoubleTap}) {
    if (isEmpty(indexPath)) return;
    DataField(indexPath, index);
    if (isNotEmpty(documentPath)) this.linkTo(documentPath);
    if (onTap != null && isNotEmpty(tapPath)) {
      DataField(tapPath, () {
        DataField(indexPath, index);
        if (isNotEmpty(documentPath)) this.linkTo(documentPath);
        onTap();
      });
    }
    if (onLongTap != null && isNotEmpty(longTapPath)) {
      DataField(longTapPath, () {
        DataField(indexPath, index);
        if (isNotEmpty(documentPath)) this.linkTo(documentPath);
        onLongTap();
      });
    }
    if (onDoubleTap != null && isNotEmpty(doubleTapPath)) {
      DataField(doubleTapPath, () {
        DataField(indexPath, index);
        if (isNotEmpty(documentPath)) this.linkTo(documentPath);
        onDoubleTap();
      });
    }
  }
}

/// MediaQuery extension methods.
extension MediaQueryExtension on MediaQueryData {
  /// Calculate the size when dividing the horizontal length.
  ///
  /// Enter the actual number of elements in [count]
  /// and the maximum number to place horizontally in [maxHorizontalCount].
  ///
  /// [count]:　Element count.
  /// [maxHorizontalCount]: Maximum number of horizontal elements.
  double divisionWidth(int count, {int maxHorizontalCount = 5}) {
    if (count < 1) count = 1;
    if (maxHorizontalCount < 1) maxHorizontalCount = 1;
    double width = this.size.width;
    return (width / count).limitLow(width / maxHorizontalCount);
  }

  /// Calculate the size when dividing the vertical length.
  ///
  /// Enter the actual number of elements in [count]
  /// and the maximum number to place vertically in [maxVerticalCount].
  ///
  /// [count]:　Element count.
  /// [maxVerticalCount]: Maximum number of vertical elements.
  double divisionHeight(int count, {int maxVerticalCount = 5}) {
    if (count < 1) count = 1;
    if (maxVerticalCount < 1) maxVerticalCount = 1;
    double height = this.size.height;
    return (height / count).limitLow(height / maxVerticalCount);
  }
}
