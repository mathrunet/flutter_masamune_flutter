import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Reorderable list view.
///
/// Basically, we put [UIReorderableButton] in the element we pass to [children].
class UIReorderableListView extends StatefulWidget {
  /// Child element.
  final List<Widget> children;

  /// Padding.
  final EdgeInsetsGeometry padding;

  /// Reorderable list view.
  ///
  /// Basically, we put [UIReorderableButton] in the element we pass to [children].
  UIReorderableListView({@required this.children, this.padding})
      : assert(children != null);
  @override
  State<StatefulWidget> createState() => _UIReorderableListViewState();
}

class _UIReorderableListViewState extends State<UIReorderableListView> {
  List<_UIReorderableListViewData> _children;
  @override
  void initState() {
    super.initState();
    if (this.widget.children == null) return;
    this._children = this.widget.children.mapAndRemoveEmpty((e) {
      if (e == null) return null;
      return _UIReorderableListViewData(e);
    });
  }

  @protected
  void didUpdateWidget(UIReorderableListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children != this.widget.children) {
      this._children = this.widget.children.mapAndRemoveEmpty((e) {
        if (e == null) return null;
        return _UIReorderableListViewData(e);
      });
    }
  }

  int _indexOfKey(Key key) {
    return _children?.indexWhere((d) => d?.key == key);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
        onReorder: (Key item, Key newPosition) {
          int draggingIndex = _indexOfKey(item);
          int newPositionIndex = _indexOfKey(newPosition);
          final draggedItem = _children[draggingIndex];
          this.setState(() {
            _children.removeAt(draggingIndex);
            _children.insert(newPositionIndex, draggedItem);
          });
          return true;
        },
        child: ListView(
            padding: this.widget.padding,
            children: this._children.mapAndRemoveEmpty((item) =>
                ReorderableItem(
                    key: item.key,
                    childBuilder: (context, state) => item.widget))));
  }
}

class _UIReorderableListViewData {
  final Widget widget;
  final ValueKey key;
  _UIReorderableListViewData(this.widget)
      : this.key = ValueKey(widget.hashCode);
}

/// Handle for the reorder to be used in [UIReorderableListView].
class UIReorderableButton extends StatelessWidget {
  /// Padding.
  final EdgeInsetsGeometry padding;

  /// Callbacks to determine if you can reorder.
  final bool Function() canStart;

  /// Button Color.
  final Color color;

  /// Child element.
  final Widget child;

  /// Handle for the reorder to be used in [UIReorderableListView].
  UIReorderableButton({this.padding, this.color, this.canStart, this.child});

  /// Build widgets.
  ///
  /// [context]: Build Context.
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: this.padding,
        color: this.color,
        child: ReorderableListener(
          child: this.child,
          canStart: this.canStart,
        ));
  }
}
