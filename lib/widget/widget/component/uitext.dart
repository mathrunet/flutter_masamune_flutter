import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';

/// Widget which extended [Text] for Path.
class UIText extends StatefulWidget {
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
  State<StatefulWidget> createState() => _UITextState();
}

class _UITextState extends State<UIText> {
  String _regexString;

  @override
  void initState() {
    super.initState();
    List<String> regex = ListPool.get();
    if (this.widget.enableMention) regex.add("@[\\w]+");
    if (this.widget.enableHashTag) regex.add("#[\\w]+");
    regex.add(AutoLinkUtils.urlRegExpPattern);
    this._regexString = regex.join("|");
    regex.release();
  }

  @override
  Widget build(BuildContext context) {
    return SelectableAutoLinkText(
      this.widget.autoLocalize
          ? this.widget.text?.localize()
          : this.widget.text,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      key: this.widget.key,
      style: this.widget.style?.copyWith(
              fontSize: this.widget.fontSize,
              fontWeight: this.widget.fontWeight,
              color: this.widget.color,
              height: this.widget.height) ??
          TextStyle(
            color: this.widget.color,
            fontSize: this.widget.fontSize,
            fontWeight: this.widget.fontWeight,
            height: this.widget.height,
          ),
      onTransformDisplayLink:
          this.widget.shrinkUrl ? AutoLinkUtils.shrinkUrl : null,
      linkStyle: this.widget.linkStyle ??
          TextStyle(color: this.widget.linkColor ?? Colors.blueAccent),
      highlightedLinkStyle: this.widget.highlightedLinkStyle ??
          TextStyle(
            color: this.widget.linkColor ?? Colors.blueAccent,
            backgroundColor: this.widget.highlightedColor ??
                Colors.blueAccent.withAlpha(0x33),
          ),
      linkRegExpPattern: this._regexString,
      strutStyle: this.widget.strutStyle,
      textAlign: this.widget.textAlign,
      textDirection: this.widget.textDirection,
      textScaleFactor: this.widget.textScaleFactor,
      maxLines: this.widget.maxLines,
      textWidthBasis: this.widget.textWidthBasis,
      onTap: this.widget.onTap ??
          (url) {
            if (url.startsWith("http")) {
              openURL(url);
            } else {
              context.navigator.pushNamed(url);
            }
          },
      onLongPress: this.widget.onLongPress ?? (url) => Share.share(url),
    );
  }
}
