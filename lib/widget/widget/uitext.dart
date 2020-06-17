import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Widget which extended [Text] for Path.
class UIText extends UIWidget {
  final String Function(BuildContext context) builder;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;

  /// Widget which extended [Text] for Path.
  UIText.path(String path,
      {String defaultValue,
      String filter(String value),
      Key key,
      TextStyle style,
      StrutStyle strutStyle,
      TextAlign textAlign,
      TextDirection textDirection,
      Locale locale,
      bool softWrap,
      TextOverflow overflow,
      double textScaleFactor,
      int maxLines,
      String semanticsLabel,
      TextWidthBasis textWidthBasis})
      : this(
            (context) =>
                context.watch(path, defaultValue: defaultValue, filter: filter),
            key: key,
            style: style,
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

  /// Widget which extended [Text] for Path
  UIText(this.builder,
      {Key key,
      this.style,
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

  @override
  List provider(BuildContext context) {
    return [_TextCache(), ...super.provider(context)];
  }

  @override
  bool rebuildable(BuildContext context) {
    return context.consume<_TextCache>()?.text != builder(context);
  }

  @override
  Widget build(BuildContext context) {
    return Text(context.consume<_TextCache>().text = builder(context),
        key: this.key,
        style: style,
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
