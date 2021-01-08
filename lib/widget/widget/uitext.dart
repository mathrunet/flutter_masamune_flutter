import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Widget which extended [Text] for Path.
class UIText extends UIWidget {
  final String text;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final double fontSize;
  final int maxLines;
  final Color color;
  final FontWeight fontWeight;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;

  /// Widget which extended [Text] for Path
  UIText(this.text,
      {Key key,
      this.style,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis})
      : super(key: key);

  // @override
  // bool rebuildable(BuildContext context) {
  //   return context.consume<_TextCache>()?.text != builder(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Text(this.text,
        key: this.key,
        style: style?.copyWith(
                fontSize: fontSize, fontWeight: fontWeight, color: color) ??
            TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis);
  }
}

class _TextCache {
  String text;
}
