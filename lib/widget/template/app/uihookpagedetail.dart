import 'package:masamune_flutter/masamune_flutter.dart';
import 'package:flutter/material.dart';

/// Detail Page Template.
abstract class UIHookPageDetail extends UIHookPageScaffold {
  /// Detailed data documentation.
  IDataDocument get document;

  /// The height of the image, calculated as it is with null.
  double get imageHeight => null;

  /// Image data.
  ImageProvider get image => null;

  /// Widget to place between the title and the image.
  ///
  /// [context]: Build context.
  Widget top(BuildContext context) => null;

  /// Title.
  String get title;

  /// Content.
  ///
  /// [context]: Build context.
  List<Widget> content(BuildContext context);

  /// Additional content outside of content.
  ///
  /// [context]: Build context.
  List<Widget> bottom(BuildContext context) => [];

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
    final title = this.title;
    final top = this.top(context);
    return ListView(
      children: <Widget>[
        if (this.image != null)
          Image(height: this.imageHeight, image: this.image, fit: BoxFit.cover),
        Stack(
          children: [
            Indent(
              padding: const EdgeInsets.all(15),
              children: [
                if (isNotEmpty(title)) ...[
                  Text(
                    this.title,
                    style: context.theme.textTheme.headline4
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Space(),
                ],
                ...(this.content(context) ?? []),
              ],
            ),
            if (top != null)
              Container(
                alignment: Alignment.topRight,
                child: top,
              )
          ],
        ),
        ...(this.bottom(context) ?? [])
      ],
    );
  }
}
