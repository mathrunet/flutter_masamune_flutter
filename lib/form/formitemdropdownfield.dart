part of masamune.form;

class FormItemDropdownField extends StatelessWidget implements FormItem {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String counterText;
  final Map<String, String> items;
  final Widget prefix;
  final Widget suffix;
  final bool enabled;
  final bool dense;
  final InputBorder border;
  final EdgeInsetsGeometry padding;
  final bool allowEmpty;
  final Color backgroundColor;
  final void Function(String value) onSaved;
  final void Function(String value) onChanged;
  final EdgeInsetsGeometry contentPadding;

  FormItemDropdownField(
      {this.controller,
      this.hintText = "",
      @required this.items,
      this.enabled = true,
      this.border,
      this.padding,
      this.backgroundColor,
      this.dense = false,
      this.labelText = "",
      this.contentPadding,
      this.prefix,
      this.allowEmpty = false,
      this.suffix,
      this.counterText = "",
      this.onSaved,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: this.dense
            ? const EdgeInsets.all(0)
            : (this.padding ?? const EdgeInsets.symmetric(vertical: 10)),
        child: DropdownTextFormField(
            controller: this.controller,
            items: this.items,
            enabled: this.enabled,
            decoration: InputDecoration(
              fillColor: this.backgroundColor,
              filled: this.backgroundColor != null,
              border: this.border ??
                  OutlineInputBorder(
                      borderSide:
                          this.dense ? BorderSide.none : const BorderSide()),
              enabledBorder: this.border ??
                  OutlineInputBorder(
                      borderSide:
                          this.dense ? BorderSide.none : const BorderSide()),
              disabledBorder: this.border ??
                  OutlineInputBorder(
                      borderSide:
                          this.dense ? BorderSide.none : const BorderSide()),
              errorBorder: this.border ??
                  OutlineInputBorder(
                      borderSide:
                          this.dense ? BorderSide.none : const BorderSide()),
              focusedBorder: this.border ??
                  OutlineInputBorder(
                      borderSide:
                          this.dense ? BorderSide.none : const BorderSide()),
              focusedErrorBorder: this.border ??
                  OutlineInputBorder(
                      borderSide:
                          this.dense ? BorderSide.none : const BorderSide()),
              contentPadding: this.contentPadding ?? const EdgeInsets.all(17.5),
              hintText: this.hintText,
              labelText: this.labelText,
              counterText: this.counterText,
              prefix: this.prefix,
              suffix: this.suffix,
            ),
            autovalidate: false,
            validator: (value) {
              if (!this.allowEmpty && isEmpty(value)) return this.hintText;
              return null;
            },
            onChanged: (value) {
              if (this.onChanged != null) this.onChanged(value);
            },
            onSaved: (value) {
              if (!this.allowEmpty && isEmpty(value)) return;
              if (this.onSaved != null) this.onSaved(value);
            }));
  }
}
