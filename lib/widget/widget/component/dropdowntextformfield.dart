import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Selectable type text field
///
/// Use with Form.
class DropdownTextFormField extends StatefulWidget {
  final Map<String, String> items;
  final String value;
  final List<DropdownMenuItem<String>> children;
  final List<Widget> Function(BuildContext) selectedItemBuilder;
  final Widget hint;
  final void Function(String) onChanged;
  final void Function() onTap;
  final InputDecoration decoration;
  final void Function(String) onSaved;
  final String Function(String) validator;
  final bool autovalidate;
  final bool enabled;
  final Widget disabledHint;
  final int elevation;
  final TextStyle style;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double itemHeight;
  final Color itemBackgroundColor;
  final Color itemTextColor;
  final TextEditingController controller;

  /// Selectable type text field
  ///
  /// Use with Form.
  DropdownTextFormField(
      {Key key,
      this.value,
      this.controller,
      @required this.items,
      this.children,
      this.selectedItemBuilder,
      this.hint,
      this.onChanged,
      this.onTap,
      this.decoration = const InputDecoration(),
      this.onSaved,
      this.enabled = true,
      this.validator,
      this.autovalidate = false,
      this.disabledHint,
      this.elevation = 8,
      this.style,
      this.icon,
      this.iconDisabledColor,
      this.iconEnabledColor,
      this.iconSize = 24.0,
      this.isDense = true,
      this.isExpanded = false,
      this.itemHeight,
      this.itemBackgroundColor,
      this.itemTextColor})
      : super(key: key);
  @override
  _DropdownTextFormFieldState createState() => _DropdownTextFormFieldState();
}

class _DropdownTextFormFieldState extends State<DropdownTextFormField> {
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    this._controller = this.widget.controller ??
        TextEditingController(
            text: this.widget.value ?? this.widget.items.keys.first);
    this._controller.addListener(this._listener);
  }

  @override
  void dispose() {
    this._controller.removeListener(this._listener);
    if (this.widget.controller == null) this._controller.dispose();
    super.dispose();
  }

  void _listener() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: context.theme?.copyWith(
          canvasColor:
              this.widget.itemBackgroundColor ?? context.theme.backgroundColor,
        ),
        child: DropdownButtonFormField<String>(
            hint: this.widget.hint,
            decoration: this.widget.decoration,
            value: isEmpty(this._controller.text)
                ? this.widget.items.keys.first
                : this._controller.text,
            validator: this.widget.validator,
            onTap: this.widget.onTap,
            onSaved: this.widget.onSaved,
            onChanged: this.widget.enabled
                ? (value) {
                    this._controller.text = value;
                    if (this.widget.onChanged != null)
                      this.widget.onChanged(value);
                  }
                : null,
            autovalidate: this.widget.autovalidate,
            disabledHint: this.widget.disabledHint ??
                Text(isNotEmpty(this._controller?.text) &&
                        this.widget.items.containsKey(this._controller.text)
                    ? this.widget.items[this._controller.text]?.localize()
                    : this.widget.items.values.first?.localize() ??
                        Const.empty),
            elevation: this.widget.elevation,
            style: this.widget.style,
            icon: this.widget.icon,
            iconDisabledColor: this.widget.iconDisabledColor,
            iconEnabledColor: this.widget.iconEnabledColor,
            iconSize: this.widget.iconSize,
            isDense: this.widget.isDense,
            isExpanded: this.widget.isExpanded,
            itemHeight: this.widget.itemHeight,
            selectedItemBuilder: this.widget.selectedItemBuilder ??
                (context) {
                  return this
                          .widget
                          .items
                          ?.toList<Widget>((String key, String value) {
                        return Container(
                            alignment: Alignment.center,
                            child: Text(value.localize(),
                                style: this.widget.itemTextColor != null
                                    ? TextStyle(
                                        color: this.widget.itemTextColor)
                                    : null));
                      })?.toList() ??
                      [];
                },
            items: this.widget.children ??
                this.widget.items?.toList((String key, String value) {
                  return DropdownMenuItem(
                    value: key,
                    child: Text(value.localize(),
                        style: this.widget.itemTextColor != null
                            ? TextStyle(color: this.widget.itemTextColor)
                            : null),
                  );
                })?.toList()));
  }
}
