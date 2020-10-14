import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'package:masamune_flutter/widget/mixin/uipagesearchmixin.dart';

/// Page template for creating a page for search.
abstract class UIHookPageSearch<T extends IDataDocument>
    extends UIHookPageScaffold with UIPageSearchMixin<T> {
  /// Cancel button widget.
  ///
  /// [context]: Build context.
  Widget cancellationWidget(BuildContext context) {
    return Icon(Icons.close, size: 20, color: context.theme.disabledColor);
  }

  /// The color of the active icon.
  ///
  /// [context]: Build context.
  Color iconActiveColor(BuildContext context) {
    return context.theme.primaryColor;
  }

  /// Hint text.
  String get hintText => "Search Users".localize();

  /// The widget to display when there is no element.
  ///
  /// [context]: Build context.
  Widget emptyWidget(BuildContext context) {
    return Center(child: Text("No user found."));
  }

  /// Enable borders.
  bool get enableBorder => false;

  /// Search bar padding.
  EdgeInsetsGeometry get searchBarPadding => const EdgeInsets.all(10);

  /// Widgets to stack on top of each other.
  ///
  /// [context]: Build context.
  Widget overlayWidget(BuildContext context) => null;

  /// Widget to display when nothing is being searched for.
  Widget placeholderWidget(BuildContext context) => null;

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
    return this.search(context);
  }
}
