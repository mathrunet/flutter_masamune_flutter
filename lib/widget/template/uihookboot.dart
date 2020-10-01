import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Abstract class for creating boot pages.
///
/// It is inherited and used by the class that displays the page.
///
/// Scaffold is built in by default, and the provided method is overridden and used.
///
/// Normally, please override body.
///
/// Please inherit and use.
abstract class UIHookBoot extends UIHookPage {
  /// Abstract class for creating boot pages.
  ///
  /// [key]: Widget key.
  UIHookBoot({Key key}) : super(key: key);

  /// Indicator color.
  ///
  /// If null, the color will be gradation.
  Color get indicatorColor => null;

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
    return this.applySafeArea
        ? SafeArea(child: this._body(context))
        : this._body(context);
  }

  Widget _body(BuildContext context) {
    return Container(
        color: context.theme.backgroundColor,
        child: UIAnimatedBuilder(
            animator: UIAnimatorScenario(animation: [
              UIAnimatorUnit(
                  animatable: Tween<double>(begin: 150, end: 100),
                  from: const Duration(milliseconds: 0),
                  to: const Duration(milliseconds: 2500),
                  curve: Curves.easeInOutQuint,
                  tag: "size"),
              UIAnimatorUnit(
                  animatable: Tween<double>(begin: 100, end: 150),
                  from: const Duration(milliseconds: 2500),
                  to: const Duration(milliseconds: 5000),
                  curve: Curves.easeInOutQuint,
                  tag: "size"),
              UIAnimatorUnit(
                  animatable: ColorTween(
                      begin: this.indicatorColor ?? Colors.red,
                      end: this.indicatorColor ?? Colors.purple),
                  from: const Duration(seconds: 0),
                  to: const Duration(seconds: 1),
                  tag: "color"),
              UIAnimatorUnit(
                  animatable: ColorTween(
                      begin: this.indicatorColor ?? Colors.purple,
                      end: this.indicatorColor ?? Colors.blue),
                  from: const Duration(seconds: 2),
                  to: const Duration(seconds: 3),
                  tag: "color"),
              UIAnimatorUnit(
                  animatable: ColorTween(
                      begin: this.indicatorColor ?? Colors.blue,
                      end: this.indicatorColor ?? Colors.purple),
                  from: const Duration(seconds: 4),
                  to: const Duration(seconds: 5),
                  tag: "color"),
              UIAnimatorUnit(
                  animatable: ColorTween(
                      begin: this.indicatorColor ?? Colors.purple,
                      end: this.indicatorColor ?? Colors.red),
                  from: const Duration(seconds: 8),
                  to: const Duration(seconds: 10),
                  tag: "color")
            ])
              ..playRepeat(),
            builder: (context, child, animator) {
              return LoadingBouncingGrid.circle(
                size: animator.attr("size", defaultValue: 0),
                backgroundColor: animator.attr("color",
                    defaultValue: this.indicatorColor ?? Colors.red),
              );
            }));
  }
}
