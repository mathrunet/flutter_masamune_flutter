part of masamune.list;

/// List tiles for comment.
class UICommentTile extends StatelessWidget {
  /// Picture.
  final ImageProvider image;

  /// Avatar image.
  final ImageProvider avatar;

  /// Name.
  final String name;

  /// Posting Date.
  final DateTime date;

  /// Comments.
  final String text;

  /// List tiles for comment.
  UICommentTile(
      {this.image, this.avatar, this.name, this.date, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.avatar != null) ...[
            SizedBox(
              height: 40,
              width: 40,
              child: CircleAvatar(
                backgroundImage: this.avatar,
              ),
            ),
            Space.width(20),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isNotEmpty(this.name) || this.date != null)
                  Text(
                    (isNotEmpty(this.name) ? "${this.name} " : "") +
                        (this.date != null
                            ? DateFormat.yMd().add_Hms().format(this.date)
                            : ""),
                    style: context.theme.textTheme.caption,
                  ),
                Space(),
                Text(
                  this.text,
                ),
                if (this.image != null) ...[
                  Space(),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    constraints: const BoxConstraints.expand(height: 200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(image: this.image),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
