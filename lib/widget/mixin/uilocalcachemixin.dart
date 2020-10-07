import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Mixins for using cache on pages.
///
/// Scope to local only.
/// The cache is deleted if this widget is replaced.
mixin UILocalCacheMixin<T extends Object> on Widget {
  /// Cache.
  final UILocalCache<T> cache = UILocalCache<T>();
}

/// This class stores the cache.
class UILocalCache<T extends Object> {
  /// Value of cache.
  T data;
}
