import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Page template for creating a page for search.
mixin UIPageSearchMixin<T extends IDataDocument> on UIPage {
  final _UISearchData _searchData = _UISearchData();

  /// Executed when the widget is loaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  @mustCallSuper
  void onInit(BuildContext context) {
    super.onInit(context);
    this._searchData.controller = useTextEditingController();
  }

  /// Controller for search.
  TextEditingController get searchController => this._searchData?.controller;
}

class _UISearchData {
  TextEditingController controller;
}
