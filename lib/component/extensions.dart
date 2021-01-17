part of masamune.flutter;

/// BuildContext extension methods.
extension BuildContextExtension on BuildContext {
  void refresh() {
    UIPage.of(this)?.refresh();
  }

  /// Outputs the theme related to the context.
  ThemeData get theme => Theme.of(this);

  /// Get the Navigator related to context.
  NavigatorState get navigator => Navigator.of(this);

  /// Get the Root navigator related to context.
  NavigatorState get rootNavigator => Navigator.of(this, rootNavigator: true);

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
  TPath watchWidget(BuildContext context) {
    if (this == null) return this;
    UIPage.of(context)?._addListener(this);
    return this;
  }

  /// Set to dispose when the widget related to [context] is destroyed.
  ///
  /// [context]: BuildContext.
  TPath willDispose(BuildContext context) {
    UIPage.of(context)?.willDisposePathList?.add(this);
    return this;
  }
}

/// Extension methods of IPath.
extension IPathFutureExtension<TPath extends IPath> on Future<TPath> {
  /// Listen for the path with the Widget.
  ///
  /// [context]: BuildContext.
  Future<TPath> watchWidget(BuildContext context) {
    this?.then((value) {
      if (value == null) return value;
      UIPage.of(context)?._addListener(value);
      return value;
    });
    return this;
  }

  /// Set to dispose when the widget related to [context] is destroyed.
  ///
  /// [context]: BuildContext.
  Future<TPath> willDispose(BuildContext context) {
    if (this == null) return this;
    UIPage.of(context)?.willDisposePathList?.add(this);
    return this;
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
