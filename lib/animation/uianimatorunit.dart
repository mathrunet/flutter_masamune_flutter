part of masamune.flutter;

/// Unit for storing animation information.
///
/// Please use it together with [UIAnimatorScenario].
class UIAnimatorUnit extends Task<Animatable> {
  /// Create a Completer that matches the class.
  ///
  /// Do not use from external class
  @override
  @protected
  Completer createCompleter() => Completer<UIAnimatorUnit>();

  /// Process to create a new instance.
  ///
  /// Do not use from outside the class.
  ///
  /// [path]: Destination path.
  /// [isTemporary]: True if the data is temporary.
  @override
  @protected
  T createInstance<T extends IClonable>(String path, bool isTemporary) =>
      UIAnimatorUnit._(
          path: path,
          from: this.from,
          to: this.to,
          tag: this.tag,
          curve: this.curve,
          isTemporary: isTemporary) as T;

  /// Unit for storing animation information.
  ///
  /// Please use it together with [UIAnimatorScenario].
  ///
  /// [path]: Unit path.
  /// [animatable]: The actual animation.
  /// [from]: Start of duration.
  /// [to]: End of duration.
  /// [tag]: Animation tag.
  /// [curve]: Animation curve.
  factory UIAnimatorUnit(
      {String path,
      Animatable animatable,
      Duration from,
      Duration to,
      String tag,
      Curve curve}) {
    path = path?.applyTags();
    assert(animatable != null);
    assert(to != null);
    assert(from != null);
    assert(isNotEmpty(tag));
    if (animatable == null || to == null || from == null || isEmpty(tag)) {
      Log.error("The animation data is invalid.");
      return null;
    }
    UIAnimatorUnit unit = PathMap.get<UIAnimatorUnit>(path);
    if (unit != null) {
      if (animatable != null) unit.data = animatable;
      if (from != null) unit.from = from;
      if (to != null) unit.to = to;
      if (tag != null) unit.tag = tag;
      if (curve != null) unit.curve = curve;
      return unit;
    }
    unit = UIAnimatorUnit._(
        path: path,
        animatable: animatable,
        from: from,
        to: to,
        tag: tag,
        curve: curve);
    return unit;
  }
  UIAnimatorUnit._(
      {String path,
      Animatable animatable,
      Duration from,
      Duration to,
      String tag,
      Curve curve,
      bool isTemporary = false})
      : this._from = from,
        this._to = to,
        this._tag = tag,
        this._curve = curve,
        super(
            path: path,
            value: animatable,
            isTemporary: isEmpty(path) || isTemporary,
            order: 10,
            group: 0) {
    this.done();
  }

  /// Start of duration.
  Duration get from => this._from;

  /// Start of duration.
  ///
  /// [from]: Start of duration.
  set from(Duration from) {
    this._from = from;
    this.notifyUpdate();
  }

  Duration _from;

  /// End of duration.
  Duration get to => this._to;

  /// End of duration.
  ///
  /// [to]: End of duration.
  set to(Duration to) {
    this._to = to;
    this.notifyUpdate();
  }

  Duration _to;

  /// Animation tag.
  String get tag => this._tag;

  /// Animation tag.
  ///
  /// [tag]: Animation tag.
  set tag(String tag) {
    this._tag = tag;
    this.notifyUpdate();
  }

  String _tag;

  /// Animation curve.
  Curve get curve {
    if (this._curve == null) this._curve = Curves.linear;
    return this._curve;
  }

  /// Animation curve.
  ///
  /// [curve]: Animation curve.
  set curve(Curve curve) {
    this._curve = curve;
    this.notifyUpdate();
  }

  Curve _curve = Curves.linear;

  /// Get the protocol of the path
  @override
  String get protocol => Protocol.animation;
}
