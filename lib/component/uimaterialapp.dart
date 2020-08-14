part of masamune.flutter;

/// Widget which extended [MaterialApp] for Path.
class UIMaterialApp extends UIWidget {
  /// Widget which extended [MaterialApp] for Path.
  UIMaterialApp(
      {BuildEvent load,
      BuildEvent unload,
      BuildEvent pause,
      BuildEvent unpause,
      BuildEvent quit,
      Key key,
      String flavor,
      WidgetBuilder home,
      GlobalKey<NavigatorState> navigatorKey,
      Map<String, RouteConfig> routes = const <String, RouteConfig>{},
      String initialRoute,
      List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
      String title = '',
      RouteFactory onGenerateTitle,
      RouteConfig onUnknownRoute,
      RouteConfig onBootRoute,
      Color color,
      ThemeColor theme,
      ThemeColor darkTheme,
      ThemeMode themeMode = ThemeMode.system,
      Locale locale,
      Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
      Locale Function(List<Locale>, Iterable<Locale>)
          localeListResolutionCallback,
      Locale Function(Locale, Iterable<Locale>) localeResolutionCallback,
      Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')],
      bool debugShowMaterialGrid = false,
      bool showPerformanceOverlay = false,
      bool checkerboardRasterCacheImages = false,
      bool checkerboardOffscreenLayers = false,
      bool showSemanticsDebugger = false,
      bool debugShowCheckedModeBanner = true})
      : super(
            load: load,
            unload: unload,
            pause: (context) {
              if (pause != null) pause(context);
              PathMap.onApplicationPause(true);
            },
            unpause: (context) {
              if (unpause != null) pause(context);
              PathMap.onApplicationPause(false);
            },
            quit: (context) {
              if (quit != null) quit(context);
              PathMap.onApplicationQuit();
            },
            child: (context) {
              RouteConfig._initialize(routes);
              return FlavorScope(
                  flavor: flavor,
                  child: MaterialApp(
                      key: key,
                      navigatorKey: navigatorKey,
                      home: home != null ? home(context) : null,
                      onGenerateRoute: home != null
                          ? null
                          : (settings) =>
                              RouteConfig._onGenerateRoute(settings),
                      onGenerateInitialRoutes: home != null
                          ? null
                          : (initialRouteName) =>
                              RouteConfig._onGenerateInitialRoute(
                                  initialRouteName,
                                  boot: onBootRoute),
                      navigatorObservers: [
                        if (navigatorObservers != null) ...navigatorObservers,
                        UIValue.routeObserver,
                        UIRouteObserver()
                      ],
                      builder: null,
                      title: title,
                      onUnknownRoute: onUnknownRoute == null
                          ? null
                          : (settings) => RouteConfig._onSingleRoute(
                              settings, onUnknownRoute),
                      color: color,
                      theme: theme?.toThemeData(),
                      darkTheme: darkTheme?.toThemeData(),
                      themeMode: themeMode,
                      localizationsDelegates: localizationsDelegates,
                      localeListResolutionCallback:
                          localeListResolutionCallback,
                      localeResolutionCallback: localeResolutionCallback,
                      supportedLocales: supportedLocales,
                      debugShowMaterialGrid: debugShowMaterialGrid,
                      showPerformanceOverlay: showPerformanceOverlay,
                      checkerboardRasterCacheImages:
                          checkerboardRasterCacheImages,
                      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
                      showSemanticsDebugger: showSemanticsDebugger,
                      debugShowCheckedModeBanner: debugShowCheckedModeBanner));
            });
}

/// Widget to get the flavor.
///
/// You can get the widget with [FlavorScope.of(context)].
class FlavorScope extends InheritedWidget {
  /// Widget to get the flavor.
  ///
  /// You can get the widget with [FlavorScope.of(context)].
  ///
  /// [key]: Key.
  /// [flavor]: Flavor.
  /// [child]: Child widget.
  const FlavorScope({
    Key key,
    this.flavor,
    Widget child,
  }) : super(key: key, child: child);

  /// Get FlavorScope.
  ///
  /// You can check the current Flavor setting.
  static FlavorScope of(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType()?.widget;
  }

  /// Flavor.
  final String flavor;

  /// True to build on update.
  ///
  /// [oldWidget]: Previous widget.
  @override
  bool updateShouldNotify(FlavorScope oldWidget) {
    return true;
  }
}
