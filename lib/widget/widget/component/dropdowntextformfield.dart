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
  final TextAlign textAlign;
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
      this.textAlign,
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

  TextEditingController get _effectiveController =>
      this.widget.controller ?? this._controller;
  @override
  void initState() {
    super.initState();
    if (this.widget.controller == null) {
      this._controller = TextEditingController(
          text: this.widget.value ?? this.widget.items.keys.first);
    }
    this._effectiveController.addListener(this._listener);
  }

  @override
  void dispose() {
    this._effectiveController.removeListener(this._listener);
    if (this._controller != null) {
      this._controller.removeListener(this._listener);
      this._controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(DropdownTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != this.widget.controller) {
      oldWidget.controller?.removeListener(this._listener);
      this.widget.controller?.addListener(this._listener);
      this.setState(() {});
    }
    if (oldWidget.value != this.widget.value) {
      this.setState(() {
        if (this._effectiveController == null ||
            this.widget.items == null ||
            !this.widget.items.containsKey(this.widget.value)) return;
        this._effectiveController.text = this.widget.value;
      });
    }
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
            value: isEmpty(this._effectiveController.text)
                ? this.widget.items.keys.first
                : this._effectiveController.text,
            validator: (value) {
              if (!(this.widget.enabled ?? true)) return null;
              if (isEmpty(this._effectiveController.text)) return null;
              if (this.widget.validator != null)
                return this.widget.validator(value);
              return null;
            },
            onTap: this.widget.onTap,
            onSaved: (value) {
              if (!(this.widget.enabled ?? true)) return;
              if (isEmpty(this._effectiveController.text)) return;
              if (this.widget.onSaved != null) this.widget.onSaved(value);
            },
            onChanged: this.widget.enabled
                ? (value) {
                    this._effectiveController.text = value;
                    if (this.widget.onChanged != null)
                      this.widget.onChanged(value);
                  }
                : null,
            disabledHint: this.widget.disabledHint ??
                Text(
                  isNotEmpty(this._effectiveController?.text) &&
                          this
                              .widget
                              .items
                              .containsKey(this._effectiveController.text)
                      ? this
                          .widget
                          .items[this._effectiveController.text]
                          ?.localize()
                      : this.widget.items.values.first?.localize() ??
                          Const.empty,
                  textAlign: this.widget.textAlign,
                ),
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
                            child: Text(
                                isEmpty(this._effectiveController.text)
                                    ? "--"
                                    : value.localize(),
                                textAlign: this.widget.textAlign,
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
