import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';

class AccountDrawerHeader extends StatelessWidget {
  final String name;

  final String text;

  final ImageProvider avatar;

  final ImageProvider backgroundImage;

  final Function onTap;

  final Color color;

  AccountDrawerHeader(
      {this.avatar,
      this.onTap,
      this.backgroundImage,
      this.name,
      this.text,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.onTap,
        child: DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    backgroundImage: this.avatar,
                  )),
              SizedBox(height: 10),
              Text(
                this.name,
                style: TextStyle(color: context.theme.backgroundColor),
              ),
              Text(this.text,
                  style: TextStyle(color: context.theme.backgroundColor))
            ],
          ),
          decoration: BoxDecoration(
            image: this.backgroundImage != null
                ? DecorationImage(
                    image: this.backgroundImage,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        (this.color ?? context.theme.accentColor)
                            .withOpacity(0.5),
                        BlendMode.srcOver))
                : null,
            color: this.color ?? context.theme.accentColor,
          ),
        ));
  }
}
