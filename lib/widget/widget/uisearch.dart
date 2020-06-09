import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Provides a search box.
class UISearch extends UIWidget {
  final String hintText;
  final String searchPath;
  final IconData icon;
  final void Function(String text) onChanged;
  final void Function(String text) onSubmitted;

  /// Provides a search box.
  UISearch(
      {this.hintText,
      this.searchPath,
      this.icon = Icons.search,
      this.onChanged,
      this.onSubmitted});

  /// Executed when the widget is unloaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  @mustCallSuper
  void onUnload(BuildContext context) {
    super.onUnload(context);
    if (isEmpty(this.searchPath)) return;
    DataField(this.searchPath, Const.empty);
  }

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(this.icon),
              hintText: this.hintText),
          onChanged: (text) {
            if (isNotEmpty(this.searchPath)) DataField(this.searchPath, text);
            if (this.onChanged != null) this.onChanged(text);
          },
          onSubmitted: (text) {
            if (isNotEmpty(this.searchPath)) DataField(this.searchPath, text);
            if (this.onSubmitted != null) this.onSubmitted(text);
          },
        ));
  }
}
