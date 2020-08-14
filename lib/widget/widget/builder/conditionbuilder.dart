import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Widget that changes the display based on conditions.
///
/// When [condition] is True, the contents of [builderIfTrue] are displayed.
///
/// In all other cases, [builderIfFalse] is displayed.
class ConditionBuilder extends StatefulWidget {
  /// Widget that changes the display based on conditions.
  ///
  /// When [condition] is True, the contents of [builderIfTrue] are displayed.
  ///
  /// In all other cases, [builderIfFalse] is displayed.
  ///
  /// [key]: Widget key.
  /// [condition]: The condition for displaying the widget.
  /// [builderIfTrue]: Widget builder when [condition] is True.
  /// [builderIfFalse]: Widget builder when [condition] is True.
  const ConditionBuilder({
    Key key,
    @required this.condition,
    this.builderIfTrue,
    this.builderIfFalse,
  }) : super(key: key);

  /// The condition for displaying the widget.
  final bool Function() condition;

  /// Widget builder when [condition] is True.
  final WidgetBuilder builderIfTrue;

  /// Widget builder when [condition] is False.
  final WidgetBuilder builderIfFalse;

  /// State creation.
  @override
  State<ConditionBuilder> createState() => _ConditionBuilderState();
}

class _ConditionBuilderState extends State<ConditionBuilder>
    with SingleTickerProviderStateMixin {
  bool _state = false;
  Ticker _ticker;
  @override
  void initState() {
    super.initState();
    this._state = false;
    this._ticker = this.createTicker((elapsed) {
      bool state = this.widget.condition();
      if (this._state == state) return;
      this._state = state;
      this.setState(() {});
    });
    this._ticker.start();
  }

  @override
  void dispose() {
    this._ticker.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!this.widget.condition()) {
      if (this.widget.builderIfFalse != null)
        return this.widget.builderIfFalse(context);
    } else {
      if (this.widget.builderIfTrue != null)
        return this.widget.builderIfTrue(context);
    }
    return Container();
  }
}
