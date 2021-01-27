import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// A list for filtering the widgets displayed in ListView, Column, etc. by text.
///
/// Enter the search text in [searchText] and store the full size widget list in [children].
///
/// Put the text in the ValueKey for each widget.
/// You can search within that text.
@deprecated
class SearchableWidget with ListMixin<Widget> implements List<Widget> {
  List<Widget> _list = ListPool.get();

  /// A list for filtering the widgets displayed in ListView, Column, etc. by text.
  ///
  /// Enter the search text in [searchText] and store the full size widget list in [children].
  ///
  /// Put the text in the ValueKey for each widget.
  /// You can search within that text.
  ///
  /// [searchText]: Search text.
  /// [children]: Full size widget list.
  SearchableWidget({String searchText, List<Widget> children}) {
    if (isEmpty(searchText)) {
      this._list = children;
    } else {
      List<String> searchList = searchText.toLowerCase().split(Const.space);
      this._list = children.where((widget) {
        String value = widget.key?.asType<ValueKey>()?.value as String;
        return searchList.any((text) =>
            isEmpty(text) ? false : value.toLowerCase().contains(text));
      }).toList();
    }
  }

  /// Returns the number of objects in this list.
  ///
  /// The valid indices for a list are 0 through length - 1.
  @override
  int get length => this._list.length;

  /// Takes out an element.
  ///
  /// [index]: Index.
  @override
  Widget operator [](int index) => this._list[index];

  /// Takes out an element.
  ///
  /// [index]: Index.
  /// [value]: Value.
  @override
  void operator []=(int index, Widget value) {
    this._list[index] = value;
  }

  /// Returns the number of objects in this list.
  ///
  /// The valid indices for a list are 0 through length - 1.
  @override
  set length(int newLength) {}
}
