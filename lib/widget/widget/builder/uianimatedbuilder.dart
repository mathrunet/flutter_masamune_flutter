import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// You can play the animation builder
/// in the form corresponding to [UIAnimatorScenario].
///
/// Create the [UIAnimatorScenario] path first.
///
/// The basic specifications are the same as [AnimatedBuilder].
class UIAnimatedBuilder extends UIWidget {
  /// The path where the animator objects are stored.
  final String path;

  /// Animator object.
  final UIAnimatorScenario animator;

  /// Callback for building the animation.
  final Widget Function(BuildContext, Widget, UIAnimatorScenario) builder;

  /// Widget that does not update when animated.
  final Widget child;

  /// You can play the animation builder
  /// in the form corresponding to [UIAnimatorScenario].
  ///
  /// Create the [UIAnimatorScenario] path first.
  ///
  /// The basic specifications are the same as [AnimatedBuilder].
  ///
  /// [key]: Widget key.
  /// [animator]: Animator object.
  /// [path]: The path where the animator objects are stored.
  /// [builder]: Callback for building the animation.
  /// [child]: Widget that does not update when animated.
  const UIAnimatedBuilder(
      {Key key, this.animator, this.path, @required this.builder, this.child})
      : super(key: key);

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    UIAnimatorScenario sequence;
    if (isNotEmpty(this.path))
      sequence = context.read<UIAnimatorScenario>(this.path);
    if (this.animator != null) sequence = this.animator;
    if (this.builder == null || sequence == null)
      return this.child ?? Container();
    return AnimatedBuilder(
        key: this.key,
        animation: sequence.controller,
        child: this.child,
        builder: (context, child) {
          return this.builder(context, child, sequence);
        });
  }
}
