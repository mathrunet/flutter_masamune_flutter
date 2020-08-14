import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'formitem.dart';

class FormItemAvatarImage extends StatelessWidget implements FormItem {
  final ImageProvider image;
  final String label;
  final VoidAction onPressed;
  final Color textColor;
  final Color backgroundColor;
  FormItemAvatarImage(
      {@required this.image,
      this.label,
      this.onPressed,
      this.textColor,
      this.backgroundColor});
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
            if (isNotEmpty(this.label))
              FlatButton(
                  shape: StadiumBorder(),
                  child: Text(this.label,
                      style: TextStyle(
                          color:
                              this.textColor ?? context.theme.backgroundColor)),
                  onPressed: this.onPressed,
                  color: this.backgroundColor ?? context.theme.primaryColor)
          ],
        ));
  }
}
