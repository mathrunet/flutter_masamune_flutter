part of masamune.list;

class AppendableBuilder extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final Widget Function(BuildContext context, List<Widget> children,
      Function onAdd, void Function(String id) onRemove) child;
  final Widget Function(BuildContext context, String id, Function onAdd,
      void Function(String id) onRemove) builder;
  final Iterable<String> initialValues;
  AppendableBuilder(
      {this.child,
      @required this.builder,
      this.title,
      this.backgroundColor,
      this.initialValues = const []})
      : assert(builder != null),
        assert(initialValues != null);
  @override
  State<StatefulWidget> createState() => _AppendableBuilderState();
}

class _AppendableBuilderState extends State<AppendableBuilder> {
  Map<String, Widget> _children;
  @override
  void initState() {
    super.initState();
    this._children = {};
    for (String id in this.widget.initialValues) {
      if (isEmpty(id)) continue;
      this._children[id] =
          this.widget.builder(context, id, this._onAdd, this._onRemove);
    }
  }

  @override
  void didUpdateWidget(AppendableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValues == this.widget.initialValues) return;
    this.widget?.initialValues?.forEach((id) {
      if (isEmpty(id) || this._children.containsKey(id)) return;
      this._children[id] =
          this.widget.builder(context, id, this._onAdd, this._onRemove);
    });
    this.setState(() {});
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
                child: Container(
                    color: this.widget.backgroundColor,
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

/// Item widget for AppendableBuilder.
class AppendableBuilderItem extends StatelessWidget {
  /// Icon data.
  final Icon icon;

  /// Child widget.
  final Widget child;

  /// What happens when a button is pressed.
  final Function onPressed;

  /// Height of the element.
  final double height;

  /// Item widget for AppendableBuilder.
  ///
  /// [icon]: Icon data.
  /// [child]: Child widget.
  /// [onPressed]: What happens when a button is pressed.
  /// [height]: Height of the element.
  AppendableBuilderItem(
      {this.onPressed, this.child, this.icon, this.height = 80})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(flex: 5, child: this.child),
      Flexible(
          flex: 1,
          child: Container(
              height: this.height,
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: this.onPressed,
                  icon: this.icon ?? Icon(Icons.close))))
    ]);
  }
}
