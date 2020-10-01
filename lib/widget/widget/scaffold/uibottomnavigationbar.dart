import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masamune_core/masamune_core.dart';

/// Wrapper for BottomNavigationBar.
class UIBottomNavigationBar extends StatefulWidget {
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
  State<StatefulWidget> createState() => _UIBottomNavigationBarState();
}

class _UIBottomNavigationBarState extends State<UIBottomNavigationBar> {
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
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (this.widget.top != null) ...[
        Divider(height: 1),
        this.widget.top,
        Divider(height: 1),
      ],
      BottomNavigationBar(
        key: this.widget.key,
        items: this.widget.items,
        onTap: (index) {
          if (this.widget.items == null ||
              this.widget.items.length <= index ||
              index < 0) return;
          if (this.widget.items[index]?.onTap == null) return;
          if (this.widget.disableOnTapWhenInitialIndex &&
              index == this.currentIndex) return;
          this.setState(() {
            this.currentIndex = index;
            this.widget.items[index]?.onTap();
          });
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
      )
    ]);
  }
}

/// Wrapper for BottomNavigationBarItem.
class UIBottomNavigationBarItem extends BottomNavigationBarItem {
  final String id;
  final void Function() onTap;

  /// Wrapper for BottomNavigationBarItem.
  UIBottomNavigationBarItem(
      {this.id,
      Widget icon,
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
