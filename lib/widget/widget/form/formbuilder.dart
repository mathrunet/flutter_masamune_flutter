import 'package:flutter/widgets.dart';

class FormBuilder extends StatelessWidget {
  final GlobalKey<FormState> _key;
  final List<Widget> children;
  final bool center;

  FormBuilder(
      {@required GlobalKey<FormState> key,
      @required this.children,
      this.center = false})
      : this._key = key;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: this._key,
        child: this.center
            ? Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(children: this.children))
            : ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                children: this.children));
  }
}
