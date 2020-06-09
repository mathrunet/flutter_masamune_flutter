part of masamune.flutter;

/// Collection for running a continuous animation.
///
/// The animation stored in [UIAnimatorUnit] is
/// executed according to the collection order.
class UIAnimatorScenario extends TaskCollection<UIAnimatorUnit>
    implements TickerProvider {
  Ticker _ticker;

  /// Create a Completer that matches the class.
  ///
  /// Do not use from external class
  @override
  @protected
  Completer createCompleter() => Completer<UIAnimatorScenario>();

  /// Process to create a new instance.
  ///
  /// Do not use from outside the class.
  ///
  /// [path]: Destination path.
  /// [isTemporary]: True if the data is temporary.
  @override
  T createInstance<T extends IClonable>(String path, bool isTemporary) =>
      UIAnimatorScenario._(path: path, isTemporary: isTemporary) as T;
  SequenceAnimationBuilder _builder;

  /// Creates a ticker with the given callback.
  ///
  /// The kind of ticker provided depends on the kind of ticker provider.
  @override
  Ticker createTicker(onTick) {
    this._ticker = Ticker(onTick);
    return this._ticker;
  }

  /// Animation controller.
  ///
  /// Please specify in Animated Builder etc.
  AnimationController get controller {
    if (this._controller == null)
      this._controller = AnimationController(vsync: this);
    return this._controller;
  }

  AnimationController _controller;
  SequenceAnimation get _animation {
    if (this.__animation == null && this._builder != null)
      this.__animation = this._builder.animate(this.controller);
    return this.__animation;
  }

  SequenceAnimation __animation;

  /// Collection for running a continuous animation.
  ///
  /// The animation stored in [UIAnimatorUnit] is
  /// executed according to the collection order.
  ///
  /// [path]: Animation path.
  /// [animation]: List of animations to save initially.
  factory UIAnimatorScenario(
      {String path, Iterable<UIAnimatorUnit> animation}) {
    path = path?.applyTags();
    UIAnimatorScenario collection = PathMap.get<UIAnimatorScenario>(path);
    if (collection != null) {
      if (animation != null) collection._setInternal(animation);
      return collection;
    }
    collection =
        UIAnimatorScenario._(path: path, animation: animation ?? const []);
    return collection;
  }
  UIAnimatorScenario._(
      {String path, Iterable<UIAnimatorUnit> animation, bool isTemporary})
      : super(
            path: path,
            children: animation,
            isTemporary: isEmpty(path) || isTemporary,
            group: 0,
            order: 10) {
    this.done();
  }
  void _setInternal(Iterable<UIAnimatorUnit> children) {
    if (children != null) {
      for (UIAnimatorUnit doc in children) {
        if (doc == null) continue;
        this.setInternal(doc);
      }
    }
  }

  /// Notify object update Notifications spread to related objects.
  ///
  /// However, updatedTime is not notified to newer objects.
  ///
  /// [updatedTime]: Updated time (ms). If it is less than 0,
  /// it will be obtained automatically from the application.
  @override
  void notifyUpdate([int updatedTime = -1]) {
    this._rebuild();
    super.notifyUpdate(updatedTime);
  }

  void _rebuild() {
    this.__animation = null;
    this._builder = SequenceAnimationBuilder();
    for (UIAnimatorUnit anim in this.data.values) {
      if (anim == null) continue;
      if (anim.data == null ||
          anim.from == null ||
          anim.to == null ||
          isEmpty(anim.tag)) continue;
      this._builder.addAnimatable(
          animatable: anim.data,
          from: anim.from,
          to: anim.to,
          tag: anim.tag,
          curve: anim.curve);
    }
  }

  /// Play the animation.
  Future<UIAnimatorScenario> play() async {
    if (this._builder == null) return this;
    if (this._animation == null)
      this.__animation = this._builder.animate(this.controller);
    this.init();
    await this.controller.forward().orCancel;
    this.done();
    return this;
  }

  /// Play the animation from the opposite.
  Future<UIAnimatorScenario> playReverse() async {
    if (this._builder == null) return this;
    if (this._animation == null)
      this.__animation = this._builder.animate(this.controller);
    this.init();
    await this.controller.reverse().orCancel;
    this.done();
    return this;
  }

  /// Repeat the animation and play.
  Future<UIAnimatorScenario> playRepeat() async {
    if (this._builder == null) return this;
    if (this._animation == null)
      this.__animation = this._builder.animate(this.controller);
    this.init();
    await this.controller.repeat().orCancel;
    this.done();
    return this;
  }

  /// Stop the animation you are playing.
  UIAnimatorScenario stop() {
    if (this.controller == null || this._builder == null) return this;
    if (this._animation == null)
      this.__animation = this._builder.animate(this.controller);
    this.controller.stop();
    return this;
  }

  /// Gets the current value according to the tags in the animation list.
  ///
  /// [tag]: Animation tag.
  /// [defaultValue]: The initial value if there is no value.
  T attr<T extends Object>(String tag, {T defaultValue}) {
    if (this._animation == null || isEmpty(tag)) return defaultValue;
    try {
      return this._animation[tag].value as T;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Get the protocol of the path
  @override
  String get protocol => Protocol.animation;

  /// Callback event when application pauses.
  ///
  /// [pause]: True when application is paused, False when returning from pause.
  @override
  void onApplicationPause(bool pause) {
    if (this._ticker == null) return;
    _ticker.muted = pause;
  }

  /// Destroys the object.
  ///
  /// Destroyed objects are not allowed.
  @override
  void dispose() {
    this.controller?.dispose();
    this._ticker?.dispose();
    super.dispose();
  }
}
