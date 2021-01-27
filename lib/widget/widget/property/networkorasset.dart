import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:masamune_core/masamune_core.dart';

/// Providing the right provider by choosing between in-network and assets.
class NetworkOrAsset {
  /// Providing the right provider by choosing between in-network and assets.
  ///
  /// Get the provider for the image.
  ///
  /// [uri]: If it starts with http, get a network image,
  /// otherwise get an asset image.
  /// [defaultURI]: The path to be read from the asset when [uri] is empty.
  static ImageProvider image(String uri,
      [String defaultURI = "assets/icon.png"]) {
    if (isEmpty(uri)) {
      if (isEmpty(defaultURI)) return null;
      return AssetImage(defaultURI);
    }
    if (uri.startsWith("http")) {
      return CachedNetworkImageProvider(uri);
    } else if (uri.startsWith("device:") || uri.startsWith("local:")) {
      File file = File(uri.replaceAll(RegExp(r"(device|local):(//)?"),
          "${Config.documentDirectory.path}/"));
      return FileImage(file);
    } else if (uri.startsWith("resource:")) {
      return AssetImage(uri.replaceAll(RegExp(r"resource:(//)?"), ""));
    } else {
      return AssetImage(uri);
    }
  }
}
