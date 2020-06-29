part of masamune.flutter;

/// Abstract class of widget including listening function equivalent to UIValue.
///
/// Inherit and use to create a widget with pass-list functionality.
///
/// Please use StatelessWidget below this.
///
/// In that case, the value can be obtained instantly by using [value.text()] or [value.get())].
abstract class UIWidget extends StatefulWidget {
  final BuildEvent _load;
  final BuildEvent _unload;
  final WidgetBuilder _child;
  final BuildEvent _pause;
  final BuildEvent _unpause;
  final BuildEvent _quit;
  final VoidAction _didPush;
  final VoidAction _didPushNext;
  final VoidAction _didPop;
  final VoidAction _didPopNext;
  final ValidateEvent _validateOnLoad;
  final List Function(BuildContext context) _provider;
  final bool Function(BuildContext context) _rebuildable;

  /// Abstract class of widget including listening function equivalent to UIValue.
  ///
  /// Inherit and use to create a widget with pass-list functionality.
  ///
  /// Please use StatelessWidget below this.
  ///
  /// In that case, the value can be obtained instantly by using [value.text()] or [value.get())].
  ///
  /// [key]: Widget key.
  /// [load]: Callback for widget loading.
  /// [unload]: Callback for Widget unloading.
  /// [child]: Callback when creating a widget.
  /// [pause]: Callback for Application paused.
  /// [unpause]: Callback for Application unpaused.
  /// [provider]: Save the object to UIValue.
  /// The saved value is getting by [context.consume<T>].
  /// [rebuildable]: Callback to determine if build is possible.
  /// [quit]: Callback for Application quit.
  /// [didPop]: Callback when the widget is pop.
  /// [didPush]: Callback when the widget is push.
  /// [didPopNext]: Callback when the next widget is pop.
  /// [didPushNext]: Callback when the next widget is push.
  /// [validateOnLoad]: Verification callback before loading.
  const UIWidget(
      {Key key,
      BuildEvent load,
      BuildEvent unload,
      BuildEvent pause,
      BuildEvent unpause,
      BuildEvent quit,
      VoidAction didPop,
      VoidAction didPush,
      VoidAction didPopNext,
      VoidAction didPushNext,
      ValidateEvent validateOnLoad,
      List provider(BuildContext context),
      bool rebuildable(BuildContext context),
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
        this._provider = provider,
        this._rebuildable = rebuildable,
        super(key: key);

  /// Create a state.
  ///
  /// Do not use from outside.
  @override
  @protected
  State createState() => UIWidgetState<UIWidget>();

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  Widget build(BuildContext context) => null;

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

  /// [provider]: Save the object to UIValue.
  ///
  /// The saved value is getting by [context.consume<T>].
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  List provider(BuildContext context) => [];

  /// Determines whether to build.
  ///
  /// True to build.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  bool rebuildable(BuildContext context) => true;

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
  @protected
  @mustCallSuper
  void didPush() {}

  /// Executed when the widget is pop.
  ///
  /// Override and use.
  @protected
  @mustCallSuper
  void didPop() {}

  /// Executed when the next widget is push.
  ///
  /// Override and use.
  @protected
  @mustCallSuper
  void didPushNext() {}

  /// Executed when the next widget is pop.
  ///
  /// Override and use.
  @protected
  @mustCallSuper
  void didPopNext() {}
}

/// State class for UIWidget.
///
/// Normally not used,
/// but if you want to use it with UIWidget inheritance, inherit it and use it.
class UIWidgetState<T extends UIWidget> extends State<T> {
  /// Executed when the widget is loaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onLoad(BuildContext context) {
    if (this.widget._load != null) this.widget._load(context);
    this.widget.onLoad(context);
  }

  /// Executed when the widget is unloaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onUnload(BuildContext context) {
    if (this.widget._unload != null) this.widget._unload(context);
    this.widget.onUnload(context);
  }

  Widget _build(BuildContext context) {
    if (this._cache != null &&
        (this._notifyObject == null || !this.rebuildable(context))) {
      this._notifyObject = null;
      return this._cache;
    }
    if (this._notifyObject is IPath) {
      Log.ast("Rebuild widget: %s (%s) (%s) %d by %s (%s)", [
        this.widget.runtimeType,
        this.widget.hashCode,
        this.widget.key?.toString(),
        this._value._updatedTime,
        this._notifyObject.asType<IPath>().path,
        this._notifyObject.runtimeType
      ]);
    } else {
      Log.ast("Rebuild widget: %s (%s) (%s) %d", [
        this.widget.runtimeType,
        this.widget.hashCode,
        this.widget.key?.toString(),
        this._value._updatedTime
      ]);
    }
    this._notifyObject = null;
    return this._cache = this.body(context);
  }

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  Widget body(BuildContext context) {
    if (this.widget._child != null) return this.widget._child(context);
    return this.widget.build(context);
  }

