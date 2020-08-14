import 'package:flutter/widgets.dart';

class FormBuilder extends StatelessWidget {
  final GlobalKey<FormState> _key;
  final List<Widget> children;
  final FormBuilderType type;

  FormBuilder(
      {@required GlobalKey<FormState> key,
      @required this.children,
      this.type = FormBuilderType.listView})
      : this._key = key;
  @override
  Widget build(BuildContext context) {
    return Form(key: this._key, child: this._buildInternal(context));
  }

  Widget _buildInternal(BuildContext context) {
    switch (this.type) {
      case FormBuilderType.fixed:
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: this.children));
      case FormBuilderType.center:
        return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(children: this.children));
      default:
        return ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: this.children);
    }
  }
}

enum FormBuilderType { listView, center, fixed }
