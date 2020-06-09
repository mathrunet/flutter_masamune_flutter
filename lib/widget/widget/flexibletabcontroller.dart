import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Tab controller in which the number of tabs is variable depending on the given Collection.
///
/// Give an ICollection to [data] and change the number of tabs by changing that collection.
class FlexibleTabController extends StatefulWidget {
  /// Tab controller in which the number of tabs is variable depending on the given Collection.
  ///
  /// Give an ICollection to [data] and change the number of tabs by changing that collection.
  ///
  /// [key]: Widget key.
  /// [data]: Data collection.
  /// [initialIndex]: First index number.
  /// [child]: Nesting widget.
  const FlexibleTabController(
      {Key key,
      @required this.data,
      this.initialIndex = 0,
      @required this.child,
      this.onUpdateIndex})
      : super(key: key);

  final void Function(int index) onUpdateIndex;

  /// Collection data for tabs.
  final Iterable data;

  /// First index number.
  final int initialIndex;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Scaffold] whose [AppBar] includes a [TabBar].
  ///
  /// [context]: BuildContext.
  /// [controller]: Tab controller.
  final Widget Function(BuildContext context, TabController controller) child;

  /// The closest instance of this class that encloses the given context.
  ///
  /// Typical usage:
  ///
  /// ```dart
  /// TabController controller = FlexibleTabController.of(context);
  /// ```
  static TabController of(BuildContext context) {
    final _FlexibleTabControllerScope scope = context
        .dependOnInheritedWidgetOfExactType<_FlexibleTabControllerScope>();
    return scope?.controller;
  }

  /// Create a state.
  ///
  /// Do not use from outside.
  @override
  @protected
  _FlexibleTabController createState() => _FlexibleTabController();
}

class _FlexibleTabController extends State<FlexibleTabController>
    with TickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    int index = this.widget.initialIndex;
    if (this.widget.key is ValueKey) {
      index = PathMap.get<int>(
              this.widget.key.asType<ValueKey>().value.toString()) ??
          index;
    }
    this._controller = TabController(
      vsync: this,
      length: this.widget.data.length,
      initialIndex: index,
    );
    this._controller.addListener(this._updateIndex);
    if (this.widget.data is ICollection) {
      (this.widget.data as ICollection).listen(this._updateNotify);
    }
  }

  @override
  void dispose() {
    if (this.widget.data is ICollection) {
      (this.widget.data as ICollection).unlisten(this._updateNotify);
    }
    _controller.removeListener(this._updateIndex);
    _controller.dispose();
    super.dispose();
  }

  void _updateNotify(ICollection data) {
    if (this._controller != null && this._controller.length == data.length)
      return;
    int index = this._controller.index;
    this._controller.index = 0;
    this._controller = TabController(
      vsync: this,
      length: data.length,
      initialIndex: index.limit(0, data.length - 1),
    );
    this.setState(() {});
  }

  void _updateIndex() {
    if (this.widget.key is ValueKey) {
      DataField(this.widget.key.asType<ValueKey>().value.toString(),
          this._controller.index);
    }
    if (this.widget.onUpdateIndex != null)
      this.widget.onUpdateIndex(this._controller.index);
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _FlexibleTabControllerScope(
      controller: this._controller,
      enabled: TickerMode.of(context),
      child: widget.child(context, this._controller),
    );
  }
}

class _FlexibleTabControllerScope extends InheritedWidget {
  const _FlexibleTabControllerScope({
    Key key,
    this.controller,
    this.enabled,
    Widget child,
  }) : super(key: key, child: child);
  final TabController controller;
  final bool enabled;
  @override
  bool updateShouldNotify(_FlexibleTabControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}
