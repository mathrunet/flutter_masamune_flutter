part of masamune.flutter;

/// Define a query for routing.
///
/// You can pass it as [arguments] with [pageNamed()] and so on.
class RouteQuery {
  final bool _fullscreen;
  final bool _immediately;
  final IDataDocument _data;

  /// Define a query for routing.
  ///
  /// You can pass it as [arguments] with [pageNamed()] and so on.
  ///
  /// [fullscreen]: True when transitioning pages in full screen.
  /// [immediately]: True if transitioning immediately without animation.
  /// [data]: Data for routing.
  const RouteQuery(
      {bool fullscreen = false, bool immediately = false, IDataDocument data})
      : this._fullscreen = fullscreen,
        this._immediately = immediately,
        this._data = data;

  /// View the page as a full screen.
  static RouteQuery get fullscreen => const RouteQuery(fullscreen: true);

  /// Display the page with no animation.
  static RouteQuery get immediately => const RouteQuery(immediately: true);
}
