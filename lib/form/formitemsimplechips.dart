part of masamune.form;

class FormItemSimpleChips extends FormField<String> {
  final TextEditingController controller;
  final String separator;
  final Widget Function(BuildContext context, _FormItemSimpleChipsState state,
      String key, bool selected) chipBuilder;

  final Widget Function(BuildContext context, _FormItemSimpleChipsState state)
      additioanlChipBuilder;
  final List<String> initialItems;
  final void Function(List<String> values) onChanged;
  final List<String> defaultItems;
  final int maxChips;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry separatePadding;
  final Color color;
  final Color subColor;
  final String dialogLabelText;
  final Color backgroundColor;
  final bool dense;
  final String labelText;
  final InputBorder border;
  final InputBorder disabledBorder;
  FormItemSimpleChips({
    Key key,
    this.controller,
    this.defaultItems,
    this.maxChips,
    this.padding,
    this.contentPadding,
    this.separatePadding,
    this.color,
    this.subColor,
    this.dialogLabelText = "Tag",
    this.backgroundColor,
    this.dense = false,
    this.labelText = "",
    this.border,
    this.disabledBorder,
    this.separator = ",",
    @required this.chipBuilder,
    @required this.additioanlChipBuilder,
    this.onChanged,
    void Function(List<String> values) onSaved,
    String validator(String value),
    this.initialItems,
    bool enabled = true,
  })  : assert(separator != null),
        super(
            key: key,
            builder: (state) {
              return null;
            },
            onSaved: (value) {
              if (isEmpty(value)) return;
              onSaved?.call(value.split(separator));
            },
            validator: validator,
            initialValue: initialItems?.join(separator),
            enabled: enabled);
  @override
  _FormItemSimpleChipsState createState() => _FormItemSimpleChipsState();
}

class _FormItemSimpleChipsState extends FormFieldState<String> {
  Map<String, bool> _chips = <String, bool>{};
  TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;
  @override
  FormItemSimpleChips get widget => super.widget as FormItemSimpleChips;

  void deleteChip(String tag) {
    if (isEmpty(tag)) return;
    if (!this._chips.containsKey(tag)) return;
    if (this.widget.defaultItems.contains(tag)) return;
    this._chips.remove(tag);
    List<String> list =
        this._chips.toList((key, value) => value ? key : null).removeEmpty();
    this.widget.onChanged?.call(list);
    this.setValue(list.join(this.widget.separator));
    this.setState(() {});
  }

  void selectChip(String tag) {
    if (isEmpty(tag)) return;
    if (!this._chips.containsKey(tag)) return;
    if (this._chips[tag]) {
      this._chips[tag] = false;
    } else {
      this._chips[tag] = true;
    }
    List<String> list =
        this._chips.toList((key, value) => value ? key : null).removeEmpty();
    this.widget.onChanged?.call(list);
    this.setValue(list.join(this.widget.separator));
    this.setState(() {});
  }

  void addChip() async {
    UISimpleFormDialog.show(
      context,
      submitBackgroundColor: context.theme.primaryColor,
      builder: (context, form) {
        return FormItemTextField(
          allowEmpty: true,
          labelText: this.widget.dialogLabelText.localize(),
          controller: TextEditingController(),
          onSaved: (value) {
            form["tag"] = value;
          },
        );
      },
      onSubmit: (form) {
        String text = form.getString("tag");
        if (isEmpty(text)) return;
        this._chips[text] = true;
        List<String> list = this
            ._chips
            .toList((key, value) => value ? key : null)
            .removeEmpty();
        this.widget.onChanged?.call(list);
        this.setValue(list.join(this.widget.separator));
        this.setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget additional = this.widget.additioanlChipBuilder(context, this);
    return Padding(
      padding: this.widget.dense
          ? const EdgeInsets.all(0)
          : (this.widget.padding ?? const EdgeInsets.symmetric(vertical: 10)),
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: this.widget.contentPadding,
          fillColor: this.widget.backgroundColor,
          filled: this.widget.backgroundColor != null,
          isDense: this.widget.dense,
          border: this.widget.border ??
              OutlineInputBorder(
                  borderSide:
                      this.widget.dense ? BorderSide.none : const BorderSide()),
          enabledBorder: this.widget.border ??
              OutlineInputBorder(
                  borderSide:
                      this.widget.dense ? BorderSide.none : const BorderSide()),
          disabledBorder: this.widget.disabledBorder ??
              this.widget.border ??
              OutlineInputBorder(
                  borderSide:
                      this.widget.dense ? BorderSide.none : const BorderSide()),
          errorBorder: this.widget.border ??
              OutlineInputBorder(
                  borderSide:
                      this.widget.dense ? BorderSide.none : const BorderSide()),
          focusedBorder: this.widget.border ??
              OutlineInputBorder(
                  borderSide:
                      this.widget.dense ? BorderSide.none : const BorderSide()),
          focusedErrorBorder: this.widget.border ??
              OutlineInputBorder(
                  borderSide:
                      this.widget.dense ? BorderSide.none : const BorderSide()),
          labelText: this.widget.labelText,
          labelStyle: TextStyle(color: this.widget.color),
          hintStyle: TextStyle(color: this.widget.subColor),
          suffixStyle: TextStyle(color: this.widget.subColor),
          prefixStyle: TextStyle(color: this.widget.subColor),
          counterStyle: TextStyle(color: this.widget.subColor),
          helperStyle: TextStyle(color: this.widget.subColor),
        ),
        isEmpty: false,
        isFocused: true,
        child: Wrap(
          children: [
            ...this._chips.toList((key, value) {
              Widget tmp = this.widget.chipBuilder(context, this, key, value);
              if (tmp == null) return null;
              return Padding(
                padding: this.widget.separatePadding ??
                    const EdgeInsets.only(right: 5),
                child: tmp,
              );
            }).removeEmpty(),
            if (additional != null)
              Padding(
                padding: this.widget.separatePadding ??
                    const EdgeInsets.only(right: 5),
                child: additional,
              )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this._chips = this
        .widget
        .defaultItems
        .toMap(key: (key) => key, value: (value) => false);
    this._focusNode.addListener(this._handleFocus);
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(FormItemSimpleChips oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(widget.controller.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    this._focusNode.removeListener(this._handleFocus);
  }

  void _handleFocus() {
    if (!this._focusNode.hasFocus) return;
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }
}
