part of masamune.flutter;

/// Abstract class that adds a State to [HookWidget] and
/// allows it to perform operations on load,
/// destruction, application termination, and when a widget is pushed or popped.
///
/// Inherit and use to create a widget with pass-list functionality.
///
/// Please use StatelessWidget below this.
///
/// You can use Hooks just like normal HookWidget.
abstract class UIHookWidget extends StatefulHookWidget {
  /// Root observer.
  ///
  /// ```
  /// return new MaterialApp(
  ///   ...
  ///   navigatorObservers: <NavigatorObserver>[UIHookWidget.routeObserver],
  ///   ...
  /// );
  /// ```
  static RouteObserver<PageRoute> get routeObserver => _routeObserver;
  static RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

  final BuildEvent _load;
  final BuildEvent _unload;
  final WidgetBuilder _child;
  final BuildEvent _pause;
  final BuildEvent _unpause;
  final BuildEvent _quit;
  final BuildEvent _didPush;
  final BuildEvent _didPushNext;
  final BuildEvent _didPop;
  final BuildEvent _didPopNext;
  final ValidateEvent _validateOnLoad;

  /// Abstract class that adds a State to [HookWidget] and
  /// allows it to perform operations on load,
  /// destruction, application termination, and when a widget is pushed or popped.
  ///
  /// Inherit and use to create a widget with pass-list functionality.
  ///
  /// Please use StatelessWidget below this.
  ///
  /// You can use Hooks just like normal HookWidget.
  ///
  /// [key]: Widget key.
  /// [load]: Callback for widget loading.
  /// [unload]: Callback for Widget unloading.
  /// [child]: Callback when creating a widget.
  /// [pause]: Callback for Application paused.
  /// [unpause]: Callback for Application unpaused.
  /// [quit]: Callback for Application quit.
  /// [didPop]: Callback when the widget is pop.
  /// [didPush]: Callback when the widget is push.
  /// [didPopNext]: Callback when the next widget is pop.
  /// [didPushNext]: Callback when the next widget is push.
  /// [validateOnLoad]: Verification callback before loading.
  const UIHookWidget(
      {Key key,
      BuildEvent load,
      BuildEvent unload,
      BuildEvent pause,
      BuildEvent unpause,
      BuildEvent quit,
      BuildEvent didPop,
      BuildEvent didPush,
      BuildEvent didPopNext,
      BuildEvent didPushNext,
      ValidateEvent validateOnLoad,
      WidgetBuilder child})
      : this._load = load,
        this._unload = unload,
        this._pause = pause,
        this._unpause = unpause,
        this._quit = quit,
        this._didPop = didPop,
        this._didPush = didPush,
        this._didPopNext = didPopNext,
        this._didPushNext = didPushNext,
        this._validateOnLoad = validateOnLoad,
        this._child = child,
        super(key: key);

  /// Create a state.
  ///
  /// Do not use from outside.
  @override
  @protected
  State createState() => _UIHookWidgetState();

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  Widget build(BuildContext context);

  /// Executed when the widget is loaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onLoad(BuildContext context) {}

  /// Executed when the widget is unloaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onUnload(BuildContext context) {}

  /// Executed when the widget is pause.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onPause(BuildContext context) {}

  /// Executed when the widget is unpause.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onUnpause(BuildContext context) {}

  /// Executed when the widget is quit.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onQuit(BuildContext context) {}

  /// Verification callback before loading.
  ///
  /// Error if the string is not null.
  /// Output the character string as an error.
  ///
  /// [context]: Build context.
  @protected
  String validateOnLoad(BuildContext context) => null;

  /// Executed when the widget is push.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void didPush(BuildContext context) {}

  /// Executed when the widget is pop.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void didPop(BuildContext context) {}

  /// Executed when the next widget is push.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void didPushNext(BuildContext context) {}

  /// Executed when the next widget is pop.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void didPopNext(BuildContext context) {}
}

class _UIHookWidgetState extends State<UIHookWidget>
    with WidgetsBindingObserver, RouteAware {
  /// True if the widget is valid.
  bool get enabled => this._enabled;
  bool _enabled = true;
  bool _markRebuild = false;
  Widget _cache;
  @override
  void initState() {
    super.initState();
    this.widget._load?.call(this.context);
    this.widget.onLoad(this.context);
    String error = this._validateOnLoad(this.context);
    if (isNotEmpty(error)) {
      UIDialog.show(this.context, text: error);
      return;
    }
    WidgetsBinding.instance.addObserver(this);
  }

  String _validateOnLoad(BuildContext context) {
    String error = this.widget._validateOnLoad?.call(context);
    if (isNotEmpty(error)) return error;
    return this.widget.validateOnLoad(this.context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModalRoute route = ModalRoute.of(this.context);
    if (route == null) return;
    UIHookWidget.routeObserver.subscribe(this, route);
  }

  @override
  void dispose() {
    super.dispose();
    this.widget._unload?.call(context);
    this.widget.onUnload(context);
    WidgetsBinding.instance.removeObserver(this);
    UIHookWidget.routeObserver.unsubscribe(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        this.widget._quit?.call(this.context);
        this.widget.onQuit(this.context);
        break;
      case AppLifecycleState.paused:
        this.widget._pause?.call(this.context);
        this.widget.onPause(this.context);
        break;
      case AppLifecycleState.resumed:
        this.widget._unpause?.call(this.context);
        this.widget.onUnpause(this.context);
        break;
      default:
        break;
    }
  }

  @override
  void didPop() {
    this.widget._didPop?.call(this.context);
    this.widget.didPop(this.context);
  }

  @override
  void didPopNext() {
    this._enabled = true;
    if (this._markRebuild) {
      this.setState(() {});
      this._markRebuild = false;
    }
    this.widget._didPopNext?.call(this.context);
    this.widget.didPopNext(this.context);
  }

  @override
  void didPushNext() {
    this._enabled = false;
    this.widget._didPushNext?.call(this.context);
    this.widget.didPushNext(this.context);
  }

  @override
  void didPush() {
    this._enabled = true;
    this.widget._didPush?.call(this.context);
    this.widget.didPush(this.context);
  }

  @override
  Widget build(BuildContext context) {
    if (!this.enabled && this._cache != null) {
      this._markRebuild = true;
      return this._cache;
    }
    if (this.widget._child != null)
      return this._cache = this.widget._child(context);
    return this._cache = this.widget.build(context);
  }
}
