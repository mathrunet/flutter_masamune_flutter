import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Template for creating a home page for the web.
///
/// Please inherit and use.
abstract class UIPageWebHome extends UIPageWebPage {
  /// Scroll controller.
  final ScrollController scrollController = ScrollController();

  /// Template for creating a home page for the web.
  ///
  /// Please inherit and use.
  ///
  /// [key]: Widget key.
  UIPageWebHome({Key key}) : super(key: key);

  /// Image widget to be posted at the top.
  ///
  /// [context]: Build context.
  @protected
  Widget featureImage(BuildContext context) => null;

  /// Text to be posted along with the image to be posted on the top.
  ///
  /// Available when [featureImage] is not [null].
  ///
  /// [context]: Build context.
  @protected
  Widget featureText(BuildContext context) => null;

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return _UIPageWebHomeContainer(this, constraint);
    });
  }
}

class _UIPageWebHomeContainer extends HookWidget {
  final UIPageWebHome parent;
  final BoxConstraints constraints;
  _UIPageWebHomeContainer(this.parent, this.constraints);

  @override
  Widget build(BuildContext context) {
    Widget featureText = this.parent.featureText(context);
    Widget featureImage = this.parent.featureImage(context);
    EdgeInsetsGeometry padding =
        context.mediaQuery.size.width >= this.parent.thresholdWidth
            ? const EdgeInsets.all(10)
            : const EdgeInsets.all(0);
    List<ResponsiveGridCol> children = ListPool.get();
    if (featureImage != null) {
      children.add(ResponsiveGridCol(
          md: 12,
          child: Container(
              decoration: BoxDecoration(
                color: context.theme.secondaryHeaderColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.75),
                      spreadRadius: 0,
                      blurRadius: 5.0,
                      offset: Offset(0, 2.0))
                ],
              ),
              margin: padding,
              child: featureText != null
                  ? ResponsiveGridRow(children: [
                      ResponsiveGridCol(
                          md: 6,
                          child: Container(
                              constraints: BoxConstraints(
                                  minHeight: this.parent.elementMinHeight),
                              child: this.parent.featureImage(context))),
                      ResponsiveGridCol(
                          md: 6,
                          child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(
                                  minHeight: this.parent.elementMinHeight),
                              child: featureText))
                    ])
                  : Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                          minHeight: this.parent.elementMinHeight),
                      child: this.parent.featureImage(context)))));
    }
    children.add(ResponsiveGridCol(
        md: 9,
        child: Container(
            alignment: Alignment.topCenter,
            constraints:
                BoxConstraints(minHeight: this.parent.elementMinHeight),
            padding: padding,
            child: this.parent.body(context))));
    if (context.mediaQuery.size.width >= this.parent.thresholdWidth) {
      children.add(ResponsiveGridCol(
          md: 3,
          child: Container(
              alignment: Alignment.topCenter,
              constraints:
                  BoxConstraints(minHeight: this.parent.elementMinHeight),
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
                            child: ResponsiveGridRow(children: children))))
                : Scrollbar(
                    controller: this.parent.scrollController,
                    child: SingleChildScrollView(
                        controller: this.parent.scrollController,
                        padding: padding,
                        child: ResponsiveGridRow(children: children)))),
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
