part of masamune.flutter;

/// Class that performs settings for bootstrap.
class BootStrap {
  /// Minimum threshold.
  static const double minSM = 576;

  /// Mobile threshold.
  static const double minMD = 768;

  /// Threshold for tablet PC.
  static const double minLG = 992;

  /// Maximum threshold.
  static const double maxLG = 1200;

  /// Get the current size.
  ///
  /// [BuildContext]: BuildContext.
  GridTier currentSize(BuildContext context) {
    double width = context.mediaQuery.size.width;
    if (width < minSM) {
      return GridTier.xs;
    } else if (width < minMD) {
      return GridTier.sm;
    } else if (width < minLG) {
      return GridTier.md;
    } else if (width < maxLG) {
      return GridTier.lg;
    } else {
      return GridTier.xl;
    }
  }
}

/// GridTier for bootstrap.
enum GridTier {
  /// XS.
  xs,

  /// SM.
  sm,

  /// MD.
  md,

  /// LG.
  lg,

  /// XL
  xl
}
