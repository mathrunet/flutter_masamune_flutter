part of masamune.list;

/// List tile for ranking.
class RankingListTile extends StatelessWidget {
  /// Rank.
  final int rank;

  /// The color when the rank is 1st.
  final Color primaryColor;

  /// The color when the rank is 2 or 3.
  final Color secondaryColor;

  /// Color when the rank is 4th or lower.
  final Color color;

  /// The tile image.
  final ImageProvider image;

  /// Title of the tile.
  final String title;

  /// Trailing tiles.
  final Widget trailing;

  /// Call back on tap.
  final Function onTap;

  /// List tile for ranking.
  ///
  /// [rank]: Rank.
  /// [primaryColor]: The color when the rank is 1st.
  /// [secondaryColor]: The color when the rank is 2 or 3.
  /// [color]: Color when the rank is 4th or lower.
  /// [image]: The tile image.
  /// [title]: Title of the tile.
  /// [trailing]: Trailing tiles.
  /// [onTap]: Call back on tap.
  RankingListTile(
      {@required this.rank,
      this.primaryColor,
      this.secondaryColor,
      this.color,
      this.image,
      this.title,
      this.onTap,
      this.trailing});

  /// Build method.
  ///
  /// [BuildContext]: Build Context.
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.onTap,
        child: Container(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: 60,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 1, color: context.theme.dividerColor))),
                child: Text(this.rank.toString(),
                    style: TextStyle(
                        color: this._getColor(context),
                        fontWeight: this._getWeight(context),
                        fontSize: 32),
                    textAlign: TextAlign.center),
              ),
              Space.width(20),
              if (this.image != null) ...[
                Container(
                  width: 36,
                  height: 36,
                  child: CircleAvatar(
                      backgroundColor: context.theme.disabledColor,
                      backgroundImage: this.image),
                ),
                Space.width(20),
              ],
              Expanded(child: Text(this.title, style: TextStyle(fontSize: 18))),
              if (this.trailing != null) ...[
                Space.width(5),
                Container(child: this.trailing),
                Space.width(10),
              ]
            ],
          ),
        ));
  }

  Color _getColor(BuildContext context) {
    if (this.rank <= 1) {
      return this.primaryColor ?? context.theme.primaryColor;
    } else if (this.rank <= 3) {
      return this.secondaryColor ?? context.theme.accentColor;
    } else {
      return this.color ?? context.theme.disabledColor;
    }
  }

  FontWeight _getWeight(BuildContext context) {
    if (this.rank <= 1) {
      return FontWeight.w800;
    } else if (this.rank <= 3) {
      return FontWeight.w600;
    } else {
      return FontWeight.w400;
    }
  }
}
