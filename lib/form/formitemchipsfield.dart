part of masamune.form;

class FormItemChipsField extends FormField<String> {
  final String separator;
  final Widget Function(
          BuildContext context, _ChipsInputState<String> state, String value)
      chipBuilder;
  final Widget Function(
          BuildContext context, _ChipsInputState<String> state, String value)
      suggestionBuilder;
  final FutureOr<List<String>> Function(String searchText) findSuggestions;
  final List<String> initialItems;
  final void Function(List<String> values) onChanged;
  final void Function(String value) onChipTapped;
  final double suggestionsBoxMaxHeight;
  final TextInputType inputType;
  final int maxChips;
  final bool obscureText;
  final bool autocorrect;
  final bool allowEmpty;
  final InputBorder border;
  final InputBorder disabledBorder;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final Color color;
  final Color subColor;
  final Color backgroundColor;
  final bool dense;
  final String hintText;
  final String labelText;
  final String counterText;
  final String lengthErrorText;
  final Widget prefix;
  final Widget suffix;
  final bool readOnly;
  FormItemChipsField({
    Key key,
    this.controller,
    this.initialItems,
    String initialValue,
    this.backgroundColor,
    this.separator = ",",
    bool enabled = true,
    this.dense = false,
    this.padding,
    this.contentPadding,
    this.color,
    this.allowEmpty = false,
    this.border,
    this.disabledBorder,
    this.subColor,
    this.hintText = "",
    this.counterText = "",
    this.labelText = "",
    this.lengthErrorText = "",
    this.prefix,
    this.suffix,
    this.readOnly = false,
    @required this.chipBuilder,
    @required this.suggestionBuilder,
    this.findSuggestions,
    this.onChanged,
    this.onChipTapped,
    this.maxChips,
    this.suggestionsBoxMaxHeight,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.autocorrect = true,
    void onSaved(List<String> value),
    String validator(String value),
    String initialURI,
  })  : assert(separator != null),
        assert(findSuggestions != null || initialItems != null),
        super(
            key: key,
            builder: (state) {
              return null;
            },
            onSaved: (value) {
              onSaved?.call(value.split(separator));
            },
            validator: validator,
            initialValue: initialURI,
            enabled: enabled);

  /// Text ediging controller.
  final TextEditingController controller;

  @override
  _FormItemChipsInput createState() => _FormItemChipsInput();
}

class _FormItemChipsInput extends FormFieldState<String> {
  TextEditingController _controller;
  List<String> _items;
  final FocusNode _focusNode = FocusNode();

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  FormItemChipsField get widget => super.widget as FormItemChipsField;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<String> values = this._effectiveController?.text == null
        ? []
        : this._effectiveController.text.split(this.widget.separator)
      ..removeWhere((e) => isEmpty(e));

