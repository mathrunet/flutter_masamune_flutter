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
      ThemeData theme,
      ThemeData darkTheme,
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
              return MaterialApp(
                  key: key,
                  navigatorKey: navigatorKey,
                  home: home != null ? home(context) : null,
                  onGenerateRoute: home != null
                      ? null
                      : (settings) => RouteConfig._onGenerateRoute(settings),
                  onGenerateInitialRoutes: home != null
                      ? null
                      : (initialRouteName) =>
                          RouteConfig._onGenerateInitialRoute(initialRouteName,
                              boot: onBootRoute),
                  navigatorObservers: navigatorObservers != null
                      ? List<NavigatorObserver>.from(navigatorObservers)
                          .insertLast(UIValue.routeObserver)
                      : [UIValue.routeObserver],
                  builder: null,
                  title: title,
                  onUnknownRoute: onUnknownRoute == null
                      ? null
                      : (settings) =>
                          RouteConfig._onSingleRoute(settings, onUnknownRoute),
                  color: color,
                  theme: theme,
                  darkTheme: darkTheme,
                  themeMode: themeMode,
                  localizationsDelegates: localizationsDelegates,
                  localeListResolutionCallback: localeListResolutionCallback,
                  localeResolutionCallback: localeResolutionCallback,
                  supportedLocales: supportedLocales,
                  debugShowMaterialGrid: debugShowMaterialGrid,
                  showPerformanceOverlay: showPerformanceOverlay,
                  checkerboardRasterCacheImages: checkerboardRasterCacheImages,
                  checkerboardOffscreenLayers: checkerboardOffscreenLayers,
                  showSemanticsDebugger: showSemanticsDebugger,
                  debugShowCheckedModeBanner: debugShowCheckedModeBanner);
            });
}
