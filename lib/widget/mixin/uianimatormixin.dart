import 'package:flutter/cupertino.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mixins for using animation on pages.
abstract class UIAnimatorMixin {
  /// Create a new animation.
  ///
  /// Please use it during [onLoad].
  ///
  /// [context]: Build Context.
  /// [path]: Animation path.
  /// [animation]: Animation list.
  void createAnimation(BuildContext context,
      {@required String path, @required Iterable<UIAnimatorUnit> animation}) {
    if (isEmpty(path) || animation == null) return;
    UIAnimatorScenario(path: path, animation: animation).willDispose(context);
  }

  /// Play the animation.
  ///
  /// Please execute [createAnimation] first.
  ///
  /// [path]: Animation path.
  Future<UIAnimatorScenario> play(String path) {
    UIAnimatorScenario scenario = PathMap.get<UIAnimatorScenario>(path);
    if (scenario == null) return Future.delayed(Duration.zero);
    return scenario.play();
  }

  /// Play the animation backwards.
  ///
  /// Please execute [createAnimation] first.
  ///
  /// [path]: Animation path.
  Future<UIAnimatorScenario> playReverse(String path) {
    UIAnimatorScenario scenario = PathMap.get<UIAnimatorScenario>(path);
    if (scenario == null) return Future.delayed(Duration.zero);
    return scenario.playReverse();
  }

  /// Repeat the animation and play.
  ///
  /// Please execute [createAnimation] first.
  ///
  /// [path]: Animation path.
  Future<UIAnimatorScenario> playRepeat(String path) {
    UIAnimatorScenario scenario = PathMap.get<UIAnimatorScenario>(path);
    if (scenario == null) return Future.delayed(Duration.zero);
    return scenario.playRepeat();
  }

  /// Stop the animation.
  ///
  /// Please execute [createAnimation] first.
  ///
  /// [path]: Animation path.
  UIAnimatorScenario stop(String path) {
    UIAnimatorScenario scenario = PathMap.get<UIAnimatorScenario>(path);
    if (scenario == null) return null;
    return scenario.stop();
  }

  /// Create a widget for animation.
  ///
  /// [path]: Animation path.
  /// [builder]: Builder callback.
  /// [child]: Widget that does not update when animated.
  Widget animatedBuilder(String path,
      Widget Function(BuildContext, Widget, UIAnimatorScenario) builder,
      {Widget child}) {
    if (isEmpty(path) || builder == null) return Container();
    return UIAnimatedBuilder(path: path, builder: builder, child: child);
  }
}
