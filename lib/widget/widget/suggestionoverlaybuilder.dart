import 'dart:math';
import 'package:flutter/material.dart';
import 'package:masamune_core/masamune_core.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Widget to enable the suggest feature and autocomplete feature.
class SuggestionOverlayBuilder extends StatefulWidget {
  /// Source list for suggestion.
  final List<String> items;

  /// Text editing controller.
  final TextEditingController controller;

  /// Processing when tapping a child element (text field).
  final Function onTap;

  /// Suggest window height.
  final double elevation;

  /// Background color of suggestion window.
  final Color backgroundColor;

  /// What to do if the suggestion is deleted.
  final void Function(String value) onDeleteSuggestion;

  /// Suggestion window text color.
  final Color color;

  /// Builder for child elements.
  final Widget Function(BuildContext context, TextEditingController controller,
      Function onTap) builder;

  /// True to show suggestions when tapping the element.
  final bool showOnTap;

  /// Widget to enable the suggest feature and autocomplete feature.
  ///
  /// [items]: Source list for suggestion.
  /// [controller]: Text editing controller.
  /// [onTap]: Processing when tapping a child element (text field).
  /// [elevation]: Suggest window height.
  /// [backgroundColor]: Background color of suggestion window.
  /// [onDeleteSuggestion]: What to do if the suggestion is deleted.
  /// [color]: Suggestion window text color.
  /// [builder]: Builder for child elements.
  /// [showOnTap]: True to show suggestions when tapping the element.
  SuggestionOverlayBuilder(
      {@required this.builder,
      @required this.items,
      this.onDeleteSuggestion,
      this.color = Colors.black,
      this.backgroundColor = Colors.white,
      this.elevation,
      @required this.controller,
      this.onTap,
      this.showOnTap})
      : assert(builder != null);
  @override
  State<StatefulWidget> createState() => _SuggestionOverlayBuilderState();
}

class _SuggestionOverlayBuilderState extends State<SuggestionOverlayBuilder> {
  OverlayEntry _overlay;
  final LayerLink _layerLink = LayerLink();
  @override
  void initState() {
    super.initState();
    this.widget.controller.addListener(this._listener);
  }

  void _listener() {
    if (this._overlay != null) return;
    if (this.widget.controller == null) return;
    if (this.widget.items == null || this.widget.items.length <= 0) return;
    String search = this.widget.controller.text;
    List<String> wordList = search == null ? [] : search.split(Const.space);
    if (!this.widget.items.any((element) =>
        isNotEmpty(element) &&
        wordList.length > 0 &&
        isNotEmpty(wordList.last) &&
        element != wordList.last &&
        element.toLowerCase().startsWith(wordList.last.toLowerCase()))) return;
    this._updateOverlay();
  }

  @override
  void dispose() {
    super.dispose();
    this.widget.controller.removeListener(this._listener);
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.items == null || this.widget.items.length <= 0) {
      return this
          .widget
          .builder(context, this.widget.controller, this.widget.onTap);
    }
    return WillPopScope(
        onWillPop: () {
          if (this._overlay == null) {
            return Future.value(true);
          } else {
            this._overlay.remove();
            this._overlay = null;
            return Future.value(false);
          }
        },
        child: CompositedTransformTarget(
            link: this._layerLink,
            child: this.widget.builder(context, this.widget.controller, () {
              if (this.widget.showOnTap) this._updateOverlay();
              if (this.widget.onTap != null) this.widget.onTap();
            })));
  }

  void _updateOverlay() {
    final Size textFieldSize = (context.findRenderObject() as RenderBox).size;
    final width = textFieldSize.width;
    final height = textFieldSize.height;
    this._overlay = OverlayEntry(
        builder: (context) => Stack(children: [
              GestureDetector(
                  onTap: () {
                    this._overlay?.remove();
                    this._overlay = null;
                  },
                  child: Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.transparent)),
              Positioned(
                  width: width,
                  child: CompositedTransformFollower(
                      link: this._layerLink,
                      showWhenUnlinked: false,
                      offset: Offset(0.0, height - 20),
                      child: SizedBox(
                          width: width,
                          child: _SuggestionOverlay(
                            items: this.widget.items,
                            color: this.widget.color,
                            onDeleteSuggestion: this.widget.onDeleteSuggestion,
                            backgroundColor: this.widget.backgroundColor,
                            controller: this.widget.controller,
                            elevation: this.widget.elevation,
                            onTap: () {
                              this._overlay?.remove();
                              this._overlay = null;
                            },
                          ))))
            ]));
    Navigator.of(context).overlay.insert(this._overlay);
  }
}

class _SuggestionOverlay extends StatefulWidget {
  final double elevation;
  final Color backgroundColor;
  final Color color;
  final List<String> items;
  final void Function(String value) onDeleteSuggestion;
  final TextEditingController controller;
  final Function onTap;
  _SuggestionOverlay(
      {@required this.items,
      @required this.controller,
      this.onDeleteSuggestion,
      this.elevation = 8.0,
      this.color = Colors.black,
      this.onTap,
      this.backgroundColor = Colors.white})
      : assert(items != null),
        assert(controller != null);
  @override
  State<StatefulWidget> createState() => _SuggestionOverlayState();
}

class _SuggestionOverlayState extends State<_SuggestionOverlay> {
  String _search;
  List<String> _wordList = [];
  @override
  void initState() {
    super.initState();
    this._search = this.widget.controller.text;
    this._wordList =
        this._search == null ? [] : this._search.split(Const.space);
    this.widget.controller.addListener(this._listener);
  }

  void _listener() {
    this.setState(() {
      this._search = this.widget.controller.text;
      this._wordList =
          this._search == null ? [] : this._search.split(Const.space);
    });
  }

  @override
  void dispose() {
    super.dispose();
    this.widget.controller.removeListener(this._listener);
  }

  @override
  Widget build(BuildContext context) {
    final widgets = this.widget.items.mapAndRemoveEmpty((e) {
      if (isNotEmpty(e) &&
          this._wordList.length > 0 &&
          isNotEmpty(this._wordList.last) &&
          e != this._wordList.last &&
          !e.toLowerCase().startsWith(this._wordList.last.toLowerCase()))
        return null;
      return GestureDetector(
          onTap: () {
            if (this._wordList.length > 0) {
              this._wordList[this._wordList.length - 1] = e;
            }
            String text = this._wordList.join(Const.space);
            this.widget.controller.clearComposing();
            this.widget.controller.clear();
            this.widget.controller.text = text;
            this.widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: this.widget.controller.text.length));
            if (this.widget.onTap != null) this.widget.onTap();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints.expand(height: 50),
            child: Row(children: [
              Expanded(
                  child: Text(e,
                      style:
                          TextStyle(fontSize: 18, color: this.widget.color))),
              Container(
                  width: 80,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.all(0),
                      icon:
                          Icon(Icons.close, size: 20, color: this.widget.color),
                      onPressed: () {
                        this.setState(() {
                          this.widget.items.remove(e);
                          if (this.widget.onDeleteSuggestion != null)
                            this.widget.onDeleteSuggestion(e);
                        });
                      }))
            ]),
          ));
    });
    if (widgets.length <= 0) {
      if (this.widget.onTap != null) this.widget.onTap();
      return Container();
    }
    return SizedBox(
        height: min((widgets.length * 50).toDouble() + 20, 260),
        child: Card(
          elevation: this.widget.elevation,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          color: this.widget.backgroundColor,
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: widgets)),
        ));
  }
}
