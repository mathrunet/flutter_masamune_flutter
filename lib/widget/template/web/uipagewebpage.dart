import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Template for creating a page for the web.
///
/// Please inherit and use.
abstract class UIPageWebPage extends UIPageScaffold {
  /// Scroll controller.
  final ScrollController scrollController = ScrollController();

  /// Normal padding.
  @protected
  EdgeInsetsGeometry get padding => const EdgeInsets.all(10);

  /// Padding when mobile.
  @protected
  EdgeInsetsGeometry get paddingOnMobile => const EdgeInsets.all(0);

  /// Sidebar Position.
  @protected
  UIPageWebPageSidebarPosition get sidebarPosition =>
      UIPageWebPageSidebarPosition.right;

  /// Sidebar size type.
  @protected
  UIPageWebPageSidebarType get sidebarType => UIPageWebPageSidebarType.flexible;

  /// Defines the size of the Sidebar.
  ///
  /// If [sidebarType] is flexible, enter the value of bootstrap col.
  ///
  /// If [sidebarType] is fixed, enter the value of size.
  @protected
  int get sidebarWidth => 3;

  /// Scroll physics.
  ///
  /// Add this when using a list etc.
  final ScrollPhysics scrollPhysics = const NeverScrollableScrollPhysics();

  /// Template for creating a page for the web.
  ///
  /// Please inherit and use.
  ///
  /// [key]: Widget key.
  UIPageWebPage({Key key}) : super(key: key);

  /// The threshold to switch the display.
  @protected
  double get thresholdWidth => BootStrap.minMD;

  /// The minimum height of each element.
  @protected
  double get elementMinHeight => null;

  /// Side bar.
  ///
  /// For mobile, enter the drawer, for PC, enter the sidebar.
  ///
  /// [context]: Build context.
  @protected
  Widget sideBar(BuildContext context) => null;

  /// Page title.
  ///
  /// [context]: Build context.
  @protected
  Widget title(BuildContext context) => null;

  /// Page action button.
  ///
  /// Only valid for PC.
  ///
  /// [context]: Build context.
  @protected
  List<Widget> actions(BuildContext context) => const [];

  /// Creating a app bar.
  ///
  /// [context]: Build context.
  @override
  @protected
  Widget appBar(BuildContext context) {
    return AppBar(
        title: this.title(context),
        actions: context.mediaQuery.size.width >= this.thresholdWidth
            ? this.actions(context)
            : null);
  }

  /// Creating a drawer.
  ///
  /// [context]: Build context.
  @override
  @protected
  Widget drawer(BuildContext context) {
    if (context.mediaQuery.size.width >= this.thresholdWidth) return null;
    return Drawer(child: this.sideBar(context));
  }

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return _UIPageWebPageContainer(this, constraint);
    });
  }
}

