part of masamune.form;

class FormItemSwitch extends FormField<bool> {
  final TextEditingController controller;
  final FormItemSwitchType type;
  final void Function(bool value) onChanged;
  final Color activeColor;
  final bool dense;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
  final Widget leading;
  final String hintText;
  final String labelText;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  FormItemSwitch(
      {this.controller,
      this.leading,
      this.dense = false,
      this.backgroundColor,
      this.borderColor,
      this.color,
      this.type = FormItemSwitchType.form,
      this.onChanged,
      this.activeColor,
      this.activeTrackColor,
      this.inactiveThumbColor,
      this.padding,
      this.margin,
      this.inactiveTrackColor,
      this.hintText,
      this.labelText,
      Key key,
      void onSaved(bool value),
      String validator(bool value),
      bool initialValue,
      bool enabled = true})
      : super(
            key: key,
            builder: (state) {
              return null;
            },
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            enabled: enabled);
  @override
  _FormItemSwitchState createState() => _FormItemSwitchState();
}

class _FormItemSwitchState extends FormFieldState<bool> {
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  FormItemSwitch get widget => super.widget as FormItemSwitch;

  @override
  void didUpdateWidget(FormItemSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(_parse(widget.controller.text));
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  bool _parse(String text) {
    if (isEmpty(text)) return false;
    if (text.toLowerCase() == "true") return true;
    return false;
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
    setValue(_parse(this._effectiveController.text));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    switch (widget.type) {
      case FormItemSwitchType.form:
        return Container(
          decoration: BoxDecoration(
              color: this.widget.backgroundColor,
              border: Border.all(
                  color: this.widget.borderColor ??
                      Theme.of(context).disabledColor,
                  style:
                      this.widget.dense ? BorderStyle.none : BorderStyle.solid),
              borderRadius: BorderRadius.circular(4.0)),
          margin: this.widget.margin ??
              (this.widget.dense
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.symmetric(vertical: 10)),
          padding: this.widget.padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4.5),
          child: Row(children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIMarkdown(this.widget.labelText,
                      color: this.widget.enabled
                          ? this.widget.color
                          : Theme.of(context).disabledColor),
                  if (isNotEmpty(this.errorText))
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          this.errorText,
                          style: context.theme.inputDecorationTheme.errorStyle,
                        )),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Switch(
                      value: this.value,
                      activeColor: this.widget.activeColor,
                      activeTrackColor: this.widget.activeTrackColor,
                      inactiveThumbColor: this.widget.inactiveThumbColor,
                      inactiveTrackColor: this.widget.inactiveTrackColor,
                      onChanged: (bool value) {
                        setValue(value);
                        if (this.widget.onChanged != null)
                          this.widget.onChanged(value);
                        this.setState(() {});
                      },
                    )))
          ]),
        );
        break;
      default:
        return SwitchListTile(
            dense: this.widget.dense,
            activeColor: this.widget.activeColor,
            activeTrackColor: this.widget.activeTrackColor,
            inactiveThumbColor: this.widget.inactiveThumbColor,
            inactiveTrackColor: this.widget.inactiveTrackColor,
            onChanged: (bool value) {
              setValue(value);
              if (this.widget.onChanged != null) this.widget.onChanged(value);
              this.setState(() {});
            },
            title: UIMarkdown(this.widget.labelText ?? Const.empty,
                color: this.widget.color),
            subtitle: isNotEmpty(this.errorText)
                ? Text(
                    this.errorText,
                    style: context.theme.inputDecorationTheme.errorStyle,
                  )
                : (isNotEmpty(this.widget.hintText)
                    ? UIMarkdown(this.widget.hintText, color: this.widget.color)
                    : null),
            secondary: this.widget.leading,
            value: this.value);
        break;
    }
  }

  @override
  void didChange(bool value) {
    super.didChange(value);
    if (_parse(_effectiveController.text) != value) {
      _effectiveController.text = value?.toString()?.toLowerCase();
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text =
          widget.initialValue?.toString()?.toLowerCase();
    });
  }

  void _handleControllerChanged() {
    bool parsed = _parse(_effectiveController.text);
    if (parsed != value) {
      didChange(parsed);
    }
  }
}

enum FormItemSwitchType { list, form }
