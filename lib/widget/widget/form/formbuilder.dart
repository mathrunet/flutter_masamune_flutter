import 'package:flutter/widgets.dart';

class FormBuilder extends StatelessWidget {
  final GlobalKey<FormState> _key;
  final List<Widget> children;

  FormBuilder({@required GlobalKey<FormState> key, @required this.children})
      : this._key = key;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: this._key,
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: this.children));
  }
}
