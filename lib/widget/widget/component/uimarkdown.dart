import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

/// Widgets that can use markdown notation.
///
/// See below for description.
/// [https://qiita.com/tbpgr/items/989c6badefff69377da7]
class UIMarkdown extends StatelessWidget {
  final String text;
  final bool selectable;
  final void Function(String url) onTapLink;
  final double imageWidth;
  final MarkdownCheckboxBuilder checkboxBuilder;
  final Color color;
  final double fontSize;

  /// Widgets that can use markdown notation.
  ///
  /// See below for description.
  /// [https://qiita.com/tbpgr/items/989c6badefff69377da7]
  UIMarkdown(
    this.text, {
    this.selectable = true,
    this.onTapLink,
    this.imageWidth = 200,
    this.checkboxBuilder,
    this.color,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: this.color,
        fontSize: this.fontSize,
      ),
      child: MarkdownBody(
        data: this.text,
        selectable: this.selectable,
        imageBuilder: (uri, title, alt) {
          return Image(
            image: NetworkOrAsset.image(uri?.toString()),
            width: this.imageWidth,
          );
        },
        onTapLink: (text, href, title) {
          if (this.onTapLink != null) {
            this.onTapLink(href);
          } else if (href.startsWith("http")) {
            openURL(href);
          } else {
            context.navigator.pushNamed(href);
          }
        },
        checkboxBuilder: this.checkboxBuilder,
        shrinkWrap: true,
        fitContent: true,
      ),
    );
  }
}
