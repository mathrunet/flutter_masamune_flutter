part of masamune.form;

class FormItemPassword extends StatefulWidget implements FormItem {
  final String hintText;
  final bool dense;
  final String labelText;
  final String confirmLabelText;
  final String lengthErrorText;
  final String counterText;
  final Widget prefix;
  final int maxLength;
  final int minLength;
  final bool enabled;
  final Widget suffix;
  final bool allowEmpty;
  final InputBorder border;
  final InputBorder disabledBorder;
  final Color backgroundColor;
  final bool confirm;
  final void Function(String) onDeleteSuggestion;
  final void Function(String value) onSaved;
  final String Function(String value) validator;
  final EdgeInsetsGeometry padding;
  final String notMatchText;
  final Color color;
  final Color subColor;

  FormItemPassword(
      {this.confirm = false,
      this.border,
      this.maxLength,
      this.minLength,
      this.disabledBorder,
      this.backgroundColor,
      this.hintText = "",
      this.labelText = "",
      this.confirmLabelText = "",
      this.lengthErrorText = "",
      this.prefix,
      this.suffix,
      this.dense = false,
      this.padding,
      this.allowEmpty = false,
      this.enabled = true,
      this.counterText = "",
      this.onDeleteSuggestion,
      this.notMatchText = "",
      this.validator,
      this.onSaved,
      this.color,
      this.subColor});

  @override
  State<StatefulWidget> createState() => _FormItemPasswordState();
}

class _FormItemPasswordState extends State<FormItemPassword> {
  final TextEditingController _mainController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          enabled: this.widget.enabled,
          controller: this._mainController,
          keyboardType: TextInputType.visiblePassword,
          maxLength: this.widget.maxLength,
          maxLines: 1,
          minLines: 1,
          expands: false,
          decoration: InputDecoration(
            fillColor: this.widget.backgroundColor,
            filled: this.widget.backgroundColor != null,
            isDense: this.widget.dense,
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
          obscureText: true,
          readOnly: false,
          validator: (value) {
            if (!this.widget.allowEmpty && isEmpty(value)) {
              return this.widget.hintText;
            }
            if (!this.widget.allowEmpty &&
                this.widget.minLength != null &&
                isNotEmpty(this.widget.lengthErrorText) &&
                this.widget.minLength > value.length) {
              return this.widget.lengthErrorText;
            }
            if (this.widget.confirm && this._confirmController.text != value) {
              return this.widget.notMatchText;
            }
            if (this.widget.validator != null)
              return this.widget.validator(value);
            return null;
          },
          onSaved: (value) {
            if (!this.widget.allowEmpty && isEmpty(value)) return;
            if (this.widget.onSaved != null) this.widget.onSaved(value);
          },
        ),
        if (this.widget.confirm) ...[
          Space.height(10),
          TextFormField(
            enabled: this.widget.enabled,
            controller: this._confirmController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: this.widget.maxLength,
            maxLines: 1,
            minLines: 1,
            expands: false,
            decoration: InputDecoration(
              fillColor: this.widget.backgroundColor,
              filled: this.widget.backgroundColor != null,
              isDense: this.widget.dense,
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
              labelText: this.widget.confirmLabelText,
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
            obscureText: true,
            readOnly: false,
            validator: (value) {
              if (!this.widget.allowEmpty && isEmpty(value)) {
                return this.widget.hintText;
              }
              if (this.widget.confirm && this._mainController.text != value) {
                return this.widget.notMatchText;
              }
              if (this.widget.validator != null)
                return this.widget.validator(value);
              return null;
            },
            onSaved: (value) {
              if (!this.widget.allowEmpty && isEmpty(value)) return;
              if (this.widget.onSaved != null) this.widget.onSaved(value);
            },
          ),
        ]
      ],
    );
  }
}
