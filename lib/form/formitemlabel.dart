part of masamune.form;

class FormItemLabel extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextDecoration textDecoration;
  final Decoration decoration;
  FormItemLabel(
    this.label, {
    this.padding,
    this.backgroundColor,
    this.color,
    this.decoration,
    this.textDecoration,
    this.fontWeight = FontWeight.bold,
    this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding ?? EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: this.backgroundColor,
      decoration: this.decoration,
      child: Text(
        this.label,
        style: TextStyle(
          color: this.color,
          fontSize: this.fontSize,
          fontWeight: this.fontWeight,
          decoration: this.textDecoration,
        ),
      ),
    );
  }
}
