import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Page template for creating a page for search.
mixin UIPageSearchMixin<T extends IDataDocument> {
  /// Callback for searching text and getting data.
  ///
  /// [context]: Build context.
  /// [text]: The text to search for.
  Future<Iterable<T>> onSearch(BuildContext context, String text);

  /// Builder for displaying each item.
  ///
  /// [context]: Build context.
  /// [data]: Item data.
  /// [index]: Item index.
  Widget onItemFound(BuildContext context, T data, int index);

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
  Widget search(BuildContext context) {
    final overlay = this.overlayWidget(context);
    return Theme(
      data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      )),
      child: Container(
        color: context.theme.backgroundColor,
        child: Stack(
          children: [
            if (this.enableBorder)
              Container(
                margin: this.searchBarPadding,
                height: 60,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 2, color: context.theme.dividerColor),
                    borderRadius: BorderRadius.circular(8)),
              ),
            SearchBar<T>(
              hintText: this.hintText,
              emptyWidget: this.emptyWidget(context),
              onError: (error) => this.emptyWidget(context),
              minimumChars: 2,
              iconActiveColor: this.iconActiveColor(context),
              listPadding: const EdgeInsets.symmetric(vertical: 10),
              searchBarStyle:
                  SearchBarStyle(backgroundColor: Colors.transparent),
              onSearch: (text) async {
                Iterable<T> list = await this.onSearch(context, text);
                return list?.toList();
              },
              placeHolder: this.placeholderWidget(context),
              searchBarPadding: this
                  .searchBarPadding
                  .subtract(const EdgeInsets.only(top: 10, bottom: 10)),
              cancellationWidget: this.cancellationWidget(context),
              header: this.enableBorder ? null : Divider(height: 1),
              onItemFound: (data, index) =>
                  this.onItemFound(context, data, index),
            ),
            if (overlay != null) overlay
          ],
        ),
      ),
    );
  }
}
