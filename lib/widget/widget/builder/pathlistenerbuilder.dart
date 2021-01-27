import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Widget that displays loading if no data has been loaded.
class PathListenerBuilder<T extends IPath> extends StatefulWidget {
  /// Task path.
  final String path;

  /// Task data.
  final FutureOr<T> task;

  /// Builder when the data is empty.
  final WidgetBuilder empty;

  /// Loading indicator color.
  final Color indicatorColor;

  /// Builder when the task is completed.
  final Widget Function(BuildContext context, T data) builder;

  /// Builder when waiting for a task.
  final Widget Function(BuildContext context, T data) waiting;

  /// Widget that displays loading if no data has been loaded.
  ///
  /// [path]: Task path.
  /// [task]: Task data.
  /// [empty]: Builder when the data is empty.
  /// [waiting]: Builder when waiting for a task.
  /// [indicatorColor]: Loading indicator color.
  /// [child]: Builder when the task is completed.
  PathListenerBuilder(
      {this.path,
      this.task,
      this.empty,
      this.waiting,
      this.indicatorColor,
      @required this.builder});

  @override
  State<StatefulWidget> createState() => _PathListenerBuilderState<T>();
}

class _PathListenerBuilderState<T extends IPath>
    extends State<PathListenerBuilder<T>> {
  @override
  void initState() {
    super.initState();
    this._listen(this.widget);
  }

  void _listen(PathListenerBuilder<T> widget) {
    if (widget.task != null) {
      FutureOr<T> task = widget.task;
      if (task is Future<T>) {
        task.watch(this._listener);
      } else if (task is T) {
        task.watch(this._listener);
      }
    } else if (widget.path != null) {
      T task = PathMap.get<IPath>(widget.path);
      task?.watch(this._listener);
    }
  }

  void _unlisten(PathListenerBuilder<T> widget) {
    if (this.widget.task != null) {
      FutureOr<T> task = this.widget.task;
      if (task is Future<T>) {
        task.unwatch(this._listener);
      } else if (task is T) {
        task.unwatch(this._listener);
      }
    } else if (this.widget.path != null) {
      T task = PathMap.get<IPath>(this.widget.path);
      task?.unwatch(this._listener);
    }
  }

  @override
  void didUpdateWidget(covariant PathListenerBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != this.widget.path) {
      this._unlisten(oldWidget);
      this._listen(this.widget);
    }
  }

  @override
  void dispose() {
    super.dispose();
    this._unlisten(this.widget);
  }

  void _listener(T path) {
    this.setState(() {});
  }

  /// Build method.
  ///
  /// [BuildContext]: Build Context.
  @override
  Widget build(BuildContext context) {
    if (this.widget.task != null) {
      FutureOr<T> task = this.widget.task;
      if (task is Future<T>) {
        return FutureBuilder<T>(
          future: task,
          builder: (context, snapshot) {
            return this._buildInternal(context, snapshot);
          },
        );
      } else if (task is T) {
        return this.widget.builder(context, task);
      }
    } else if (this.widget.path != null) {
      T task = PathMap.get<IPath>(this.widget.path);
      if (task != null) return this.widget.builder(context, task);
    }
    if (this.widget.empty != null) {
      Widget widget = this.widget.empty(context);
      if (widget != null) return widget;
    }
    return Center(
        child: context.widgetTheme.loadingIndicator ??
            LoadingBouncingGrid.square(
                backgroundColor:
                    this.widget.indicatorColor ?? context.theme.disabledColor));
  }

  Widget _buildInternal(BuildContext context, [AsyncSnapshot<T> snapshot]) {
    if (snapshot == null || !snapshot.hasData || snapshot.data == null) {
      if (this.widget.empty != null) {
        Widget widget = this.widget.empty(context);
        if (widget != null) return widget;
      }
      return Center(
          child: context.widgetTheme.loadingIndicator ??
              LoadingBouncingGrid.square(
                  backgroundColor: this.widget.indicatorColor ??
                      context.theme.disabledColor));
    } else if (snapshot.connectionState != ConnectionState.done) {
      if (this.widget.waiting != null) {
        Widget widget = this.widget.waiting(context, snapshot.data);
        if (widget != null) return widget;
      }
      return Center(
          child: context.widgetTheme.loadingIndicator(context,
                  this.widget.indicatorColor ?? context.theme.disabledColor) ??
              LoadingBouncingGrid.square(
                  backgroundColor: this.widget.indicatorColor ??
                      context.theme.disabledColor));
    } else {
      return this.widget.builder(context, snapshot.data);
    }
  }
}
