part of masamune.flutter;

/// Used to display a page within a page.
///
/// Please inherit and use it.
abstract class UIInternalPage extends UIHookPage {
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

  /// Observer for the root.
  List<NavigatorObserver> get observers => null;

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
        observers: [
          if (this.observers != null) ...this.observers,
        ],
        onUnknownRoute: this.onUnknownRoute != null
            ? (settings) => RouteConfig._onSingleRoute(settings, onUnknownRoute)
            : null,
      ),
    );
  }
}
