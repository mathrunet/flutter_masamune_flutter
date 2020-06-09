import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// List tile whose display changes responsively.
class ResponsiveListTile extends StatelessWidget {
  /// The threshold to switch the display.
  final double thresholdWidth;

  /// The height of the card when viewed on a PC.
  final double elevation;

  /// Bottom margin for PC display.
  final double marginBottom;

  /// PC style.
  final ResponsiveListTileStyle style;

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget leading;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  ///
  /// This should not wrap.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  ///
  /// If [isThreeLine] is false, this should not wrap.
  ///
  /// If [isThreeLine] is true, this should be configured to take a maximum of
  /// two lines.
  final Widget subtitle;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  ///
  /// To show right-aligned metadata (assuming left-to-right reading order;
  /// left-aligned for right-to-left reading order), consider using a [Row] with
  /// [MainAxisAlign.baseline] alignment whose first item is [Expanded] and
  /// whose second child is the metadata text, instead of using the [trailing]
  /// property.
  final Widget trailing;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If true, then [subtitle] must be non-null (since it is expected to give
  /// the second and third lines of text).
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  ///
  /// Dense list tiles default to a smaller height.
  final bool dense;

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry contentPadding;

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onTap] and [onLongPress] callbacks are
  /// inoperative.
  final bool enabled;

  /// Called when the user taps this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapCallback onTap;

  /// Called when the user long-presses on this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureLongPressCallback onLongPress;

  /// If this tile is also [enabled] then icons and text are rendered with the same color.
  ///
  /// By default the selected color is the theme's primary color. The selected color
  /// can be overridden with a [ListTileTheme].
  final bool selected;

  /// List tile whose display changes responsively.
  ResponsiveListTile(
      {this.style = ResponsiveListTileStyle.border,
      this.thresholdWidth = BootStrap.minLG,
      this.title,
      this.elevation = 5,
      this.marginBottom = 10,
      this.leading,
      this.subtitle,
      this.trailing,
      this.isThreeLine = false,
      this.dense,
      this.contentPadding,
      this.enabled = true,
      this.onTap,
      this.onLongPress,
      this.selected = false});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (context.mediaQuery.size.width >= this.thresholdWidth) {
        switch (this.style) {
          case ResponsiveListTileStyle.card:
            return Card(
                color: context.theme.cardColor,
                elevation: this.elevation,
                margin: EdgeInsets.only(bottom: this.marginBottom),
                child: ListTile(
                    title: this.title,
                    leading: this.leading,
                    subtitle: this.subtitle,
                    trailing: this.trailing,
                    isThreeLine: this.isThreeLine,
                    dense: this.dense,
                    contentPadding: this.contentPadding,
                    enabled: this.enabled,
                    onTap: this.onTap,
                    onLongPress: this.onLongPress,
                    selected: this.selected));
          default:
            return Container(
                margin: EdgeInsets.only(bottom: this.marginBottom),
                child: ListTile(
                    title: this.title,
                    leading: this.leading,
                    subtitle: this.subtitle,
                    trailing: this.trailing,
                    isThreeLine: this.isThreeLine,
                    dense: this.dense,
                    contentPadding: this.contentPadding,
                    enabled: this.enabled,
                    onTap: this.onTap,
                    onLongPress: this.onLongPress,
                    selected: this.selected),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: context.theme.dividerColor,
                    )));
            break;
        }
      } else {
        return ListTile(
            title: this.title,
            leading: this.leading,
            subtitle: this.subtitle,
            trailing: this.trailing,
            isThreeLine: this.isThreeLine,
            dense: this.dense,
            contentPadding: this.contentPadding,
            enabled: this.enabled,
            onTap: this.onTap,
            onLongPress: this.onLongPress,
            selected: this.selected);
      }
    });
  }
}

/// Specifies the style of ResponsiveListTile on PC.
enum ResponsiveListTileStyle {
  /// Border style.
  border,

  /// Card style.
  card
}
