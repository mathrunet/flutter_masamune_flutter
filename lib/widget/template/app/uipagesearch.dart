import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Page template for creating a page for search.
abstract class UIPageSearch<T extends IDataDocument> extends UIPageScaffold {
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

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
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
        child: Padding(
            padding: const EdgeInsets.all(0),
            child: SearchBar<T>(
                hintText: this.hintText,
                emptyWidget: this.emptyWidget(context),
                onError: (error) => this.emptyWidget(context),
                minimumChars: 2,
                iconActiveColor: this.iconActiveColor(context),
                listPadding: const EdgeInsets.symmetric(vertical: 10),
                searchBarStyle: SearchBarStyle(
                    backgroundColor: context.theme.backgroundColor),
                onSearch: (text) async {
                  Iterable<T> list = await this.onSearch(context, text);
                  return list?.toList();
                },
                searchBarPadding: const EdgeInsets.only(left: 10),
                cancellationWidget: this.cancellationWidget(context),
                header: Divider(height: 1),
                onItemFound: (data, index) =>
                    this.onItemFound(context, data, index))));
  }
}
