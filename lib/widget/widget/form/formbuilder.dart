import 'package:flutter/widgets.dart';
import 'package:masamune_flutter/widget/widget/form/formitem.dart';

class FormBuilder extends StatelessWidget {
  final GlobalKey<FormState> key;
  final List<FormItem> children;

  FormBuilder({@required this.key, @required this.children});
  @override
  Widget build(BuildContext context) {
    return Form(
        key: this.key,
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: this.children));
  }
}
