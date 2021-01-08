// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:masamune_flutter/masamune_flutter.dart';

// /// Abstract class for creating pages.
// ///
// /// It is inherited and used by the class that displays the page.
// ///
// /// Scaffold is built in by default, and the provided method is overridden and used.
// ///
// /// Normally, please override body.
// ///
// /// Please inherit and use.
// abstract class UIHookPageScaffold extends UIHookPage {
//   /// Key for Scaffold.
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   /// State for Scaffold.
//   ScaffoldState get scaffold => this.scaffoldKey?.currentState;

//   /// Abstract class for creating pages.
//   ///
//   /// [key]: Widget key.
//   UIHookPageScaffold({Key key}) : super(key: key);

//   /// FloatingActionButton's Location.
//   @protected
//   FloatingActionButtonLocation get floatingActionButtonLocation => null;

//   /// Creating a floating action button.
//   ///
//   /// [context]: Build context.
//   @protected
//   Widget floatingActionButton(BuildContext context) {
//     return null;
//   }

//   /// FloatingActionButton's Animator.
//   @protected
//   FloatingActionButtonAnimator get floatingActionButtonAnimator => null;

//   /// Creating persistent footer buttons.
//   ///
//   /// [context]: Build context.
//   @protected
//   List<Widget> persistentFooterButtons(BuildContext context) {
//     return null;
//   }

//   /// Creating a drawer.
//   ///
//   /// [context]: Build context.
//   @protected
//   Widget drawer(BuildContext context) {
//     return null;
//   }

//   /// Creating a end drawer.
//   ///
//   /// [context]: Build context.
//   @protected
//   Widget endDrawer(BuildContext context) {
//     return null;
//   }

//   /// Creating a bottom navigation bar.
//   ///
//   /// [context]: Build context.
//   @protected
//   Widget bottomNavigationBar(BuildContext context) {
//     return null;
//   }

//   /// Creating a bottom sheet.
//   ///
//   /// [context]: Build context.
//   @protected
//   Widget bottomSheet(BuildContext context) {
//     return null;
//   }

//   /// Background color.
//   @protected
//   Color get backgroundColor => null;

//   /// Resize to avoid bottom padding.
//   @protected
//   bool get resizeToAvoidBottomPadding => null;

//   /// Resize to avoid bottom inset.
//   @protected
//   bool get resizeToAvoidBottomInset => null;

//   /// True if Primary.
//   @protected
//   bool get primary => true;
//   @protected
//   DragStartBehavior get drawerDragStartBehavior => DragStartBehavior.start;

//   /// True to extend the Body.
//   @protected
//   bool get extendBody => false;

//   /// True to extend the Body behind appbar.
//   @protected
//   bool get extendBodyBehindAppBar => false;

//   /// Scrim color of drawer.
//   @protected
//   Color get drawerScrimColor => null;

//   /// Edge drag width of drawer.
//   @protected
//   double get drawerEdgeDragWidth => null;

//   /// Creating a app bar.
//   ///
//   /// [context]: Build context.
//   @protected
//   Widget appBar(BuildContext context) {
//     return null;
//   }

//   /// Callback for building.
//   ///
//   /// Override and use.
//   ///
//   /// [context]: Build context.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: this.scaffoldKey,
//         appBar: this.appBar(context),
//         body: GestureDetector(
//             onTap: () => context.unfocus(),
//             child: this.applySafeArea
//                 ? SafeArea(child: this.body(context))
//                 : this.body(context)),
//         floatingActionButton: this.floatingActionButton(context),
//         floatingActionButtonLocation: this.floatingActionButtonLocation,
//         floatingActionButtonAnimator: this.floatingActionButtonAnimator,
//         persistentFooterButtons: this.persistentFooterButtons(context),
//         drawer: this.drawer(context),
//         endDrawer: this.endDrawer(context),
//         bottomNavigationBar: this.bottomNavigationBar(context),
//         bottomSheet: this.bottomSheet(context),
//         backgroundColor: this.backgroundColor ?? context.theme.backgroundColor,
//         resizeToAvoidBottomPadding: this.resizeToAvoidBottomPadding,
//         resizeToAvoidBottomInset: this.resizeToAvoidBottomInset,
//         primary: this.primary,
//         drawerDragStartBehavior: this.drawerDragStartBehavior,
//         extendBody: this.extendBody,
//         extendBodyBehindAppBar: this.extendBodyBehindAppBar,
//         drawerScrimColor: this.drawerScrimColor,
//         drawerEdgeDragWidth: this.drawerEdgeDragWidth);
//   }
// }
