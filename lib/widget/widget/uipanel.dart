import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Class of widget including listening function equivalent to UIValue.
///
/// Inherit and use to create a widget with pass-list functionality.
///
/// Please use StatelessWidget below this.
///
/// In that case, the value can be obtained instantly by using [value.text()] or [value.get())].
class UIPanel extends UIWidget {
  /// Class of widget including listening function equivalent to UIValue.
  ///
  /// Inherit and use to create a widget with pass-list functionality.
  ///
  /// Please use StatelessWidget below this.
  ///
  /// In that case, the value can be obtained instantly by using [value.text()] or [value.get())].
  ///
  /// [load]: Callback for widget loading.
  /// [unload]: Callback for Widget unloading.
  /// [child]: Callback when creating a widget.
  /// [pause]: Callback for Application paused.
  /// [unpause]: Callback for Application unpaused.
  /// [quit]: Callback for Application quit.
  /// [provider]: Save the object to UIValue.
  /// The saved value is getting by [context.consume<T>].
  /// [rebuildable]: Callback to determine if build is possible.
  const UIPanel(
      {BuildEvent load,
      BuildEvent unload,
      BuildEvent pause,
      BuildEvent unpause,
      BuildEvent quit,
      List provider(BuildContext context),
      bool rebuildable(BuildContext context),
      @required WidgetBuilder child})
      : super(
            load: load,
            unload: unload,
            pause: pause,
            unpause: unpause,
            quit: quit,
            provider: provider,
            rebuildable: rebuildable,
            child: child);
}
