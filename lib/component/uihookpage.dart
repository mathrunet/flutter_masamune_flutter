// part of masamune.flutter;

// /// Abstract class for creating pages.
// ///
// /// It is inherited and used by the class that displays the page.
// ///
// /// Scaffold is built in by default, and the provided method is overridden and used.
// ///
// /// Normally, please override body.
// ///
// /// Please inherit and use.
// abstract class UIHookPage extends UIWidget with UIPageDataMixin {
//   /// Abstract class for creating pages.
//   ///
//   /// [key]: Widget key.
//   UIHookPage({Key key}) : super(key: key, child: null);

//   /// True to apply safe area to Body.
//   @protected
//   bool get applySafeArea => true;

//   /// Creating a body.
//   ///
//   /// [context]: Build context.
//   @protected
//   Widget body(BuildContext context);

//   /// Callback for building.
//   ///
//   /// Override and use.
//   ///
//   /// [context]: Build context.
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () => context.unfocus(),
//         child: this.applySafeArea
//             ? SafeArea(child: this.body(context))
//             : this.body(context));
//   }

//   /// Gets the UIValue of current page.
//   static UIValue get current => _current;
//   static UIValue _current;
// }
