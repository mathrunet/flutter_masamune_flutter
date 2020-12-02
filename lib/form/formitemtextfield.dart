part of masamune.form;

class FormItemTextField extends StatelessWidget implements FormItem {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final int minLength;
  final int maxLines;
  final int minLines;
  final bool dense;
  final String hintText;
  final String labelText;
  final String counterText;
  final String lengthErrorText;
  final bool enabled;
  final Widget prefix;
  final Widget suffix;
  final bool readOnly;
  final bool obscureText;
  final bool expands;
  final bool allowEmpty;
  final InputBorder border;
  final InputBorder disabledBorder;
  final List<String> suggestion;
  final Color backgroundColor;
  final void Function(String) onDeleteSuggestion;
  final void Function(String value) onSaved;
  final void Function(String value) onChanged;
  final String Function(String value) validator;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final Color color;
  final Color subColor;
  final bool showCursor;
  final Function onTap;
  final FocusNode focusNode;
  final void Function(String value) onSubmitted;

  FormItemTextField(
      {this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      this.onTap,
      this.minLength,
      this.contentPadding,
      this.maxLines,
      this.minLines = 1,
      this.border,
      this.disabledBorder,
      this.backgroundColor,
      this.expands = false,
      this.hintText = "",
      this.labelText = "",
      this.lengthErrorText = "",
      this.prefix,
      this.suffix,
      this.dense = false,
      this.padding,
      this.suggestion,
      this.allowEmpty = false,
      this.enabled = true,
      this.readOnly = false,
      this.obscureText = false,
      this.counterText = "",
      this.onDeleteSuggestion,
      this.validator,
      this.onSaved,
      this.onSubmitted,
      this.onChanged,
      this.showCursor,
      this.focusNode,
      this.color,
      this.subColor});

  @override
  Widget build(BuildContext context) {
    return SuggestionOverlayBuilder(
        items: this.suggestion,
        onDeleteSuggestion: this.onDeleteSuggestion,
        controller: this.controller,
        builder: (context, controller, onTap) => Padding(
            padding: this.padding ??
                (this.dense
                    ? const EdgeInsets.all(0)
                    : const EdgeInsets.symmetric(vertical: 10)),
            child: TextFormField(
                focusNode: this.focusNode,
                showCursor: this.showCursor,
                enabled: this.enabled,
                controller: controller,
                keyboardType: this.keyboardType,
                maxLength: this.maxLength,
                maxLines: this.obscureText
                    ? 1
                    : (this.expands ? null : this.maxLines),
                minLines: this.obscureText
                    ? 1
                    : (this.expands ? null : this.minLines),
                expands: !this.obscureText && this.expands,
                decoration: InputDecoration(
                  contentPadding: this.contentPadding,
                  fillColor: this.backgroundColor,
                  filled: this.backgroundColor != null,
                  isDense: this.dense,
                  border: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  enabledBorder: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  disabledBorder: this.disabledBorder ??
                      this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  errorBorder: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  focusedBorder: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  focusedErrorBorder: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  hintText: this.hintText,
                  labelText: this.labelText,
                  counterText: this.counterText,
                  prefix: this.prefix,
                  suffix: this.suffix,
                  labelStyle: TextStyle(color: this.color),
                  hintStyle: TextStyle(color: this.subColor),
                  suffixStyle: TextStyle(color: this.subColor),
                  prefixStyle: TextStyle(color: this.subColor),
                  counterStyle: TextStyle(color: this.subColor),
                  helperStyle: TextStyle(color: this.subColor),
                ),
                style: TextStyle(color: this.color),
                obscureText: this.obscureText,
                readOnly: this.readOnly,
                onFieldSubmitted: (value) {
                  if (this.onSubmitted != null) this.onSubmitted(value);
                },
                onTap: this.enabled
                    ? () {
                        onTap?.call();
                        this.onTap?.call();
                      }
                    : null,
                validator: (value) {
                  if (!this.allowEmpty && isEmpty(value)) return this.hintText;
                  if (!this.allowEmpty &&
                      this.minLength != null &&
                      isNotEmpty(this.lengthErrorText) &&
                      this.minLength > value.length) {
                    return this.lengthErrorText;
                  }
                  if (this.validator != null) return this.validator(value);
                  return null;
                },
                onChanged: (value) {
                  if (!this.allowEmpty && isEmpty(value)) return;
                  if (this.onChanged != null) this.onChanged(value);
                },
                onSaved: (value) {
                  if (!this.allowEmpty && isEmpty(value)) return;
                  if (this.onSaved != null) this.onSaved(value);
                })));
  }
}