class _UIPageWebPageContainer extends HookWidget {
  final UIPageWebPage parent;
  final BoxConstraints constraints;
  _UIPageWebPageContainer(this.parent, this.constraints);

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding =
        context.mediaQuery.size.width >= this.parent.thresholdWidth
            ? this.parent.padding
            : this.parent.paddingOnMobile;
    List<Widget> children = ListPool.get();
    if (this.parent.sidebarPosition == UIPageWebPageSidebarPosition.left &&
        context.mediaQuery.size.width >= this.parent.thresholdWidth) {
      children.add(this.parent.sidebarType == UIPageWebPageSidebarType.flexible
          ? ResponsiveGridCol(
              md: this.parent.sidebarWidth,
              child: Container(
                  alignment: Alignment.topCenter,
                  constraints: this.parent.elementMinHeight == null
                      ? this.constraints
                      : BoxConstraints(minHeight: this.parent.elementMinHeight),
                  padding: padding,
                  child: this.parent.sideBar(context)))
          : SizedBox(
              width: this.parent.sidebarWidth.toDouble(),
              child: Container(
                  alignment: Alignment.topCenter,
                  constraints: this.parent.elementMinHeight == null
                      ? this.constraints
                      : BoxConstraints(minHeight: this.parent.elementMinHeight),
                  padding: padding,
                  child: this.parent.sideBar(context))));
    }
    children.add(this.parent.sidebarType == UIPageWebPageSidebarType.flexible
        ? ResponsiveGridCol(
            md: 12 - this.parent.sidebarWidth,
            child: Container(
                alignment: Alignment.topCenter,
                constraints: this.parent.elementMinHeight == null
                    ? this.constraints
                    : BoxConstraints(minHeight: this.parent.elementMinHeight),
                padding: padding,
                child: this.parent.body(context)))
        : Expanded(
            child: Container(
                alignment: Alignment.topCenter,
                constraints: this.parent.elementMinHeight == null
                    ? this.constraints
                    : BoxConstraints(minHeight: this.parent.elementMinHeight),
                padding: padding,
                child: this.parent.body(context))));
    if (this.parent.sidebarPosition == UIPageWebPageSidebarPosition.right &&
        context.mediaQuery.size.width >= this.parent.thresholdWidth) {
      children.add(this.parent.sidebarType == UIPageWebPageSidebarType.flexible
          ? ResponsiveGridCol(
              md: this.parent.sidebarWidth,
              child: Container(
                  alignment: Alignment.topCenter,
                  constraints: this.parent.elementMinHeight == null
                      ? this.constraints
                      : BoxConstraints(minHeight: this.parent.elementMinHeight),
                  padding: padding,
                  child: this.parent.sideBar(context)))
          : SizedBox(
              width: this.parent.sidebarWidth.toDouble(),
              child: Container(
                  alignment: Alignment.topCenter,
                  constraints: this.parent.elementMinHeight == null
                      ? this.constraints
                      : BoxConstraints(minHeight: this.parent.elementMinHeight),
                  padding: padding,
                  child: this.parent.sideBar(context))));
    }
    return Scaffold(
        key: this.parent.scaffoldKey,
        appBar: this.parent.appBar(context),
        body: GestureDetector(
            onTap: () => context.unfocus(),
            child: this.parent.applySafeArea
                ? SafeArea(
                    child: Scrollbar(
                        controller: this.parent.scrollController,
                        child: SingleChildScrollView(
                            controller: this.parent.scrollController,
                            padding: padding,
                            child: this.parent.sidebarType ==
                                    UIPageWebPageSidebarType.flexible
                                ? ResponsiveGridRow(children: children)
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: children))))
                : Scrollbar(
                    controller: this.parent.scrollController,
                    child: SingleChildScrollView(
                        controller: this.parent.scrollController,
                        padding: padding,
                        child: this.parent.sidebarType ==
                                UIPageWebPageSidebarType.flexible
                            ? ResponsiveGridRow(children: children)
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: children)))),
        floatingActionButton: this.parent.floatingActionButton(context),
        floatingActionButtonLocation: this.parent.floatingActionButtonLocation,
        floatingActionButtonAnimator: this.parent.floatingActionButtonAnimator,
        persistentFooterButtons: this.parent.persistentFooterButtons(context),
        drawer: this.parent.drawer(context),
        endDrawer: this.parent.endDrawer(context),
        bottomNavigationBar: this.parent.bottomNavigationBar(context),
        bottomSheet: this.parent.bottomSheet(context),
        backgroundColor: this.parent.backgroundColor,
        resizeToAvoidBottomPadding: this.parent.resizeToAvoidBottomPadding,
        resizeToAvoidBottomInset: this.parent.resizeToAvoidBottomInset,
        primary: this.parent.primary,
        drawerDragStartBehavior: this.parent.drawerDragStartBehavior,
        extendBody: this.parent.extendBody,
        extendBodyBehindAppBar: this.parent.extendBodyBehindAppBar,
        drawerScrimColor: this.parent.drawerScrimColor,
        drawerEdgeDragWidth: this.parent.drawerEdgeDragWidth);
  }
}

/// Sidebar size type.
enum UIPageWebPageSidebarType {
  /// Fixed.
  fixed,

  /// Flexible.
  flexible,
}

/// Sidebar Location.
enum UIPageWebPageSidebarPosition {
  /// Left.
  left,

  /// Right.
  right,
}
