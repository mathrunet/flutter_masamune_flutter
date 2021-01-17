// import 'package:flutter/material.dart';
// import 'package:masamune_flutter/masamune_flutter.dart';

// /// Abstract class for widgets that can be used inside a loop.
// ///
// /// Please inherit and use it.
// abstract class LoopableWidget extends StatelessWidget {
//   /// Loop index.
//   final int index;

//   /// Document data in loop.
//   final IDataDocument data;

//   /// Index path that can be referenced in the loop.
//   final String indexPath;

//   /// Document path that can be referenced in the loop.
//   final String documentPath;

//   /// Tap action path that can be referenced in the loop.
//   final String tapPath;

//   /// Long tap action path that can be referenced in the loop.
//   final String longTapPath;

//   /// Double tap action path that can be referenced in the loop.
//   final String doubleTapPath;

//   /// Action when tapped.
//   final VoidAction onTap;

//   /// Action when long-tapped.
//   final VoidAction onLongTap;

//   /// Action when double-tapped.
//   final VoidAction onDoubleTap;

//   /// Abstract class for widgets that can be used inside a loop.
//   ///
//   /// Please inherit and use it.
//   ///
//   /// [index]: Loop index.
//   /// [data]: Document data for loop.
//   /// [indexPath]: Index path that can be referenced in the loop.
//   /// [documentPath]: Document path that can be referenced in the loop.
//   /// [tapPath]: Tap action path that can be referenced in the loop.
//   /// [longTapPath]: Long tap action path that can be referenced in the loop.
//   /// [doubleTapPath]: Double tap action path that can be referenced in the loop.
//   /// [onTap]: Action when tapped.
//   /// [onLongTap]: Action when long-tapped.
//   /// [onDoubleTap]: Action when double-tapped.
//   LoopableWidget(
//       {@required this.index,
//       @required this.data,
//       this.indexPath = DefaultPath.loopIndex,
//       this.documentPath = DefaultPath.loopItem,
//       this.tapPath = DefaultPath.loopTap,
//       this.longTapPath = DefaultPath.loopTapLong,
//       this.doubleTapPath = DefaultPath.loopTapDouble,
//       this.onTap,
//       this.onLongTap,
//       this.onDoubleTap});

//   /// Set the loop.
//   @protected
//   void setLoop() {
//     if (this.data == null) return;
//     this.data.setLoop(this.index,
//         indexPath: this.indexPath,
//         documentPath: this.documentPath,
//         tapPath: this.tapPath,
//         longTapPath: this.longTapPath,
//         doubleTapPath: this.doubleTapPath,
//         onTap: this.onTap,
//         onLongTap: this.onLongTap,
//         onDoubleTap: this.onDoubleTap);
//   }

//   /// Defines the contents of the widget.
//   ///
//   /// Please override and use.
//   ///
//   /// [context]: Build Context.
//   @protected
//   Widget body(BuildContext context);

//   /// Build the Widget.
//   ///
//   /// [context]: Build Context.
//   @override
//   Widget build(BuildContext context) {
//     this.setLoop();
//     return this.body(context);
//   }
// }
