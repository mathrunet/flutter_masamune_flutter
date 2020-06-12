part of masamune.flutter;

/// Class that manages values.
///
/// Please use in conjunction with UIWidget.
///
/// Usually used to get the value using [get()] and [text()].
class UIValue {
  /// Root observer.
  ///
  /// ```
  /// return new MaterialApp(
  ///   ...
  ///   navigatorObservers: <NavigatorObserver>[UIValue.routeObserver],
  ///   ...
  /// );
  /// ```
  static RouteObserver<PageRoute> get routeObserver => _routeObserver;
  static RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();
  UIWidgetState _state;

  /// List of Paths to dispose with when UIValue is disposed.
  PathList get willDisposePathList => this._willDisposePathList;
  PathList _willDisposePathList = PathList();
  Map<String, Observer> _data = MapPool.get();
  Map<String, dynamic> _cache = MapPool.get();
  UIValue._(UIWidgetState state) : this._state = state;
  _UIWidgetContainerState _container;
  IDataDocument _form;
  int _updatedTime = 0;

  /// The closest instance of this class that encloses the given context.
  ///
  /// Typical usage:
  ///
  /// ```dart
  /// UIValue controller = UIValue.of(context);
  /// ```
  ///
  /// [context]: Build context.
  static UIValue of(BuildContext context) {
    final _UIWidgetScope scope = context
        .getElementForInheritedWidgetOfExactType<_UIWidgetScope>()
        ?.widget;
    return scope?.target?._value;
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
  T watch<T extends Object>(String path, {T defaultValue, T filter(T value)}) {
    path = path?.applyTags();
    if (isEmpty(path)) {
      return filter != null
          ? filter(PathMap.get<T>(path) ?? defaultValue)
          : (PathMap.get<T>(path) ?? defaultValue);
    }
    this._addPath(path);
    return filter != null
        ? filter(PathMap.get<T>(path) ?? defaultValue)
        : (PathMap.get<T>(path) ?? defaultValue);
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
    path = path?.applyTags();
    if (isEmpty(path)) {
      return filter != null
          ? filter(PathMap.get<T>(path) ?? defaultValue)
          : (PathMap.get<T>(path) ?? defaultValue);
    }
    return filter != null
        ? filter(PathMap.get<T>(path) ?? defaultValue)
        : (PathMap.get<T>(path) ?? defaultValue);
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
          {String defaultValue = Const.empty, String filter(String value)}) =>
      filter != null
          ? filter(this.watch<dynamic>(path)?.toString() ?? defaultValue)
          : (this.watch<dynamic>(path)?.toString() ?? defaultValue);

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
          {String defaultValue = Const.empty, String filter(String value)}) =>
      filter != null
          ? filter(this.read<dynamic>(path)?.toString() ?? defaultValue)
          : (this.read<dynamic>(path)?.toString() ?? defaultValue);

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
          {String defaultValue = Const.empty, String filter(String value)}) =>
      filter != null
          ? filter(Localize.get(
              this.watch<dynamic>(path)?.toString() ?? defaultValue))
          : (Localize.get(
              this.watch<dynamic>(path)?.toString() ?? defaultValue));

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
          {String defaultValue = Const.empty, String filter(String value)}) =>
      filter != null
          ? filter(
              Localize.get(this.read<dynamic>(path)?.toString() ?? defaultValue))
          : (Localize.get(this.read<dynamic>(path)?.toString() ?? defaultValue));

  /// Get number from pathmap in conjunction with UIWidget.
  ///
  /// Displays anything as long as Path is Unit and can be converted to double.
  ///
  /// If not, [defaultValue] will be displayed.
  ///
  /// [path]: The path to get.
  /// [defaultValue]: Value if none.
  /// [filter]: Filter values.
  double watchNumber(String path,
      {double defaultValue = 0, double filter(double value)}) {
    dynamic tmp = this.watch<dynamic>(path);
    if (tmp is double) return filter != null ? filter(tmp) : tmp;
    if (tmp is int) return filter != null ? filter(tmp as double) : tmp as int;
    if (tmp is bool)
      return filter != null ? filter(tmp ? 1 : 0) : (tmp ? 1 : 0);
    if (tmp is String) {
      return filter != null
          ? filter(double.tryParse(tmp) ?? defaultValue)
          : (double.tryParse(tmp) ?? defaultValue);
    }
    return filter != null ? filter(defaultValue) : defaultValue;
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
  double readNumber(String path,
      {double defaultValue = 0, double filter(double value)}) {
    dynamic tmp = this.read<dynamic>(path);
    if (tmp is double) return filter != null ? filter(tmp) : tmp;
    if (tmp is int) return filter != null ? filter(tmp as double) : tmp as int;
    if (tmp is bool)
      return filter != null ? filter(tmp ? 1 : 0) : (tmp ? 1 : 0);
    if (tmp is String) {
      return filter != null
          ? filter(double.tryParse(tmp) ?? defaultValue)
          : (double.tryParse(tmp) ?? defaultValue);
    }
    return filter != null ? filter(defaultValue) : defaultValue;
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
    dynamic tmp = this.watch<dynamic>(path);
    if (tmp is bool) return filter != null ? filter(tmp) : tmp;
    if (tmp is double) return filter != null ? filter(tmp != 0) : tmp != 0;
    if (tmp is int) return filter != null ? filter(tmp != 0) : tmp != 0;
    if (tmp is String) {
      return filter != null
          ? filter(tmp.toLowerCase() == "true")
          : (tmp.toLowerCase() == "true");
    }
    return filter != null ? filter(defaultValue) : defaultValue;
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
    dynamic tmp = this.read<dynamic>(path);
    if (tmp is bool) return filter != null ? filter(tmp) : tmp;
    if (tmp is double) return filter != null ? filter(tmp != 0) : tmp != 0;
    if (tmp is int) return filter != null ? filter(tmp != 0) : tmp != 0;
    if (tmp is String) {
      return filter != null
          ? filter(tmp.toLowerCase() == "true")
          : (tmp.toLowerCase() == "true");
    }
    return filter != null ? filter(defaultValue) : defaultValue;
  }

  /// Get the action callback from pathmap in conjunction with UIWidget.
  ///
  /// If it does not exist, the action that does nothing is called.
  ///
  /// [path]: The path to get.
  /// [defaultAction]: Default callback when no value exists in path.
  VoidAction watchAction(String path, {VoidAction defaultAction}) {
    return this.watch<VoidAction>(path) ?? defaultAction ?? () {};
  }

  /// Get the action callback from pathmap in conjunction with UIWidget.
  ///
  /// If it does not exist, the action that does nothing is called.
  ///
  /// [path]: The path to get.
  /// [defaultAction]: Default callback when no value exists in path.
  VoidAction readAction(String path, {VoidAction defaultAction}) {
    return this.read<VoidAction>(path) ?? defaultAction ?? () {};
  }

  /// Get the form data.
  IDataDocument get form {
    if (this._form != null) return this._form;
    this._form = TemporaryDocument();
    return this._form;
  }

  /// Set the form data.
  set form(IDataDocument document) => this._form = document;

  /// Get the cache pool.
  Map<String, dynamic> get cache => this._cache;

  /// Gets the current context.
  BuildContext get context => this._container?.context;

  /// Gets the current widget.
  Widget get widget => this._state.widget;
  bool _containsPath(IPath path) {
    if (path == null) return false;
    UIValue parent = UIValue.of(this._state.context);
    if (parent != null && parent._containsPath(path)) return true;
    return this._data.containsKey(path.path);
  }

  void _addPath(String path) {
    if (isEmpty(path) || this._data.containsKey(path)) return;
    Observer observer = Observer();
    PathListener.listen(path, this._notifyUpdate, observer: observer);
    this._data[path] = observer;
    Log.ast("Add rebuild listener: %s (%s) %d at %s", [
      this._state.widget.runtimeType,
      this._state.widget.key?.toString(),
      this._updatedTime,
      path
    ]);
  }

  void _notifyUpdate(dynamic object) {
    if (object is IPath) {
      int updatedTime = object.asType<IPath>().updatedTime;
      if (this._updatedTime >= updatedTime) return;
      this._updatedTime = updatedTime;
    }
    this._state?._notifyUpdate(object);
  }

  void _dispose() {
    for (Observer tmp in this._data.values) tmp.dispose();
    this._willDisposePathList.dispose();
    this._data.release();
    this._cache.release();
    this._state = null;
  }
}
