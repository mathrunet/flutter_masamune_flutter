part of masamune.form;

class FormItemLabeledDropdownField extends StatelessWidget implements FormItem {
  final TextEditingController controller;
  final String labelText;
  final Map<String, String> items;
  final Widget prefix;
  final bool enabled;
  final Widget suffix;
  final bool dense;
  final Color backgroundColor;
  final double height;
  final double dropdownWidth;
  final void Function(String value) onSaved;
  final void Function(String value) onChanged;

  FormItemLabeledDropdownField(
      {this.controller,
      @required this.items,
      this.labelText = "",
      this.prefix,
      this.height = 60,
      this.dropdownWidth = 100,
      this.backgroundColor,
      this.dense = false,
      this.enabled = true,
      this.suffix,
      this.onSaved,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.height,
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).disabledColor,
                style: this.dense ? BorderStyle.none : BorderStyle.solid),
            borderRadius: BorderRadius.circular(4.0)),
        margin: this.dense
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          Expanded(
              flex: 3,
              child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12, top: 4.5, bottom: 4.5),
                  child: Text(this.labelText,
                      style: TextStyle(
                          color: this.enabled
                              ? null
                              : Theme.of(context).disabledColor)))),
          Container(
              constraints: BoxConstraints.expand(width: this.dropdownWidth),
              color: this.backgroundColor,
              padding: const EdgeInsets.fromLTRB(12, 4.5, 8, 4.5),
              alignment: Alignment.center,
              child: DropdownTextFormField(
                  controller: this.controller,
                  isExpanded: true,
                  textAlign: TextAlign.right,
                  items: this.items,
                  enabled: this.enabled,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyText1.color,
                      height: 1.2),
                  decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      prefix: this.prefix,
                      suffix: this.suffix),
                  onChanged: (value) {
                    if (this.onChanged != null) this.onChanged(value);
                  },
                  onSaved: (value) {
                    if (isEmpty(value)) return;
                    if (this.onSaved != null) this.onSaved(value);
                  }))
        ]));
  }
}
