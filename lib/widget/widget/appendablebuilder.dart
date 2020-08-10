import 'package:flutter/material.dart';
import 'package:masamune_core/masamune_core.dart';

class AppendableBuilder extends StatefulWidget {
  final String title;
  final Widget Function(BuildContext context, List<Widget> children,
      Function onAdd, void Function(String id) onRemove) child;
  final Widget Function(BuildContext context, String id, Function onAdd,
      void Function(String id) onRemove) builder;
  final int initialItemCount;
  AppendableBuilder(
      {this.child,
      @required this.builder,
      this.title,
      this.initialItemCount = 0})
      : assert(builder != null),
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
    if (this.widget.child == null) {
      return Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.only(left: 15),
          constraints: const BoxConstraints.expand(height: 60),
          decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).disabledColor, width: 1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(children: [
            Expanded(
                flex: 4,
                child: Text(this.widget.title ?? Const.empty,
                    style: TextStyle(fontSize: 16))),
            Flexible(
                flex: 1,
                child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      padding: const EdgeInsets.all(10),
                      icon: const Icon(Icons.add),
                      onPressed: this._onAdd,
                    )))
          ]),
        ),
        ...this._children.values
      ]);
    } else {
      return this.widget.child(
          context, this._children.values.toList(), this._onAdd, this._onRemove);
    }
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
