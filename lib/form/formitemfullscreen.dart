part of masamune.form;

class FormItemFullScreen<T extends Object> extends FormField<T> {
  final TextEditingController controller;
  final String path;
  final String hintText;
  final bool dense;
  final String labelText;
  final String counterText;
  final T Function(String value) parser;
  final String Function(T value) parseToString;
  final Widget prefix;
  final Widget suffix;
  final bool obscureText;
  final bool allowEmpty;
  final InputBorder border;
  final InputBorder disabledBorder;
  final Color color;
  final Color subColor;

  FormItemFullScreen(
      {this.controller,
      @required this.path,
      this.dense = false,
      this.counterText = "",
      this.parser,
      this.parseToString,
      this.prefix,
      this.suffix,
      this.obscureText = false,
      this.allowEmpty = false,
      this.border,
      this.disabledBorder,
      this.color,
      this.subColor,
      this.hintText = "",
      this.labelText = "",
      Key key,
      void onSaved(T value),
      String validator(T value),
      T initialValue,
      bool autovalidate = false,
      bool enabled = true})
      : super(
            key: key,
            builder: (state) {
              return null;
            },
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialValue,
            enabled: enabled);

  @override
  _FormItemFullScreenState<T> createState() => _FormItemFullScreenState<T>();
}

class _FormItemFullScreenState<T extends Object> extends FormFieldState<T> {
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  FormItemFullScreen<T> get widget => super.widget as FormItemFullScreen<T>;

  @override
  void didUpdateWidget(FormItemFullScreen<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        if (T == String) {
          setValue(widget.controller.text as T);
        } else if (this.widget.parser != null) {
          setValue(this.widget.parser(widget.controller.text));
        }
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
    if (T == String) {
      setValue(this._effectiveController.text as T);
    } else if (this.widget.parser != null) {
      setValue(this.widget.parser(this._effectiveController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
            enabled: this.widget.enabled,
            controller: _effectiveController,
            decoration: InputDecoration(
              border: this.widget.border ??
                  OutlineInputBorder(
                      borderSide: this.widget.dense
                          ? BorderSide.none
                          : const BorderSide()),
              enabledBorder: this.widget.border ??
                  OutlineInputBorder(
                      borderSide: this.widget.dense
                          ? BorderSide.none
                          : const BorderSide()),
              disabledBorder: this.widget.disabledBorder ??
                  this.widget.border ??
                  OutlineInputBorder(
                      borderSide: this.widget.dense
                          ? BorderSide.none
                          : const BorderSide()),
              errorBorder: this.widget.border ??
                  OutlineInputBorder(
                      borderSide: this.widget.dense
                          ? BorderSide.none
                          : const BorderSide()),
              focusedBorder: this.widget.border ??
                  OutlineInputBorder(
                      borderSide: this.widget.dense
                          ? BorderSide.none
                          : const BorderSide()),
              focusedErrorBorder: this.widget.border ??
                  OutlineInputBorder(
                      borderSide: this.widget.dense
                          ? BorderSide.none
                          : const BorderSide()),
              hintText: this.widget.hintText,
              labelText: this.widget.labelText,
              counterText: this.widget.counterText,
              prefix: this.widget.prefix,
              suffix: this.widget.suffix,
              labelStyle: TextStyle(color: this.widget.color),
              hintStyle: TextStyle(color: this.widget.subColor),
              suffixStyle: TextStyle(color: this.widget.subColor),
              prefixStyle: TextStyle(color: this.widget.subColor),
              counterStyle: TextStyle(color: this.widget.subColor),
              helperStyle: TextStyle(color: this.widget.subColor),
            ),
            style: TextStyle(color: this.widget.color),
            obscureText: this.widget.obscureText,
            readOnly: true,
            autovalidate: false,
            onTap: this.widget.enabled && isNotEmpty(this.widget.path)
                ? () async {
                    final res = await context.navigator.pushNamed(
                        this.widget.path,
                        arguments: RouteQuery.fullscreen);
                    if (res == null || !(res is T)) return;
                    if (this.widget.parseToString != null) {
                      this._effectiveController.text =
                          this.widget.parseToString(res);
                    } else {
                      this._effectiveController.text = res?.toString();
                    }
                    this.setValue(res);
                    this.setState(() {});
                  }
                : null,
            validator: (value) {
              if (!this.widget.allowEmpty && isEmpty(this.value))
                return this.widget.hintText;
              return null;
            },
            onSaved: (value) {
              if (!this.widget.allowEmpty && isEmpty(this.value)) return;
              if (this.widget.onSaved != null) this.widget.onSaved(this.value);
            }));
  }

  @override
  void didChange(T value) {
    super.didChange(value);
    if (this.value != value) {
      if (this.widget.parseToString != null) {
        this._effectiveController.text = this.widget.parseToString(value);
      } else {
        this._effectiveController.text = value?.toString();
      }
      this.setValue(value);
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
    if (this.widget.parser != null) return;
    final value = this.widget.parser(_effectiveController.text);
    if (value != this.value) {
      didChange(value);
    }
  }
}
