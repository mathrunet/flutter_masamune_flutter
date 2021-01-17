// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:loading_animations/loading_animations.dart';
// import 'package:masamune_flutter/masamune_flutter.dart';

// /// Widget that displays loading if no data has been loaded.
// class LoadBuilder<T extends IPath> extends UIWidget {
//   /// Data path.
//   final String path;

//   /// Task data.
//   final T task;

//   /// Builder when the data is empty.
//   final WidgetBuilder empty;

//   /// Loading indicator color.
//   final Color indicatorColor;

//   /// Builder when waiting for a task.
//   final Widget Function(BuildContext context, T data) waiting;

//   /// Builder when the task is completed.
//   final Widget Function(BuildContext context, T data) builder;

//   /// Widget that displays loading if no data has been loaded.
//   ///
//   /// [path]: Data path.
//   /// [task]: Task data.
//   /// [empty]: Builder when the data is empty.
//   /// [indicatorColor]: Loading indicator color.
//   /// [waiting]: Builder when waiting for a task.
//   /// [child]: Builder when the task is completed.
//   LoadBuilder(
//       {this.path,
//       this.task,
//       this.empty,
//       this.indicatorColor,
//       this.waiting,
//       @required this.builder});

//   /// Build method.
//   ///
//   /// [BuildContext]: Build Context.
//   @override
//   Widget build(BuildContext context) {
//     T task =
//         this.task ?? (this.path != null ? context.watch<T>(this.path) : null);
//     if (task == null) {
//       return this._buildInternal(context);
//     } else if (task is ITask && !task.isDone) {
//       return FutureBuilder<T>(
//         future: task.future,
//         builder: (context, snapshot) {
//           return this._buildInternal(context, snapshot);
//         },
//       );
//     } else {
//       return this.builder(context, task);
//     }
//   }

//   Widget _buildInternal(BuildContext context, [AsyncSnapshot<T> snapshot]) {
//     if (snapshot == null || !snapshot.hasData || snapshot.data == null) {
//       if (this.empty != null) {
//         Widget widget = this.empty(context);
//         if (widget != null) return widget;
//       }
//       return Center(
//           child: LoadingBouncingGrid.square(
//               backgroundColor:
//                   this.indicatorColor ?? context.theme.disabledColor));
//     } else if (snapshot.connectionState != ConnectionState.done) {
//       if (this.waiting != null) {
//         Widget widget = this.waiting(context, snapshot.data);
//         if (widget != null) return widget;
//       }
//       return Center(
//           child: LoadingBouncingGrid.square(
//               backgroundColor:
//                   this.indicatorColor ?? context.theme.disabledColor));
//     } else {
//       return this.builder(context, snapshot.data);
//     }
//   }
// }
