/// Mixins for using cache on pages.
///
/// Scope to local only.
/// The cache is deleted if this widget is replaced.
abstract class UILocalCacheMixin<T extends Object> {
  /// Cache.
  final UILocalCache<T> cache = UILocalCache<T>();
}

/// This class stores the cache.
class UILocalCache<T extends Object> {
  /// Value of cache.
  T data;
}
