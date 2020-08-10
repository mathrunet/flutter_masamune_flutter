import 'package:flutter/material.dart';
import 'package:masamune_core/masamune_core.dart';

class AppendableBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, List<Widget> children,
      Function onAdd, void Function(String id) onRemove) child;
  final Widget Function(BuildContext context, String id, Function onAdd,
      void Function(String id) onRemove) builder;
  final int initialItemCount;
  AppendableBuilder(
      {@required this.child, @required this.builder, this.initialItemCount = 0})
      : assert(child != null),
        assert(builder != null),
        assert(initialItemCount != null);
  @override
  State<StatefulWidget> createState() => _AppendableBuilderState();
}

class _AppendableBuilderState extends State<AppendableBuilder> {
  Map<String, Widget> _children;
  @override
  void initState() {
    super.initState();
    this._children = {};
    for (int i = 0; i < this.widget.initialItemCount; i++) {
      String id = Texts.uuid;
      this._children[id] =
          this.widget.builder(context, id, this._onAdd, this._onRemove);
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.child(
        context, this._children.values.toList(), this._onAdd, this._onRemove);
  }

  void _onAdd() {
    this.setState(() {
      String id = Texts.uuid;
      this._children[id] =
          this.widget.builder(context, id, this._onAdd, this._onRemove);
    });
  }

  void _onRemove(String id) {
    this.setState(() {
      this._children.remove(id);
    });
  }
}