  /// Executed when the widget is pause.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onPause(BuildContext context) {
    if (this.widget._pause != null) this.widget._pause(context);
    this.widget.onPause(context);
  }

  /// Executed when the widget is unpause.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onUnpause(BuildContext context) {
    if (this.widget._unpause != null) this.widget._unpause(context);
    this.widget.onUnpause(context);
  }

  /// Executed when the widget is quit.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onQuit(BuildContext context) {
    if (this.widget._quit != null) this.widget._quit(context);
    this.widget.onQuit(context);
  }

  /// [provider]: Save the object to UIValue.
  ///
  /// The saved value is getting by [context.consume<T>].
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  List provider(BuildContext context) {
    return [
      ...this.widget.provider(context),
      if (this.widget._provider != null) ...this.widget._provider(context)
    ];
  }

  /// Determines whether to build.
  ///
  /// True to build.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  bool rebuildable(BuildContext context) {
    if (this.widget._rebuildable != null && this.widget._rebuildable(context))
      return true;
    return this.widget.rebuildable(context);
  }

  /// Verification callback before loading.
  ///
  /// Error if the string is not null.
  /// Output the character string as an error.
  ///
  /// [context]: Build context.
  String validateOnLoad(BuildContext context) {
    if (this.widget._validateOnLoad != null)
      return this.widget._validateOnLoad(context);
    return this.widget.validateOnLoad(context);
  }

  void _didPop() {
    if (this.widget._didPop != null) this.widget._didPop();
    this.widget.didPop();
  }

  void _didPush() {
    this._enabled = true;
    if (this.widget is UIPage) UIPage._current = this._value;
    if (this.widget._didPush != null) this.widget._didPush();
    this.widget.didPush();
  }

  void _didPopNext() {
    this._enabled = true;
    if (this._willUpdate != null) {
      this._notifyUpdate(this._willUpdate);
    }
    this._willUpdate = null;
    if (this.widget is UIPage) UIPage._current = this._value;
    if (this.widget._didPopNext != null) this.widget._didPopNext();
    this.widget.didPopNext();
  }

  void _didPushNext() {
    this._enabled = false;
    if (this.widget._didPushNext != null) this.widget._didPushNext();
    this.widget.didPushNext();
  }

  /// True if the widget is valid.
  bool get enabled => this._enabled;
  bool _enabled = true;
  bool _loaded = false;
  dynamic _willUpdate;

  /// Get the UIValue.
  UIValue get value => this._value;
  UIValue _value;
  Widget _cache;
  Object _notifyObject;
  void _refresh() => this.setState(() {});
  void _notifyUpdate(dynamic object) {
    if (!this.enabled) {
      this._willUpdate = object;
      return;
    }
    this._notifyObject = object;
    if (this._notifyObject is IPath) {
      if (UIValue.of(this.context)._containsPath(this._notifyObject)) return;
      Log.ast("Notify rebuild: %s (%s) (%s) %d by %s (%s)", [
        this.widget.runtimeType,
        this.widget.hashCode,
        this.widget.key?.toString(),
        this._value._updatedTime,
        this._notifyObject.asType<IPath>().path,
        this._notifyObject.runtimeType
      ]);
    } else {
      Log.ast("Notify rebuild: %s (%s) (%s) %d", [
        this.widget.runtimeType,
        this.widget.hashCode,
        this.widget.key?.toString(),
        this._value._updatedTime
      ]);
    }
    this.setState(() {});
  }

  /// State class for UIWidget.
  ///
  /// Normally not used,
  /// but if you want to use it with UIWidget inheritance, inherit it and use it.
  UIWidgetState() {
    this._value = UIValue._(this);
  }

  /// Callback for building.
  ///
  /// Do not override this method.
  /// Please use [body] instead.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return _UIWidgetScope(target: this, child: _UIWidgetContainer(this));
  }
}

class _UIWidgetScope extends InheritedWidget {
  const _UIWidgetScope({
    Key key,
    this.target,
    Widget child,
  }) : super(key: key, child: child);
  final UIWidgetState target;
  @override
  bool updateShouldNotify(_UIWidgetScope old) {
    return true;
  }
}

class _UIWidgetContainer extends StatefulWidget {
  final UIWidgetState _parent;
  _UIWidgetContainer(UIWidgetState parent) : this._parent = parent;
  @override
  State<StatefulWidget> createState() {
    return _UIWidgetContainerState(this._parent);
  }
}

class _UIWidgetContainerState extends State<_UIWidgetContainer>
    with WidgetsBindingObserver, RouteAware {
  final UIWidgetState _parent;
  _UIWidgetContainerState(UIWidgetState parent) : this._parent = parent;
  @override
  Widget build(BuildContext context) {
    if (!this._parent._loaded) return Container();
    return this._parent._build(context);
  }

  @override
  void initState() {
    super.initState();
    this._parent._value._container = this;
    List provided = this._parent.provider(context);
    for (dynamic tmp in provided) {
      if (tmp == null) continue;
      Type type = tmp.runtimeType;
      if (this._parent._value._provided.containsKey(type)) continue;
      this._parent._value._provided[type] = tmp;
    }
    if (this._parent.validateOnLoad != null) {
      String error = this._parent.validateOnLoad(this.context);
      if (isNotEmpty(error)) {
        UIDialog.show(this.context, text: error);
        return;
      }
    }
    this._parent._loaded = true;
    if (this._parent.onLoad != null) this._parent.onLoad(this.context);
    if (this._parent.onPause != null ||
        this._parent.onUnpause != null ||
        this._parent.onQuit != null) {
      WidgetsBinding.instance.addObserver(this);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (this._parent.onUnload != null) this._parent.onUnload(this.context);
    WidgetsBinding.instance.removeObserver(this);
    UIValue.routeObserver.unsubscribe(this);
    this._parent._value._dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        if (this._parent.onQuit != null) this._parent.onQuit(this.context);
        break;
      case AppLifecycleState.paused:
        if (this._parent.onPause != null) this._parent.onPause(this.context);
        break;
      case AppLifecycleState.resumed:
        if (this._parent.onUnpause != null)
          this._parent.onUnpause(this.context);
        break;
      default:
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModalRoute route = ModalRoute.of(context);
    if (route == null) return;
    UIValue.routeObserver.subscribe(this, route);
  }

  @override
  void didPop() {
    this._parent._didPop();
  }

  @override
  void didPopNext() {
    this._parent._didPopNext();
  }

  @override
  void didPushNext() {
    this._parent._didPushNext();
  }

  @override
  void didPush() {
    this._parent._didPush();
  }
}
