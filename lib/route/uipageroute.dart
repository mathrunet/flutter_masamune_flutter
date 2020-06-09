part of masamune.flutter;

/// Page route to perform ui animation.
class UIPageRoute extends PageRouteBuilder {
  /// Route path.
  final String path;

  /// Page route to perform ui animation.
  ///
  /// [path]: Route path.
  /// [builder]: Widget builder.
  /// [settings]: Route settings.
  /// [fullscreenDialog]: Modal display.
  /// [transitionType]: Transition type.
  UIPageRoute(
      {this.path,
      WidgetBuilder builder,
      bool fullscreenDialog = false,
      RouteSettings settings,
      TransitionType transitionType})
      : super(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context);
          },
          fullscreenDialog: fullscreenDialog,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (Config.isWeb) {
              return FadeTransition(
                  opacity: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(animation),
                  child: child);
            }
            if (transitionType == null) {
              if (fullscreenDialog) {
                return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child);
              }
              transitionType = TransitionType.slideToLeft;
            }
            switch (transitionType) {
              case TransitionType.fade:
                return FadeTransition(
                    opacity: Tween<double>(
                      begin: 0,
                      end: 1,
                    ).animate(animation),
                    child: child);
              case TransitionType.slideToRight:
                return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(1, 0),
                    ).animate(animation),
                    child: child);
              case TransitionType.slideToUp:
                return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child);
              case TransitionType.slideToDown:
                return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0, 1),
                    ).animate(animation),
                    child: child);
              default:
                return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child);
            }
          },
        );
}

/// Defines the transition type.
enum TransitionType {
  /// Fade.
  fade,

  /// Left.
  slideToLeft,

  /// Right.
  slideToRight,

  /// Up.
  slideToUp,

  /// Down.
  slideToDown
}
