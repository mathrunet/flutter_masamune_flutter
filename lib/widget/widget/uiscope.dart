import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

///
class UIScope extends ConsumerWidget {
  const UIScope({
    Key key,
    @required ConsumerBuilder builder,
    Widget child,
  })  : _child = child,
        _builder = builder,
        assert(builder != null, "the parameter builder cannot be null"),
        super(key: key);

  final ConsumerBuilder _builder;
  final Widget _child;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return _builder(context, watch, _child);
  }
}
