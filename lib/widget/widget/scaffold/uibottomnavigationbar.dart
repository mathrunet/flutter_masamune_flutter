import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Wrapper for BottomNavigationBar.
class UIBottomNavigationBar extends StatelessWidget {
  final List<UIBottomNavigationBarItem> items;
  final int initialIndex;
  final double elevation;
  final Widget top;
  final BottomNavigationBarType type;
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

  /// Wrapper for BottomNavigationBar.
  UIBottomNavigationBar(
      {Key key,
      this.items,
      this.top,
      this.initialIndex = 0,
      this.disableOnTapWhenInitialIndex = true,
      this.elevation = 8.0,
      this.type = BottomNavigationBarType.fixed,
      this.fixedColor,
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
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (this.top != null) ...[
        Divider(height: 1),
        this.top,
        Divider(height: 1),
      ],
      BottomNavigationBar(
        key: this.key,
        items: this.items,
        onTap: (index) {
          if (this.items == null || this.items.length <= index || index < 0)
            return;
          if (this.items[index]?.onTap == null) return;
          if (this.disableOnTapWhenInitialIndex && index == this.initialIndex)
            return;
          this.items[index]?.onTap();
        },
        currentIndex: this.initialIndex,
        elevation: this.elevation,
        type: this.type,
        fixedColor: this.fixedColor,
        backgroundColor:
            this.backgroundColor ?? Theme.of(context)?.bottomAppBarColor,
        iconSize: this.iconSize,
        selectedItemColor:
            this.selectedItemColor ?? Theme.of(context)?.primaryColor,
        unselectedItemColor: this.unselectedItemColor ??
            Theme.of(context)?.bottomAppBarTheme?.color,
        selectedIconTheme: this.selectedIconTheme,
        unselectedIconTheme: this.unselectedIconTheme,
        selectedFontSize: this.selectedFontSize,
        unselectedFontSize: this.unselectedFontSize,
        selectedLabelStyle: this.selectedLabelStyle,
        unselectedLabelStyle: this.unselectedLabelStyle,
        showSelectedLabels: this.showSelectedLabels,
        showUnselectedLabels: this.showUnselectedLabels,
      )
    ]);
  }
}

/// Wrapper for BottomNavigationBarItem.
class UIBottomNavigationBarItem extends BottomNavigationBarItem {
  final void Function() onTap;

  /// Wrapper for BottomNavigationBarItem.
  UIBottomNavigationBarItem(
      {Widget icon,
      Widget title,
      Widget activeIcon,
      Color backgroundColor,
      this.onTap})
      : super(
            icon: icon,
            title: title,
            activeIcon: activeIcon,
            backgroundColor: backgroundColor);
}
