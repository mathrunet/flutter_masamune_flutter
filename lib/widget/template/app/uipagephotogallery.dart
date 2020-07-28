import 'package:masamune_flutter/masamune_flutter.dart';
import 'package:flutter/material.dart';

/// Abstract class for using pages for Photo gallery.
///
/// Specifying [images] will display the gallery of that image.
abstract class UIPagePhotoGallery extends UIPageScaffold {
  /// Specifies a list of images.
  ///
  /// [context]: Build context.
  Map<ImageProvider, VoidAction> images(BuildContext context);

  /// Image height size.
  double get height => 200.0;

  /// Specify the number next to the image.
  int get crossAxisCount => 4;

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
    return GridView.count(
        crossAxisCount: this.crossAxisCount,
        children: this.images(context)?.toList((image, action) {
              return GestureDetector(
                  onTap: action,
                  child: Image(
                      image: image, height: this.height, fit: BoxFit.cover));
            })?.toList() ??
            []);
  }
}
