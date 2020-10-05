part of masamune.list;

/// Draw a dividing line.
class Divid extends Divider {
  /// Draw a dividing line.
  Divid(
      {Key key, double thickness, double indent, double endIndent, Color color})
      : super(
            key: key,
            thickness: thickness,
            indent: indent,
            height: 1,
            endIndent: endIndent,
            color: color);

  /// Draw a dividing line.
  Divid.height(double height,
      {Key key, double thickness, double indent, double endIndent, Color color})
      : super(
            key: key,
            height: height,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
            color: color);
}
