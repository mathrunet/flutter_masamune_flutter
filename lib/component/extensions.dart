part of masamune.flutter;

/// MediaQuery extension methods.
extension MediaQueryExtension on MediaQueryData {
  /// Calculate the size when dividing the horizontal length.
  ///
  /// Enter the actual number of elements in [count]
  /// and the maximum number to place horizontally in [maxHorizontalCount].
  ///
  /// [count]:　Element count.
  /// [maxHorizontalCount]: Maximum number of horizontal elements.
  double divisionWidth(int count, {int maxHorizontalCount = 5}) {
    if (count < 1) count = 1;
    if (maxHorizontalCount < 1) maxHorizontalCount = 1;
    double width = this.size.width;
    return (width / count).limitLow(width / maxHorizontalCount);
  }

  /// Calculate the size when dividing the vertical length.
  ///
  /// Enter the actual number of elements in [count]
  /// and the maximum number to place vertically in [maxVerticalCount].
  ///
  /// [count]:　Element count.
  /// [maxVerticalCount]: Maximum number of vertical elements.
  double divisionHeight(int count, {int maxVerticalCount = 5}) {
    if (count < 1) count = 1;
    if (maxVerticalCount < 1) maxVerticalCount = 1;
    double height = this.size.height;
    return (height / count).limitLow(height / maxVerticalCount);
  }
}
