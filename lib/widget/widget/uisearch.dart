import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Provides a search box.
class UISearch extends StatefulHookWidget {
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

  @override
  State<StatefulWidget> createState() => _UISearchState();
}

class _UISearchState extends State<UISearch> {
  @protected
  void dispose() {
    super.dispose();
    if (isEmpty(this.widget.searchPath)) return;
    DataField(this.widget.searchPath, Const.empty);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(this.widget.icon),
              hintText: this.widget.hintText),
          onChanged: (text) {
            if (isNotEmpty(this.widget.searchPath))
              DataField(this.widget.searchPath, text);
            if (this.widget.onChanged != null) this.widget.onChanged(text);
          },
          onSubmitted: (text) {
            if (isNotEmpty(this.widget.searchPath))
              DataField(this.widget.searchPath, text);
            if (this.widget.onSubmitted != null) this.widget.onSubmitted(text);
          },
        ));
  }
}
