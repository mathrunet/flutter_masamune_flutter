// import 'package:flutter/material.dart';
// import 'package:masamune_flutter/masamune_flutter.dart';

// /// Abstract class for Scaffold pages for tabs.
// ///
// /// Please pass the IDataCollection data to [source].
// ///
// /// Please inherit and use.
// abstract class UIHookPageTabScaffold extends UIHookPageScaffold {
//   final _UITabData _tabData = _UITabData();

//   /// Source data for tab.
//   Iterable get source;

//   /// Tab controller.
//   TabController get tabController => this._tabData.controller;

//   /// Abstract class for creating pages.
//   UIHookPageTabScaffold({Key key}) : super(key: key);

//   /// View of tabs.
//   ///
//   /// [context]: Build context.
//   List<Widget> tabView(BuildContext context);

//   /// The color of the indicator on the tab.
//   ///
//   /// [context]: Build context.
//   Color indicatorColor(BuildContext context) => context.theme.accentColor;

//   /// Tab label style.
//   ///
//   /// [context]: Build context.
//   TextStyle labelStyle(BuildContext context) =>
//       context.theme.textTheme.bodyText1;

//   /// Tab.
//   ///
//   /// [context]: Build context.
//   List<Widget> tabs(BuildContext context) {
//     return this.source.mapAndRemoveEmpty((item) => Text(item));
//   }

//   /// Tab bar. Place this in the bottom of the AppBar.
//   ///
//   /// [context]: Build context.
//   TabBar tabBar(BuildContext context) {
//     return TabBar(
//         indicatorColor: this.indicatorColor(context),
//         controller: this.tabController,
//         labelStyle: this.labelStyle(context),
//         labelPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//         isScrollable: true,
//         tabs: this.tabs(context));
//   }

//   /// Creating a body.
//   ///
//   /// [context]: Build context.
//   @override
//   Widget body(BuildContext context) {
//     return TabBarView(
//         controller: this.tabController, children: this.tabView(context));
//   }

//   /// Callback for building.
//   ///
//   /// Override and use.
//   ///
//   /// [context]: Build context.
//   @override
//   Widget build(BuildContext context) {
//     return FlexibleTabController(
//         key: this.key,
//         data: this.source,
//         child: (context, controller) {
//           this._tabData.controller = controller;
//           return super.build(context);
//         });
//   }
// }

// class _UITabData {
//   TabController controller;
// }
