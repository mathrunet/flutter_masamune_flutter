part of masamune.flutter;

/// Abstract class of widget including listening function equivalent to UIValue.
///
/// Inherit and use to create a widget with pass-list functionality.
///
/// Please use StatelessWidget below this.
///
/// In that case, the value can be obtained instantly by using [value.text()] or [value.read())].
abstract class UIWidget extends StatefulWidget {
  final BuildEvent _init;
  final BuildEvent _didInit;
  final BuildEvent _load;
  final BuildEvent _dispose;
  final WidgetBuilder _child;
  final BuildEvent _pause;
  final BuildEvent _unpause;
  final BuildEvent _quit;
  final BuildEvent _didPush;
  final BuildEvent _didPushNext;
  final BuildEvent _didPop;
  final BuildEvent _didPopNext;
  final ValidateEvent _validateOnLoad;
  final bool Function(BuildContext context) _rebuildable;

  /// Abstract class of widget including listening function equivalent to UIValue.
  ///
  /// Inherit and use to create a widget with pass-list functionality.
  ///
  /// Please use StatelessWidget below this.
  ///
  /// In that case, the value can be obtained instantly by using [value.text()] or [value.read())].
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
      BuildEvent init,
      BuildEvent didInit,
      BuildEvent load,
      BuildEvent dispose,
      BuildEvent pause,
      BuildEvent unpause,
      BuildEvent quit,
      BuildEvent didPop,
      BuildEvent didPush,
      BuildEvent didPopNext,
      BuildEvent didPushNext,
      ValidateEvent validateOnLoad,
      bool rebuildable(BuildContext context),
      WidgetBuilder child})
      : this._init = init,
        this._didInit = didInit,
        this._load = load,
        this._dispose = dispose,
        this._pause = pause,
        this._unpause = unpause,
        this._quit = quit,
        this._didPop = didPop,
        this._didPush = didPush,
        this._didPopNext = didPopNext,
        this._didPushNext = didPushNext,
        this._validateOnLoad = validateOnLoad,
        this._child = child,
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

  /// Executed when the widget is initialized.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onInit(BuildContext context) {}

  /// Executed after the widget is initialized.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onDidInit(BuildContext context) {}

  /// Executed when the widget is loaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onLoad(BuildContext context) {}

  /// Executed when the widget is disposed.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onDispose(BuildContext context) {}

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

/// State class for UIWidget.
///
/// Normally not used,
/// but if you want to use it with UIWidget inheritance, inherit it and use it.
class UIWidgetState<T extends UIWidget> extends State<T> {
  /// Executed when the widget is initialized.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onInit(BuildContext context) {
    if (this.widget._init != null) this.widget._init(context);
    this.widget.onInit(context);
  }

  /// Executed after the widget is initialized.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onDidInit(BuildContext context) {
    if (this.widget._didInit != null) this.widget._didInit(context);
    this.widget.onDidInit(context);
  }

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

  /// Executed when the widget is disposed.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  @mustCallSuper
  void onDispose(BuildContext context) {
    if (this.widget._dispose != null) this.widget._dispose(context);
    this.widget.onDispose(context);
  }

  Widget _build(BuildContext context) {
    if (this._cache != null) {
      if (!this.rebuildable(context)) {
        this._notifyObject = null;
        return this._cache;
      } else if (!this.enabled) {
        this._willUpdate = true;
        return this._cache;
      }
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

  /// Determines whether to build.
  ///
  /// True to build.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @protected
  bool rebuildable(BuildContext context) {
    if (this._nonRebuildInternal) return false;
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

  void _didPop(BuildContext context) {
    if (this.widget._didPop != null) this.widget._didPop(context);
    this.widget.didPop(context);
  }

  void _didPush(BuildContext context) {
    this._enabled = true;
    if (this.widget is UIPage) UIPage._current = this._value;
    if (this.widget._didPush != null) this.widget._didPush(context);
    this.widget.didPush(context);
  }

  void _didPopNext(BuildContext context) {
    this._enabled = true;
    if (this._willUpdate) {
      this._notifyUpdate(this._willUpdateObject);
    }
    this._willUpdate = false;
    this._willUpdateObject = null;
    if (this.widget is UIPage) UIPage._current = this._value;
    if (this.widget._didPopNext != null) this.widget._didPopNext(context);
    this.widget.didPopNext(context);
  }

  void _didPushNext(BuildContext context) {
    this._enabled = false;
    if (this.widget._didPushNext != null) this.widget._didPushNext(context);
    this.widget.didPushNext(context);
  }

  /// True if the widget is valid.
  bool get enabled => this._enabled;
  bool _enabled = true;
  bool _loaded = false;
  bool _willUpdate = false;
  dynamic _willUpdateObject;
  bool _nonRebuildInternal = false;

  /// Get the UIValue.
  UIValue get value => this._value;
  UIValue _value;
  Widget _cache;
  Object _notifyObject;
  void _refresh() => this.setState(() {});
  void _notifyUpdate(dynamic object) {
    if (!this.enabled) {
      this._willUpdate = true;
      this._willUpdateObject = object;
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

class _UIWidgetContainer extends StatefulHookWidget {
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
    this._parent.onLoad(this.context);
    String error = this._parent.validateOnLoad(this.context);
    if (isNotEmpty(error)) {
      UIDialog.show(this.context, text: error);
      return Container();
    }
    return this._parent._build(context);
  }

  @override
  void initState() {
    super.initState();
    this._parent._value._container = this;
    this._parent.onInit(this.context);
    this._parent._loaded = true;
    if (this._parent.onLoad != null) this._parent.onLoad(this.context);
    if (this._parent.onPause != null ||
        this._parent.onUnpause != null ||
        this._parent.onQuit != null) {
      WidgetsBinding.instance.addObserver(this);
    }
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      this._parent.onDidInit(this.context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._parent.onDispose(this.context);
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
    ModalRoute route = ModalRoute.of(this.context);
    if (route == null) return;
    UIValue.routeObserver.subscribe(this, route);
  }

  @override
  void didPop() {
    this._parent._nonRebuildInternal = true;
    this._parent._didPop(this.context);
  }

  @override
  void didPopNext() {
    this._parent._didPopNext(this.context);
  }

  @override
  void didPushNext() {
    this._parent._didPushNext(this.context);
  }

  @override
  void didPush() {
    this._parent._didPush(this.context);
  }
}
