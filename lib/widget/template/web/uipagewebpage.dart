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
    return UIAppBar(
        title: (context) => this.title(context),
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
      EdgeInsetsGeometry padding =
          context.mediaQuery.size.width >= this.thresholdWidth
              ? this.padding
              : this.paddingOnMobile;
      List<Widget> children = ListPool.get();
      if (this.sidebarPosition == UIPageWebPageSidebarPosition.left &&
          context.mediaQuery.size.width >= this.thresholdWidth) {
        children.add(this.sidebarType == UIPageWebPageSidebarType.flexible
            ? ResponsiveGridCol(
                md: this.sidebarWidth,
                child: Container(
                    alignment: Alignment.topCenter,
                    constraints: this.elementMinHeight == null
                        ? constraint
                        : BoxConstraints(minHeight: this.elementMinHeight),
                    padding: padding,
                    child: this.sideBar(context)))
            : SizedBox(
                width: this.sidebarWidth.toDouble(),
                child: Container(
                    alignment: Alignment.topCenter,
                    constraints: this.elementMinHeight == null
                        ? constraint
                        : BoxConstraints(minHeight: this.elementMinHeight),
                    padding: padding,
                    child: this.sideBar(context))));
      }
      children.add(this.sidebarType == UIPageWebPageSidebarType.flexible
          ? ResponsiveGridCol(
              md: 12 - this.sidebarWidth,
              child: Container(
                  alignment: Alignment.topCenter,
                  constraints: this.elementMinHeight == null
                      ? constraint
                      : BoxConstraints(minHeight: this.elementMinHeight),
                  padding: padding,
                  child: this.body(context)))
          : Expanded(
              child: Container(
                  alignment: Alignment.topCenter,
                  constraints: this.elementMinHeight == null
                      ? constraint
                      : BoxConstraints(minHeight: this.elementMinHeight),
                  padding: padding,
                  child: this.body(context))));
      if (this.sidebarPosition == UIPageWebPageSidebarPosition.right &&
          context.mediaQuery.size.width >= this.thresholdWidth) {
        children.add(this.sidebarType == UIPageWebPageSidebarType.flexible
            ? ResponsiveGridCol(
                md: this.sidebarWidth,
                child: Container(
                    alignment: Alignment.topCenter,
                    constraints: this.elementMinHeight == null
                        ? constraint
                        : BoxConstraints(minHeight: this.elementMinHeight),
                    padding: padding,
                    child: this.sideBar(context)))
            : SizedBox(
                width: this.sidebarWidth.toDouble(),
                child: Container(
                    alignment: Alignment.topCenter,
                    constraints: this.elementMinHeight == null
                        ? constraint
                        : BoxConstraints(minHeight: this.elementMinHeight),
                    padding: padding,
                    child: this.sideBar(context))));
      }
      return Scaffold(
          key: this.scaffoldKey,
          appBar: this.appBar(context),
          body: GestureDetector(
              onTap: () => context.unfocus(),
              child: this.applySafeArea
                  ? SafeArea(
                      child: Scrollbar(
                          controller: this.scrollController,
                          child: SingleChildScrollView(
                              controller: this.scrollController,
                              padding: padding,
                              child: this.sidebarType ==
                                      UIPageWebPageSidebarType.flexible
                                  ? ResponsiveGridRow(children: children)
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: children))))
                  : Scrollbar(
                      controller: this.scrollController,
                      child: SingleChildScrollView(
                          controller: this.scrollController,
                          padding: padding,
                          child: this.sidebarType ==
                                  UIPageWebPageSidebarType.flexible
                              ? ResponsiveGridRow(children: children)
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: children)))),
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
    });
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