    return Padding(
      padding: this.widget.dense
          ? const EdgeInsets.all(0)
          : (this.widget.padding ?? const EdgeInsets.symmetric(vertical: 10)),
      child: _ChipsInput<String>(
        initialValue: values,
        decoration: InputDecoration(
          contentPadding:
              this.widget.contentPadding ?? const EdgeInsets.all(10),
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
        textStyle: TextStyle(color: this.widget.color, fontSize: 15, height: 1),
        obscureText: this.widget.obscureText,
        enabled: this.widget.enabled,
        chipBuilder: (context, state, value) {
          if (isEmpty(value)) return null;
          return this.widget.chipBuilder?.call(context, state,
                  value ?? this.widget.initialValue ?? this._items?.first) ??
              Container();
        },
        suggestionBuilder: (context, state, value) {
          return this.widget.suggestionBuilder?.call(context, state,
                  value ?? this.widget.initialValue ?? this._items?.first) ??
              Container();
        },
        findSuggestions: (value, chips) async {
          this._items = isNotEmpty(value) ? [value] : [];
          chips.forEach((element) {
            this._items.add(element);
          });
          this._items.addAll(await this.widget.findSuggestions?.call(value) ??
              widget.initialItems);
          return this._items;
        },
        onChanged: (values) {
          this.setValue(values.join(this.widget.separator));
          this.widget.onChanged?.call(values);
        },
        focusNode: this._focusNode,
        onChipTapped: this.widget.onChipTapped,
        maxChips: this.widget.maxChips,
        suggestionsBoxMaxHeight: this.widget.suggestionsBoxMaxHeight,
        autocorrect: this.widget.autocorrect,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this._items = widget?.initialItems ?? {};
    this._focusNode.addListener(this._handleFocus);
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(FormItemChipsField oldWidget) {
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

typedef ChipsInputSuggestions<T> = FutureOr<List<T>> Function(
    String query, Set chips);
typedef ChipSelected<T> = void Function(T data, bool selected);
typedef ChipsBuilder<T> = Widget Function(
    BuildContext context, _ChipsInputState<T> state, T data);

const kObjectReplacementChar = 0xFFFD;

extension on TextEditingValue {
  String get normalCharactersText => String.fromCharCodes(
        text.codeUnits.where((ch) => ch != kObjectReplacementChar),
      );

  List<int> get replacementCharacters => text.codeUnits
      .where((ch) => ch == kObjectReplacementChar)
      .toList(growable: false);

  int get replacementCharactersCount => replacementCharacters.length;
}

class _ChipsInput<T> extends StatefulWidget {
  const _ChipsInput({
    Key key,
    this.initialValue = const [],
    this.decoration = const InputDecoration(),
    this.enabled = true,
    @required this.chipBuilder,
    @required this.suggestionBuilder,
    @required this.findSuggestions,
    @required this.onChanged,
    this.onChipTapped,
    this.maxChips,
    this.textStyle,
    this.suggestionsBoxMaxHeight,
    this.inputType = TextInputType.text,
    this.textOverflow = TextOverflow.clip,
    this.obscureText = false,
    this.autocorrect = true,
    this.actionLabel,
    this.inputAction = TextInputAction.done,
    this.keyboardAppearance = Brightness.light,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.allowChipEditing = false,
    this.focusNode,
  })  : assert(maxChips == null || initialValue.length <= maxChips),
        super(key: key);

  final InputDecoration decoration;
  final TextStyle textStyle;
  final bool enabled;
  final ChipsInputSuggestions<T> findSuggestions;
  final ValueChanged<List<T>> onChanged;
  @Deprecated('Will be removed in the next major version')
  final ValueChanged<T> onChipTapped;
  final ChipsBuilder<T> chipBuilder;
  final ChipsBuilder<T> suggestionBuilder;
  final List<T> initialValue;
  final int maxChips;
  final double suggestionsBoxMaxHeight;
  final TextInputType inputType;
  final TextOverflow textOverflow;
  final bool obscureText;
  final bool autocorrect;
  final String actionLabel;
  final TextInputAction inputAction;
  final Brightness keyboardAppearance;
  final bool autofocus;
  final bool allowChipEditing;
  final FocusNode focusNode;

  // final Color cursorColor;

  final TextCapitalization textCapitalization;

  @override
  _ChipsInputState<T> createState() => _ChipsInputState<T>();
}

class _ChipsInputState<T> extends State<_ChipsInput<T>>
    implements TextInputClient {
  Set<T> _chips = <T>{};
  List<T> _suggestions;
  final _suggestionsStreamController = StreamController<List<T>>.broadcast();
  int _searchId = 0;
  TextEditingValue _value = TextEditingValue();
  // TextEditingValue _receivedRemoteTextEditingValue;
  TextInputConnection _textInputConnection;
  SuggestionsBoxController _suggestionsBoxController;
  final _layerLink = LayerLink();
  final _enteredTexts = <T, String>{};

  TextInputConfiguration get textInputConfiguration => TextInputConfiguration(
        inputType: widget.inputType,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        actionLabel: widget.actionLabel,
        inputAction: widget.inputAction,
        keyboardAppearance: widget.keyboardAppearance,
        textCapitalization: widget.textCapitalization,
      );

  bool get _hasInputConnection =>
      _textInputConnection != null && _textInputConnection.attached;

  bool get _hasReachedMaxChips =>
      widget.maxChips != null && _chips.length >= widget.maxChips;

  // FocusAttachment _focusAttachment;
  FocusNode _focusNode;

  RenderBox get renderBox => context.findRenderObject();

  @override
  void initState() {
    super.initState();
    _chips.addAll(widget.initialValue);
    // _focusAttachment = _focusNode.attach(context);
    _suggestionsBoxController = SuggestionsBoxController(context);

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initOverlayEntry();
      if (mounted && widget.autofocus && _focusNode != null) {
        FocusScope.of(context).autofocus(_focusNode);
      }
    });
  }

  @override
  void dispose() {
    _closeInputConnectionIfNeeded();

    _focusNode.removeListener(_handleFocusChanged);
    if (null == widget.focusNode) {
      _focusNode.dispose();
    }

    _suggestionsStreamController.close();
    _suggestionsBoxController.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _handleFocusChanged() {
    if (_focusNode.hasFocus) {
      _openInputConnection();
      _suggestionsBoxController.open();
    } else {
      _suggestions = null;
      _suggestionsStreamController.add(_suggestions);
      _closeInputConnectionIfNeeded();
      _suggestionsBoxController.close();
    }
    if (mounted) {
      setState(() {
        /*rebuild so that _TextCursor is hidden.*/
      });
    }
  }

  void _initOverlayEntry() {
    // _suggestionsBoxController.close();
    _suggestionsBoxController.overlayEntry = OverlayEntry(
      builder: (context) {
        final size = renderBox.size;
        final renderBoxOffset = renderBox.localToGlobal(Offset.zero);
        final topAvailableSpace = renderBoxOffset.dy;
        final mq = MediaQuery.of(context);
        final bottomAvailableSpace = mq.size.height -
            mq.viewInsets.bottom -
            renderBoxOffset.dy -
            size.height;
        final _suggestionBoxHeight =
            max(topAvailableSpace, bottomAvailableSpace);
        final showTop = topAvailableSpace > bottomAvailableSpace;
        // print("showTop: $showTop" );
        final compositedTransformFollowerOffset =
            showTop ? Offset(0, -size.height) : Offset.zero;

        return StreamBuilder<List<T>>(
          stream: _suggestionsStreamController.stream,
          builder: (context, snapshot) {
            if (_suggestions != null && _suggestions.isNotEmpty) {
              var suggestionsListView = Material(
                elevation: 4.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _suggestionBoxHeight,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _suggestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return widget.suggestionBuilder(
                        context,
                        this,
                        _suggestions[index],
                      );
                    },
                  ),
                ),
              );
              return Positioned(
                width: size.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: compositedTransformFollowerOffset,
                  child: !showTop
                      ? suggestionsListView
                      : FractionalTranslation(
                          translation: const Offset(0, -1),
                          child: suggestionsListView,
                        ),
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }

  void selectSuggestion(T data) {
    if (!_hasReachedMaxChips) {
      _chips.add(data);
      if (widget.allowChipEditing) {
        var enteredText = _value.normalCharactersText ?? '';
        if (enteredText.isNotEmpty) _enteredTexts[data] = enteredText;
      }
      _updateTextInputState(replaceText: true);

      _suggestions = null;
      _suggestionsStreamController.add(_suggestions);
      if (widget.maxChips == _chips.length) _suggestionsBoxController.close();
    } else {
      _suggestionsBoxController.close();
    }
    widget.onChanged(_chips.toList(growable: false));
  }

  void deleteChip(T data) {
    if (widget.enabled) {
      _chips.remove(data);
      if (_enteredTexts.containsKey(data)) _enteredTexts.remove(data);
      _updateTextInputState();
      widget.onChanged(_chips.toList(growable: false));
    }
  }

  void _openInputConnection() {
    if (!_hasInputConnection) {
      _textInputConnection = TextInput.attach(this, textInputConfiguration)
        ..setEditingState(_value);
    }
    _textInputConnection.show();

    Future.delayed(const Duration(milliseconds: 100), () {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final RenderBox renderBox = context.findRenderObject();
        await Scrollable.of(context)?.position?.ensureVisible(renderBox);
      });
    });
  }

  void showSuggestion() {
    _onSearchChanged(_value?.normalCharactersText);
    //_suggestionsBoxController.open();
  }

  void _onSearchChanged(String value) async {
    final localId = ++_searchId;
    final results = await widget.findSuggestions(value, _chips);
    if (_searchId == localId && mounted) {
      _suggestions =
          results.where((r) => !_chips.contains(r)).toList(growable: false);
    }
    _suggestionsStreamController.add(_suggestions);
  }

  void _closeInputConnectionIfNeeded() {
    if (_hasInputConnection) {
      _textInputConnection.close();
      _textInputConnection = null;
      // _receivedRemoteTextEditingValue = null;
    }
  }

  @override
  void updateEditingValue(TextEditingValue value) {
    // print("updateEditingValue FIRED with ${value.text}");
    // _receivedRemoteTextEditingValue = value;
    var _oldTextEditingValue = _value;
    if (value.text != _oldTextEditingValue.text) {
      setState(() {
        _value = value;
      });
      if (value.replacementCharactersCount <
          _oldTextEditingValue.replacementCharactersCount) {
        var removedChip = _chips.last;
        _chips = Set.of(_chips.take(value.replacementCharactersCount));
        widget.onChanged(_chips.toList(growable: false));
        var putText = '';
        if (widget.allowChipEditing && _enteredTexts.containsKey(removedChip)) {
          putText = _enteredTexts[removedChip];
          _enteredTexts.remove(removedChip);
        }
        _updateTextInputState(putText: putText);
      } else {
        _updateTextInputState();
      }
      _onSearchChanged(_value.normalCharactersText);
    }
  }

  void _updateTextInputState({replaceText = false, putText = ''}) {
    final updatedText =
        String.fromCharCodes(_chips.map((_) => kObjectReplacementChar)) +
            "${replaceText ? '' : _value.normalCharactersText}" +
            putText;
    setState(() {
      _value = _value.copyWith(
        text: updatedText,
        selection: TextSelection.collapsed(offset: updatedText.length),
      );
    });
    _closeInputConnectionIfNeeded();
    _textInputConnection ??= TextInput.attach(this, textInputConfiguration);
    _textInputConnection.setEditingState(_value);
    // _closeInputConnectionIfNeeded(false);
  }

  @override
  void performAction(TextInputAction action) {
    switch (action) {
      case TextInputAction.done:
      case TextInputAction.go:
      case TextInputAction.send:
      case TextInputAction.search:
        if (_suggestions != null && _suggestions.isNotEmpty) {
          selectSuggestion(_suggestions.first);
        } else {
          _focusNode.unfocus();
        }
        break;
      default:
        _focusNode.unfocus();
        break;
    }
  }

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {
    //TODO
  }

  @override
  void didUpdateWidget(_ChipsInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    /* if(widget.focusNode != oldWidget.focusNode){
      oldWidget.focusNode.removeListener(_handleFocusChanged);
      _focusAttachment?.detach();
      _focusAttachment = widget.focusNode.attach(context);
      widget.focusNode.addListener(_handleFocusChanged);
    } */
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {
    // print(point);
  }

  @override
  void connectionClosed() {
    // print('TextInputClient.connectionClosed()');
  }

  @override
  TextEditingValue get currentTextEditingValue => _value;

  @override
  void showAutocorrectionPromptRect(int start, int end) {}

  @override
  AutofillScope get currentAutofillScope => null;

  @override
  Widget build(BuildContext context) {
    var chipsChildren = _chips
        .map<Widget>((data) => widget.chipBuilder(context, this, data))
        .toList();

    final theme = Theme.of(context);

    chipsChildren.add(
      Container(
        height: 45.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Text(
                _value.normalCharactersText,
                maxLines: 1,
                overflow: widget.textOverflow,
                style: widget.textStyle ??
                    theme.textTheme.subtitle1.copyWith(height: 1.5),
              ),
            ),
            Flexible(
              flex: 0,
              child: TextCursor(resumed: _focusNode.hasFocus),
            ),
          ],
        ),
      ),
    );

    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (SizeChangedLayoutNotification val) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          _suggestionsBoxController.overlayEntry.markNeedsBuild();
        });
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Column(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(_focusNode);
                _textInputConnection?.show();
                showSuggestion();
              },
              child: InputDecorator(
                decoration: widget.decoration,
                isFocused: _focusNode.hasFocus,
                isEmpty: _value.text.isEmpty && _chips.isEmpty,
                child: Wrap(
                  children: chipsChildren,
                  spacing: 4.0,
                  runSpacing: 4.0,
                ),
              ),
            ),
            CompositedTransformTarget(
              link: _layerLink,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class SuggestionsBoxController {
  final BuildContext context;

  OverlayEntry overlayEntry;

  bool _isOpened = false;

  bool get isOpened => _isOpened;

  SuggestionsBoxController(this.context);

  void open() {
    if (_isOpened) return;
    assert(overlayEntry != null);
    Overlay.of(context).insert(overlayEntry);
    _isOpened = true;
  }

  void close() {
    // debugPrint("Closing suggestion box");
    if (!_isOpened) return;
    assert(overlayEntry != null);
    overlayEntry.remove();
    _isOpened = false;
  }

  void toggle() {
    if (_isOpened) {
      close();
    } else {
      open();
    }
  }
}

class TextCursor extends StatefulWidget {
  const TextCursor({
    Key key,
    this.color,
    this.duration = const Duration(milliseconds: 500),
    this.resumed = false,
  }) : super(key: key);

  final Color color;
  final Duration duration;
  final bool resumed;

  @override
  _TextCursorState createState() => _TextCursorState();
}

class _TextCursorState extends State<TextCursor>
    with SingleTickerProviderStateMixin {
  bool _displayed = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, _onTimer);
  }

  void _onTimer(Timer timer) {
    setState(() => _displayed = !_displayed);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Opacity(
        opacity: _displayed && widget.resumed ? 1.0 : 0.0,
        child: Container(
          width: 2.0,
          color: this.widget.color ?? theme.primaryColor,
        ),
      ),
    );
  }
}
