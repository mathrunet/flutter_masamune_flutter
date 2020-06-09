part of masamune.flutter;

/// Class for recording route information.
class RouteConfig {
  /// Route builder.
  final WidgetBuilder builder;

  /// True to launch in full screen.
  final bool fullScreen;

  /// Map for rerouting according to conditions.
  ///
  /// Enter the redirect path in [String] and enter the condition in the callback.
  ///
  /// If the condition is true, redirect.
  final Map<String, bool Function()> reroute;

  /// Regular expression for the root path.
  RegExp get regex => this._regex;
  RegExp _regex;

  /// Key list for the path.
  List<String> get keys => this._keys;
  List<String> _keys = ListPool.get();

  /// Class for recording route information.
  ///
  /// [builder]: Route builder.
  /// [fullScreen]: True to launch in full screen.
  /// [reroute]: Map for rerouting according to conditions.
  RouteConfig(this.builder, {this.fullScreen = false, this.reroute = const {}});

  static final RegExp _keyRegex = RegExp(r"\{([^\}]+)\}");
  static Map<String, RouteConfig> _routes = MapPool.get();
  static void _initialize(Map<String, RouteConfig> configs) {
    configs?.forEach((key, value) {
      if (isEmpty(key) || value == null) return;
      if (_routes.containsKey(key)) return;
      value.keys.clear();
      key = key.replaceAllMapped(_keyRegex, (match) {
        value.keys.add(match.group(1));
        return r"([^\{\}\/]+?)";
      });
      value._regex = RegExp(r"^" + key + r"$");
      _routes[key] = value;
    });
  }

  static Route _onSingleRoute(RouteSettings settings, RouteConfig config) {
    if (settings == null || config == null) return null;
    IDataDocument document;
    if (settings.arguments is IDataDocument) {
      document = settings.arguments as IDataDocument;
    } else {
      document = DataDocument(DefaultPath.pageData);
      document.clear();
    }
    for (MapEntry<String, bool Function()> reroute in config.reroute.entries) {
      if (isEmpty(reroute.key) || reroute.value == null) continue;
      if (!reroute.value()) continue;
      document["redirect_to"] = settings.name;
      return _onGenerateRoute(
          settings.copyWith(name: reroute.key, arguments: settings.arguments));
    }
    document["redirect_to"] = settings.name;
    return UIPageRoute(
        builder: config.builder,
        settings: settings.copyWith(name: settings.name, arguments: document));
  }

  static List<Route> _onGenerateInitialRoute(String initialRouteName,
      {RouteConfig boot}) {
    if (boot == null) return null;
    IDataDocument document = DataDocument(DefaultPath.pageData);
    document["redirect_to"] = initialRouteName;
    return [
      UIPageRoute(
          builder: boot.builder,
          settings: RouteSettings(name: initialRouteName, arguments: document))
    ];
  }

  static Route _onGenerateRoute(RouteSettings settings,
      {String authenticationRoute,
      bool Function(BuildContext context) onCheckAuthentication}) {
    if (_routes == null || _routes.length <= 0) return null;
    String path = settings.name.applyTags();
    Uri uri = Uri.parse(path);
    path = Const.slash + uri.path.trimString(Const.slash);
    for (MapEntry<String, RouteConfig> tmp in _routes.entries) {
      RegExpMatch match = tmp.value.regex.firstMatch(path);
      if (match == null) continue;
      IDataDocument document;
      if (settings.arguments is IDataDocument) {
        document = settings.arguments as IDataDocument;
      } else {
        document = DataDocument(DefaultPath.pageData);
        document.clear();
      }
      for (MapEntry<String, bool Function()> reroute
          in tmp.value.reroute.entries) {
        if (isEmpty(reroute.key) || reroute.value == null) continue;
        if (!reroute.value()) continue;
        document["redirect_to"] = settings.name;
        return _onGenerateRoute(settings.copyWith(
            name: reroute.key, arguments: settings.arguments));
      }
      uri.queryParameters
          ?.forEach((key, value) => document[key] = value ?? Const.empty);
      for (int i = 0; i < match.groupCount; i++) {
        if (tmp.value.keys.length <= i) continue;
        document[tmp.value.keys[i]] = match.group(i + 1) ?? Const.empty;
      }
      return UIPageRoute(
          builder: tmp.value.builder,
          settings: settings.copyWith(name: settings.name, arguments: document),
          fullscreenDialog:
              document.containsKey("fullscreen") || tmp.value.fullScreen);
    }
    return null;
  }
}
