part of masamune.form;

class FormItemSelectBuilder extends FormField<String> {
  final Map<String, String> items;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Widget header;
  final Widget footer;
  final String initialValue;
  final List<Widget> Function(BuildContext context, Map<String, String> items,
      String selected, void Function(String value) onSelect) _builder;
  final void Function(void Function(dynamic fileOrURL, AssetType type) onUpdate)
      onPressed;
  FormItemSelectBuilder(
      {@required
          List<Widget> Function(BuildContext context, Map<String, String> items,
                  String selected, void Function(String value) onSelect)
              builder,
      this.labelText,
      this.initialValue,
      this.hintText,
      this.controller,
      this.header,
      this.footer,
      @required
          this.items,
      this.onPressed,
      Key key,
      void onSaved(String value),
      String validator(String value),
      bool autovalidate = false,
      bool enabled = true})
      : this._builder = builder,
        super(
            key: key,
            builder: (state) {
              return null;
            },
            onSaved: onSaved,
            validator: validator,
            initialValue: controller != null ? controller.text : initialValue,
            enabled: enabled);
  @override
  _FormItemSelectBuilderState createState() => _FormItemSelectBuilderState();
}

class _FormItemSelectBuilderState extends FormFieldState<String> {
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  FormItemSelectBuilder get widget => super.widget as FormItemSelectBuilder;

  @override
  void didUpdateWidget(FormItemSelectBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(this._effectiveController.text);
        if (oldWidget.controller == null) _controller = null;
      }
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
    this.setValue(this._effectiveController.text);
  }

  void _onSelect(String value) {
    if (this.value != value) this.didChange(value);
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(6.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isNotEmpty(this.widget.labelText))
            Text(this.widget.labelText, style: context.theme.textTheme.caption),
          if (this.widget.header != null) ...[
            Space(),
            this.widget.header,
          ],
          ...this
              .widget
              ._builder(context, this.widget.items, this.value, this._onSelect)
              .expandAndRemoveEmpty((item) => [Space(), item]),
          if (this.widget.footer != null) ...[
            Space(),
            this.widget.footer,
          ]
        ],
      ),
    );
  }

  @override
  void didChange(String value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value;
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
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }
}

class FormItemSelectItem extends StatelessWidget {
  final void Function(String value) onSelect;
  final bool selected;
  final String id;
  final String label;
  final Color selectedBackgroundColor;
  final Color selectedColor;
  final EdgeInsetsGeometry padding;
  final IconData selectedIcon;
  final IconData icon;
  final Widget child;

  FormItemSelectItem(
      {@required this.id,
      this.selected = false,
      @required this.onSelect,
      @required this.label,
      this.selectedBackgroundColor,
      this.selectedColor,
      this.selectedIcon,
      this.icon,
      this.padding,
      this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelect(this.id);
      },
      child: Container(
        padding: this.padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: this.selected
                ? (this.selectedBackgroundColor ?? context.theme.primaryColor)
                : null,
            border: Border.all(
                color: this.selected
                    ? Colors.transparent
                    : context.theme.dividerColor,
                width: 1),
            borderRadius: BorderRadius.circular(6.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
                this.selected
                    ? (this.selectedIcon ?? FontAwesomeIcons.checkCircle)
                    : (this.icon ?? FontAwesomeIcons.circle),
                color: this.selected
                    ? (this.selectedColor ??
                        context.theme.colorScheme.onPrimary)
                    : context.theme.disabledColor),
            Space.width(10),
            Expanded(
              child: this.child ??
                  Text(this.label,
                      style: TextStyle(
                          color: this.selected
                              ? (this.selectedColor ??
                                  context.theme.colorScheme.onPrimary)
                              : null,
                          fontWeight: this.selected ? FontWeight.bold : null)),
            )
          ],
        ),
      ),
    );
  }
}
