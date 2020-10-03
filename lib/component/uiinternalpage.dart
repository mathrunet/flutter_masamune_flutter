part of masamune.flutter;

/// Used to display a page within a page.
///
/// Please inherit and use it.
abstract class UIInternalPage extends UIHookPage {
  /// Route monitoring observer.
  final InternalNavigatorObserver routeObserver = InternalNavigatorObserver();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// Keys for the navigator.
  NavigatorState get navigator => this._navigatorKey?.currentState;

  /// Used to display a page within a page.
  ///
  /// [key]: Widget key.
  UIInternalPage({Key key}) : super(key: key);

  /// Executed when the widget is loaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  void onLoad(BuildContext context) {
    super.onLoad(context);
    RouteConfig._initialize(this.routes);
  }

  /// The name of the first route on the page.
  String get initialRoute;

  /// Setting up a route.
  Map<String, RouteConfig> get routes;

  /// Page when a route name is specified that is not defined in the route.
  RouteConfig get onUnknownRoute => null;

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => context.unfocus(),
        child: this.applySafeArea
            ? SafeArea(child: this.body(context))
            : this.body(context));
  }

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (this.navigator.canPop()) {
          this.navigator.pop();
          return false;
        }
        return true;
      },
      child: Navigator(
        key: this._navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: (settings) => RouteConfig._onGenerateRoute(settings),
        onGenerateInitialRoutes: (state, initialRouteName) {
          return [
            UIPageRoute(
                builder: routes.containsKey(initialRouteName)
                    ? routes[initialRouteName]?.builder
                    : onUnknownRoute?.builder,
                settings: RouteSettings(
                    name: initialRouteName,
                    arguments: ModalRoute.of(context).settings.arguments))
          ];
        },
        observers: [this.routeObserver, UIRouteObserver()],
        onUnknownRoute: this.onUnknownRoute != null
            ? (settings) => RouteConfig._onSingleRoute(settings, onUnknownRoute)
            : null,
      ),
    );
  }
}

/// Observer to be able to catch the navigation movement inside.
///
/// You can describe what to do
/// when the internal page changes by [subscribe] and listen for changes.
class InternalNavigatorObserver extends NavigatorObserver {
  final List<void Function(Route route)> _listener = [];

  /// Listen for new route changes.
  ///
  /// [callback]: Callbacks to subscribe.
  void subscribe(void Function(Route route) callback) {
    if (callback == null || this._listener.contains(callback)) return;
    this._listener.add(callback);
  }

  /// Unlisten for new route changes.
  ///
  /// [callback]: Callbacks to unsubscribe.
  void unsubscribe(void Function(Route route) callback) {
    if (callback == null || !this._listener.contains(callback)) return;
    this._listener.remove(callback);
  }

  /// The [Navigator] replaced oldRoute with newRoute.
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    this._listener?.forEach((element) => element?.call(newRoute));
  }

  /// The [Navigator] pushed route.
  ///
  /// The route immediately below that one, and thus the previously active route, is previousRoute.
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    this._listener?.forEach((element) => element?.call(route));
  }

  /// The [Navigator] popped route.
  ///
  /// The route immediately below that one, and thus the newly active route, is previousRoute.
  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    this._listener?.forEach((element) => element?.call(previousRoute));
  }
}
