import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masamune_core/masamune_core.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Wrapper for UITopNavigationBar.
class UITopNavigationBar extends StatefulWidget {
  final List<UITopNavigationBarItem> items;
  final int initialIndex;
  final InternalNavigatorObserver routeObserver;
  final Color fixedColor;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color selectedItemTextColor;
  final Color unselectedItemTextColor;
  final bool showSelectedLabels;
  final bool disableOnTapWhenInitialIndex;
  final String indexID;
  final double height;
  final EdgeInsetsGeometry padding;

  /// Wrapper for UITopNavigationBar.
  UITopNavigationBar(
      {Key key,
      this.indexID,
      this.padding = const EdgeInsets.all(6),
      this.height = 40,
      this.items,
      this.initialIndex = 0,
      this.disableOnTapWhenInitialIndex = true,
      this.fixedColor,
      this.routeObserver,
      this.backgroundColor,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.selectedItemTextColor,
      this.unselectedItemTextColor,
      this.showSelectedLabels = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UITopNavigationBarState();
}

class _UITopNavigationBarState extends State<UITopNavigationBar>
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
      UITopNavigationBarItem item = this.widget.items[i];
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
    int index = 0;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        height: this.widget.height,
        color:
            this.widget.backgroundColor ?? Theme.of(context).bottomAppBarColor,
        padding: this.widget.padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...this.widget.items.mapAndRemoveEmpty(
              (e) {
                final selected = index == this.currentIndex;
                if (!this.widget.showSelectedLabels && selected) return null;
                index++;
                return Flexible(
                  flex: 1,
                  child: FlatButton(
                    shape: StadiumBorder(),
                    color: selected
                        ? (this.widget.selectedItemColor ??
                            context.theme.primaryColor)
                        : (this.widget.unselectedItemColor),
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      if (this.widget.disableOnTapWhenInitialIndex && selected)
                        return;
                      e.onTap?.call();
                    },
                    child: DefaultTextStyle.merge(
                        style: TextStyle(
                            color: selected
                                ? (this.widget.selectedItemTextColor ??
                                    Colors.white)
                                : (this.widget.unselectedItemTextColor)),
                        child: e.title),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      Divider(height: 1),
    ]);
  }
}

/// Wrapper for UITopNavigationBarItem.
class UITopNavigationBarItem {
  final String id;
  final Widget title;
  final void Function() onTap;
  final bool Function(Route route) onRouteChange;

  /// Wrapper for UITopNavigationBarItem.
  const UITopNavigationBarItem(
      {this.id, this.title, this.onTap, this.onRouteChange});
}