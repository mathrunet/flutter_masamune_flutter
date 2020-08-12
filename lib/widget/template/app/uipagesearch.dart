import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Page template for creating a page for search.
abstract class UIPageSearch<T extends IDataDocument> extends UIPageScaffold {
  /// Callback for searching text and getting data.
  ///
  /// [context]: Build context.
  /// [text]: The text to search for.
  Future<List<T>> onSearch(BuildContext context, String text);

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
    return Icon(Icons.close);
  }

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: SearchBar<T>(
            minimumChars: 2,
            onSearch: (text) => this.onSearch(context, text),
            searchBarPadding: const EdgeInsets.symmetric(horizontal: 10),
            cancellationWidget: this.cancellationWidget(context),
            onItemFound: (data, index) =>
                this.onItemFound(context, data, index)));
  }
}
