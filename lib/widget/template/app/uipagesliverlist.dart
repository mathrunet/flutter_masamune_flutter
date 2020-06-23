import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Create SliverList.
///
/// [sliverAppBar] and [sliverBody]to create the page.
///
/// Please inherit and use.
abstract class UIPageSliverList extends UIPageScaffold {
  /// Create SliverList.
  ///
  /// [sliverAppBar] and [sliverBody]to create the page.
  ///
  /// Please inherit and use.
  ///
  /// [key]: Widget key.
  UIPageSliverList({Key key}) : super(key: key);

  /// Defines the Sliver app bar.
  ///
  /// Use only [SliverAppBar].
  ///
  /// [context]: Build context.
  @protected
  SliverAppBar sliverAppBar(BuildContext context) {
    return SliverAppBar();
  }

  /// Defines the Sliver body.
  ///
  /// [context]: Build context.
  @protected
  Widget sliverBody(BuildContext context) {
    return Container();
  }

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
    return SliverToBoxAdapter(
        child: this.applySafeArea
            ? SafeArea(child: this.sliverBody(context))
            : this.sliverBody(context));
  }

  /// Creating a app bar.
  ///
  /// [context]: Build context.
  @override
  Widget appBar(BuildContext context) {
    return this.sliverAppBar(context);
  }

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffold,
        body: GestureDetector(
            onTap: () => context.unfocus(),
            child: CustomScrollView(
                slivers: <Widget>[this.appBar(context), this.body(context)])),
        floatingActionButton: this.floatingActionButton(context),
        floatingActionButtonLocation: this.floatingActionButtonLocation,
        floatingActionButtonAnimator: this.floatingActionButtonAnimator,
        persistentFooterButtons: this.persistentFooterButtons(context),
        drawer: this.drawer(context),
        endDrawer: this.endDrawer(context),
        bottomNavigationBar: this.bottomNavigationBar(context),
        bottomSheet: this.bottomSheet(context),
        backgroundColor: this.backgroundColor,
        resizeToAvoidBottomPadding: this.resizeToAvoidBottomPadding,
        resizeToAvoidBottomInset: this.resizeToAvoidBottomInset,
        primary: this.primary,
        drawerDragStartBehavior: this.drawerDragStartBehavior,
        extendBody: this.extendBody,
        extendBodyBehindAppBar: this.extendBodyBehindAppBar,
        drawerScrimColor: this.drawerScrimColor,
        drawerEdgeDragWidth: this.drawerEdgeDragWidth);
  }
}
