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
      Widget featureText = this.featureText(context);
      Widget featureImage = this.featureImage(context);
      EdgeInsetsGeometry padding =
          context.mediaQuery.size.width >= this.thresholdWidth
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
                                    minHeight: this.elementMinHeight),
                                child: this.featureImage(context))),
                        ResponsiveGridCol(
                            md: 6,
                            child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                    minHeight: this.elementMinHeight),
                                child: featureText))
                      ])
                    : Container(
                        alignment: Alignment.center,
                        constraints:
                            BoxConstraints(minHeight: this.elementMinHeight),
                        child: this.featureImage(context)))));
      }
      children.add(ResponsiveGridCol(
          md: 9,
          child: Container(
              alignment: Alignment.topCenter,
              constraints: BoxConstraints(minHeight: this.elementMinHeight),
              padding: padding,
              child: this.body(context))));
      if (context.mediaQuery.size.width >= this.thresholdWidth) {
        children.add(ResponsiveGridCol(
            md: 3,
            child: Container(
                alignment: Alignment.topCenter,
                constraints: BoxConstraints(minHeight: this.elementMinHeight),
                padding: padding,
                child: this.sideBar(context))));
      }
      return Scaffold(
          key: scaffold,
          appBar: this.appBar(context),
          body: GestureDetector(
              onTap: () => context.unfocus(),
              child: Scrollbar(
                  controller: this.scrollController,
                  child: SingleChildScrollView(
                      controller: this.scrollController,
                      padding: padding,
                      child: ResponsiveGridRow(children: children)))),
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
