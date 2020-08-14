import 'package:flutter/material.dart';

/// Create a small gallery in the list.
class SmallGallery extends StatelessWidget {
  /// Gallery element.
  final List<Widget> children;

  /// The height of the gallery.
  final double height;

  /// The number next to the gallery.
  final int crossAxisCount;

  /// Create a small gallery in the list.
  ///
  /// [children]: Gallery element.
  /// [height]: The height of the gallery.
  /// [crossAxisCount]: The number next to the gallery.
  SmallGallery(
      {@required this.children, this.height = 200, this.crossAxisCount = 4});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: this.height),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: this.crossAxisCount,
        children: this.children,
      ),
    );
  }
}
