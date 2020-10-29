import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'package:photo_view/photo_view.dart';

/// Page abstract class for displaying images.
///
/// You can easily create a view that can be scaled by setting [image].
abstract class UIPagePhotoView extends UIPageScaffold {
  /// Specify the image provider.
  ///
  /// [context]: Build context.
  ImageProvider image(BuildContext context);

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
    return PhotoView(
      imageProvider: this.image(context),
      backgroundDecoration: this.backgroundColor != null
          ? BoxDecoration(color: this.backgroundColor)
          : null,
    );
  }
}
