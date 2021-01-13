import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Class of widget including listening function equivalent to UIValue.
///
/// Inherit and use to create a widget with pass-list functionality.
///
/// Please use StatelessWidget below this.
///
/// In that case, the value can be obtained instantly by using [value.text()] or [value.read())].
class UIScope extends UIWidget {
  /// Class of widget including listening function equivalent to UIValue.
  ///
  /// Inherit and use to create a widget with pass-list functionality.
  ///
  /// Please use StatelessWidget below this.
  ///
  /// In that case, the value can be obtained instantly by using [value.text()] or [value.read())].
  ///
  /// [load]: Callback for widget loading.
  /// [hook]: Callback for widget hooking.
  /// [didLoad]: Callback for widget loaded.
  /// [dispose]: Callback for Widget unloading.
  /// [child]: Callback when creating a widget.
  /// [pause]: Callback for Application paused.
  /// [unpause]: Callback for Application unpaused.
  /// [quit]: Callback for Application quit.
  /// [rebuildable]: Callback to determine if build is possible.
  const UIScope(
      {BuildEvent load,
      BuildEvent didLoad,
      BuildEvent hook,
      BuildEvent dispose,
      BuildEvent pause,
      BuildEvent unpause,
      BuildEvent quit,
      bool rebuildable(BuildContext context),
      @required WidgetBuilder child})
      : super(
            load: load,
            didLoad: didLoad,
            dispose: dispose,
            pause: pause,
            unpause: unpause,
            quit: quit,
            rebuildable: rebuildable,
            child: child);
}
