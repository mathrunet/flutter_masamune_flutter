import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';

/// Widget which extended [Text] for Path.
class UIText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final double textScaleFactor;
  final double fontSize;
  final int maxLines;
  final Color color;
  final FontWeight fontWeight;
  final TextWidthBasis textWidthBasis;
  final void Function() onTap;
  final void Function() onLongPress;
  final TextStyle linkStyle;
  final TextStyle highlightedLinkStyle;
  final Color linkColor;
  final Color highlightedColor;
  final bool shrinkUrl;
  final bool enableHashTag;
  final bool enableMention;
  final double height;
  final bool autoLocalize;

  /// Widget which extended [Text] for Path
  UIText(
    this.text, {
    Key key,
    this.autoLocalize = true,
    this.shrinkUrl = false,
    this.enableHashTag = false,
    this.enableMention = false,
    this.linkStyle,
    this.highlightedLinkStyle,
    this.height,
    this.linkColor,
    this.highlightedColor,
    this.onTap,
    this.onLongPress,
    this.style,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.maxLines,
    this.textWidthBasis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> regex = ListPool.get();
    if (this.enableMention) regex.add("@[\\w]+");
    if (this.enableHashTag) regex.add("#[\\w]+");
    regex.add(AutoLinkUtils.urlRegExpPattern);
    String regexString = regex.join("|");
    regex.release();
    return SelectableAutoLinkText(
      this.autoLocalize ? this.text?.localize() : this.text,
      key: this.key,
      style: style?.copyWith(
              fontSize: this.fontSize,
              fontWeight: this.fontWeight,
              color: this.color,
              height: this.height) ??
          TextStyle(
            color: this.color,
            fontSize: this.fontSize,
            fontWeight: this.fontWeight,
            height: this.height,
          ),
      onTransformDisplayLink: this.shrinkUrl ? AutoLinkUtils.shrinkUrl : null,
      linkStyle: this.linkStyle ??
          TextStyle(color: this.linkColor ?? Colors.blueAccent),
      highlightedLinkStyle: this.highlightedLinkStyle ??
          TextStyle(
            color: this.linkColor ?? Colors.blueAccent,
            backgroundColor:
                this.highlightedColor ?? Colors.blueAccent.withAlpha(0x33),
          ),
      linkRegExpPattern: regexString,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      onTap: this.onTap ?? (url) => openURL(url),
      onLongPress: this.onLongPress ?? (url) => Share.share(url),
    );
  }
}
