import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Abstract class for Scaffold pages for tabs.
///
/// Please pass the IDataCollection data to [source].
///
/// Please inherit and use.
abstract class UIPageTabScaffold extends UIPageScaffold {
  final _UITabData _tabData = _UITabData();

  /// Source data for tab.
  Iterable get source => this._tabData.collection;

  /// Source data for tab.
  ///
  /// [collection]: Source data.
  set source(Iterable collection) => this._tabData.collection = collection;

  /// Tab controller.
  TabController get tabController => this._tabData.controller;

  /// Abstract class for creating pages.
  UIPageTabScaffold({Key key}) : super(key: key);

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return FlexibleTabController(
        key: this.key,
        data: this.source,
        child: (context, controller) {
          this._tabData.controller = controller;
          return super.build(context);
        });
  }
}

class _UITabData {
  TabController controller;
  Iterable collection;
}
