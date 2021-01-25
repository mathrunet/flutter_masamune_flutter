import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Builder widget for searching.
class FilteredSearchBuilder<T extends Object> extends StatefulWidget {
  /// The filtered widget.
  final Widget Function(String tag, void Function(String tag) filter)
      filteredWidget;

  /// Search histories.
  final List<String> searchHistories;

  /// History builder.
  final Widget Function(String history, void Function(String text) search)
      historyBuilder;

  /// History header.
  final Widget hisotryHeader;

  /// Builder when the data is empty.
  final Widget emptyWidget;

  /// The first widget shown.
  final Widget initialWidget;

  /// Padding.
  final EdgeInsetsGeometry padding;

  /// Default search text.
  final String initialValue;

  /// The minimum length of search text required to perform a search.
  final int minLength;

  /// Controller for entering a search string.
  final TextEditingController controller;

  /// Loading indicator color.
  final Color indicatorColor;

  /// Initial tag.
  final String initialTag;

  /// Callback to be executed during the search.
  final Future<Iterable<T>> Function(String text, String tag) search;

  /// Builder when the task is completed.
  final List<Widget> Function(
      BuildContext context, Iterable<T> collection, String tag) builder;

  /// Builder widget for searching.
  ///
  /// [emptyWidget]: Builder when the data is empty.
  /// [padding]: Padding.
  /// [filteredWidget]: The filtered widget.
  /// [historyHeader]: History header.
  /// [initialWidget]: The first widget shown.
  /// [historyBuilder]: History builder.
  /// [searchHistories]: Search histories.
  /// [initialValue]: Default search text.
  /// [initialTag]: Deefault tag.
  /// [minLength]: The minimum length of search text required to perform a search.
  /// [controller]: Controller for entering a search string.
  /// [indicatorColor]: Loading indicator color.
  /// [search]: Callback to be executed during the search.
  /// [builder]: Builder when the task is completed.
  FilteredSearchBuilder(
      {this.emptyWidget,
      this.padding = const EdgeInsets.all(10),
      this.controller,
      this.minLength = 2,
      this.hisotryHeader,
      this.filteredWidget,
      this.historyBuilder,
      this.initialWidget,
      this.indicatorColor,
      this.searchHistories,
      this.initialTag,
      @required this.search,
      this.initialValue,
      @required this.builder})
      : assert(builder != null);
  @override
  _SearchBuilderState<T> createState() => _SearchBuilderState<T>();
}

class _SearchBuilderState<T extends Object>
    extends State<FilteredSearchBuilder<T>> {
  String value;
  String _tag;
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  void didUpdateWidget(FilteredSearchBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        this.setValue(_effectiveController.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
    if (widget.initialValue != oldWidget.initialValue) {
      this.setValue(widget.initialValue);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: this.widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
    this.value = _effectiveController.text;
    this._tag = this.widget.initialTag;
  }

  void _filtering(String tag) {
    this._tag = tag;
    this.setState(() {});
  }

  void _history(String text) {
    this._effectiveController.text = text;
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (this.widget.filteredWidget != null)
          this.widget.filteredWidget(this._tag, this._filtering),
        Expanded(flex: 1, child: this._build(context))
      ],
    );
  }

  Widget _build(BuildContext context) {
    if (isEmpty(this.value) || this.value.length < this.widget.minLength) {
      if (this.widget.historyBuilder != null &&
          this.widget.searchHistories != null &&
          this.widget.searchHistories.length > 0) {
        return ListView(
          children: [
            if (this.widget.hisotryHeader != null) this.widget.hisotryHeader,
            ...this.widget.searchHistories.mapAndRemoveEmpty((item) {
              return this.widget.historyBuilder(item, this._history);
            })
          ],
        );
      }
      if (this.widget.initialWidget != null) return this.widget.initialWidget;
      if (this.widget.emptyWidget != null) return this.widget.emptyWidget;
      return Center(child: Text("No data.".localize()));
    }
    return FutureBuilder<Iterable<T>>(
      future: this.widget.search(this.value, this._tag),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
              child: context.widgetTheme.loadingIndicator(
                      context,
                      this.widget.indicatorColor ??
                          Theme.of(context).disabledColor) ??
                  LoadingBouncingGrid.square(
                      backgroundColor: this.widget.indicatorColor ??
                          Theme.of(context).disabledColor));
        } else {
          if (snapshot.data == null || snapshot.data.length <= 0) {
            if (this.widget.emptyWidget != null) return this.widget.emptyWidget;
            return Center(child: Text("No data.".localize()));
          }
          return ListView(
            padding: this.widget.padding,
            children: this.widget.builder(context, snapshot.data, this._tag),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void setValue(String value) {
    if (this.value == value) return;
    this.value = value;
    this.setState(() {});
  }

  void _handleControllerChanged() {
    String text = _effectiveController.text;
    if (this.widget.searchHistories != null &&
        isNotEmpty(text) &&
        text.length < this.widget.minLength) {
      this.widget.searchHistories.insertFirst(text);
    }
    this.setValue(text);
  }
}
