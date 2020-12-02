import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masamune_core/masamune_core.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Wrapper for BottomNavigationBar.
class UIBottomNavigationBar extends StatefulWidget {
  final List<UIBottomNavigationBarItem> items;
  final int initialIndex;
  final double elevation;
  final Widget top;
  final Widget bottom;
  final BottomNavigationBarType type;
  final InternalNavigatorObserver routeObserver;
  final Color fixedColor;
  final Color backgroundColor;
  final double iconSize;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;
  final double selectedFontSize;
  final double unselectedFontSize;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final bool disableOnTapWhenInitialIndex;
  final String indexID;

  /// Wrapper for BottomNavigationBar.
  UIBottomNavigationBar(
      {Key key,
      this.indexID,
      this.items,
      this.top,
      this.initialIndex = 0,
      this.disableOnTapWhenInitialIndex = true,
      this.elevation = 8.0,
      this.bottom,
      this.type = BottomNavigationBarType.fixed,
      this.fixedColor,
      this.routeObserver,
      this.backgroundColor,
      this.iconSize = 24.0,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.selectedIconTheme = const IconThemeData(),
      this.unselectedIconTheme = const IconThemeData(),
      this.selectedFontSize = 14.0,
      this.unselectedFontSize = 12.0,
      this.selectedLabelStyle,
      this.unselectedLabelStyle,
      this.showSelectedLabels = true,
      this.showUnselectedLabels})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UIBottomNavigationBarState();
}

class _UIBottomNavigationBarState extends State<UIBottomNavigationBar>
    with RouteAware {
  int currentIndex;
  @override
  void initState() {
    super.initState();
    this.currentIndex = this.widget.initialIndex;
    if (isNotEmpty(this.widget.indexID))
      this.currentIndex = this
          .widget
          .items
          .indexWhere((element) => element.id == this.widget.indexID);
    if (this.currentIndex < 0) this.currentIndex = this.widget.initialIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.widget.routeObserver?.subscribe(_onRouteChange);
  }

  @override
  void dispose() {
    super.dispose();
    this.widget.routeObserver?.unsubscribe(_onRouteChange);
  }

  void _onRouteChange(Route route) {
    if (this.widget.routeObserver == null) return;
    if (this.widget.items == null || this.widget.items.length <= 0) return;
    for (int i = 0; i < this.widget.items.length; i++) {
      UIBottomNavigationBarItem item = this.widget.items[i];
      if (i == this.currentIndex) continue;
      if (item == null || item.onRouteChange == null) continue;
      if (!item.onRouteChange(route)) continue;
      this.setState(() {
        this.currentIndex = i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (this.widget.top != null) ...[
        Divider(height: 1),
        this.widget.top,
      ],
      Divider(height: 1),
      BottomNavigationBar(
        key: this.widget.key,
        items: this.widget.items,
        onTap: (index) {
          if (this.widget.items == null ||
              this.widget.items.length <= index ||
              index < 0) return;
          if (index == this.currentIndex) {
            this.widget.items[index]?.onTapWhenInitialIndex?.call();
            if (this.widget.disableOnTapWhenInitialIndex) return;
          }
          this.widget.items[index]?.onTap?.call();
        },
        currentIndex: this.currentIndex,
        elevation: this.widget.elevation,
        type: this.widget.type,
        fixedColor: this.widget.fixedColor,
        backgroundColor:
            this.widget.backgroundColor ?? Theme.of(context)?.bottomAppBarColor,
        iconSize: this.widget.iconSize,
        selectedItemColor:
            this.widget.selectedItemColor ?? Theme.of(context)?.primaryColor,
        unselectedItemColor: this.widget.unselectedItemColor ??
            Theme.of(context)?.bottomAppBarTheme?.color,
        selectedIconTheme: this.widget.selectedIconTheme,
        unselectedIconTheme: this.widget.unselectedIconTheme,
        selectedFontSize: this.widget.selectedFontSize,
        unselectedFontSize: this.widget.unselectedFontSize,
        selectedLabelStyle: this.widget.selectedLabelStyle,
        unselectedLabelStyle: this.widget.unselectedLabelStyle,
        showSelectedLabels: this.widget.showSelectedLabels,
        showUnselectedLabels: this.widget.showUnselectedLabels,
      ),
      if (this.widget.bottom != null) ...[
        Divider(height: 1),
        this.widget.bottom,
      ],
    ]);
  }
}

/// Wrapper for BottomNavigationBarItem.
class UIBottomNavigationBarItem extends BottomNavigationBarItem {
  final String id;
  final void Function() onTap;
  final bool Function(Route route) onRouteChange;
  final void Function() onTapWhenInitialIndex;

  /// Wrapper for BottomNavigationBarItem.
  UIBottomNavigationBarItem(
      {this.id,
      Widget icon,
      Widget title,
      Widget activeIcon,
      Color backgroundColor,
      this.onTap,
      this.onTapWhenInitialIndex,
      this.onRouteChange})
      : super(
            icon: icon,
            title: title,
            activeIcon: activeIcon,
            backgroundColor: backgroundColor);
}
