import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Widget which extended [AppBar] for Path.
class UIAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Key key;
  final Widget leading;
  final bool automaticallyImplyLeading;
  final WidgetBuilder title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final ShapeBorder shape;
  final Color backgroundColor;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final bool excludeHeaderSemantics;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;

  /// Widget which extended [AppBar] for Path
  UIAppBar({
    this.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shape,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  })  : this.preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        key: this.key,
        leading: this.leading,
        automaticallyImplyLeading: this.automaticallyImplyLeading,
        title: this.title != null ? this.title(context) : null,
        actions: this.actions,
        flexibleSpace: this.flexibleSpace,
        bottom: this.bottom,
        elevation: this.elevation,
        shape: this.shape,
        backgroundColor: this.backgroundColor,
        brightness: this.brightness,
        iconTheme: this.iconTheme,
        actionsIconTheme: this.actionsIconTheme,
        textTheme: this.textTheme,
        primary: this.primary,
        centerTitle: this.centerTitle,
        excludeHeaderSemantics: this.excludeHeaderSemantics,
        titleSpacing: this.titleSpacing,
        toolbarOpacity: this.toolbarOpacity,
        bottomOpacity: this.bottomOpacity);
  }

  @override
  final Size preferredSize;
}
