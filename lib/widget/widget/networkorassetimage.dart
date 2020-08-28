import 'package:flutter/material.dart';

/// Providing the right provider by choosing between in-network and assets.
class NetworkOrAsset {
  /// Providing the right provider by choosing between in-network and assets.
  ///
  /// Get the provider for the image.
  ///
  /// [uri]: If it starts with http, get a network image,
  /// otherwise get an asset image.
  static ImageProvider image(String uri) {
    if (uri.startsWith("http")) {
      return NetworkImage(uri);
    } else {
      return AssetImage(uri);
    }
  }
}
