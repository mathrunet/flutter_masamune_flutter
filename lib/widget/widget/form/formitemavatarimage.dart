import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'formitem.dart';

class FormItemAvatarImage extends StatelessWidget implements FormItem {
  final ImageProvider image;
  final Widget label;
  final VoidAction onPressed;
  FormItemAvatarImage({this.image, this.label, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundColor: context.theme.canvasColor,
                  backgroundImage: this.image,
                )),
            FlatButton(
                shape: StadiumBorder(),
                child: this.label,
                onPressed: this.onPressed,
                color: context.theme.primaryColor)
          ],
        ));
  }
}
