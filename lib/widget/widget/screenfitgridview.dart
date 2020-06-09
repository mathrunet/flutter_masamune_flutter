import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// The grid is displayed in full screen up to a certain count and then scrolled.
class ScreenFitGridView extends StatelessWidget {
  /// Widget element.
  final List<Widget> children;

  /// The grid is displayed in full screen up to a certain count and then scrolled.
  ///
  /// [key]: Widget key.
  /// [children]: Widget element.
  ScreenFitGridView({Key key, @required this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (this.children == null || this.children.length <= 0) return Container();
    return LayoutBuilder(builder: (context, constraints) {
      int length = children.length;
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;
      if (width < height) {
        if (length > 8) {
          return SingleChildScrollView(
              child: Column(
                  children: children.split(2).map((d) {
            return Row(
                children: d
                    .map((e) => Expanded(
                        child: Container(height: height / 4, child: e)))
                    .toList());
          }).toList()));
        } else if (length > 3) {
          return Column(
              children: children.split(2).map((d) {
            return Expanded(
                child: Row(
                    children: d
                        .map((e) => Expanded(
                            child: Container(
                                height: height / (length / 2).ceil(),
                                child: e)))
                        .toList()));
          }).toList());
        } else {
          return Column(
              children: children.map((e) {
            return Expanded(
                child: Row(children: [
              Expanded(child: Container(height: height / length, child: e))
            ]));
          }).toList());
        }
      } else {
        if (length > 8) {
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: children.split(2).map((d) {
                return Column(
                    children: d
                        .map((e) => Expanded(
                            child: Container(width: width / 4, child: e)))
                        .toList());
              }).toList()));
        } else if (length > 3) {
          return Row(
              children: children.split(2).map((e) {
            return Expanded(
                child: Column(
                    children: e
                        .map((e) => Expanded(
                            child: Container(
                                width: width / (length / 2).ceil(), child: e)))
                        .toList()));
          }).toList());
        } else {
          return Row(
              children: children.map((e) {
            return Expanded(
                child: Column(children: [
              Expanded(child: Container(width: width / length, child: e))
            ]));
          }).toList());
        }
      }
    });
  }
}
