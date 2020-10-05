part of masamune.list;

class MultiMediaView extends StatelessWidget {
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Map<String, dynamic>> items;
  final IDataCollection collection;
  final String typeKey;
  final String fileKey;
  final String urlKey;
  final Widget Function(File file, AssetType type) fileBuilder;
  final Widget Function(String url, AssetType type) networkBuilder;

  MultiMediaView(
      {this.direction = Axis.horizontal,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.min,
      this.fileBuilder,
      this.typeKey = "type",
      this.fileKey = "file",
      this.urlKey = "url",
      this.networkBuilder,
      String json,
      List<Map<String, dynamic>> items,
      this.collection})
      : this.items = isNotEmpty(json)
            ? Json.decodeAsList(json)?.mapAndRemoveEmpty<Map<String, dynamic>>(
                (item) => item as Map<String, dynamic>)
            : items;
  @override
  Widget build(BuildContext context) {
    if (this.direction == Axis.horizontal) {
      return Row(
        mainAxisAlignment: this.mainAxisAlignment,
        crossAxisAlignment: this.crossAxisAlignment,
        mainAxisSize: this.mainAxisSize,
        children: this._buildWidget(context),
      );
    } else {
      return Column(
        mainAxisAlignment: this.mainAxisAlignment,
        crossAxisAlignment: this.crossAxisAlignment,
        mainAxisSize: this.mainAxisSize,
        children: this._buildWidget(context),
      );
    }
  }

  List<Widget> _buildWidget(BuildContext context) {
    if (this.collection != null) {
      return this.collection.mapAndRemoveEmpty((item) {
        if (!item.containsKey(this.typeKey)) return null;
        if (item.containsKey(this.fileKey) && this.fileBuilder != null) {
          return _addPadding(this.fileBuilder(
              File(item.getString(this.fileKey)),
              _convertType(item.getString(this.typeKey))));
        } else if (item.containsKey(this.urlKey) &&
            this.networkBuilder != null) {
          return _addPadding(this.networkBuilder(item.getString(this.urlKey),
              _convertType(item.getString(this.typeKey))));
        }
        return null;
      });
    } else if (this.items != null) {
      return this.items.mapAndRemoveEmpty((item) {
        if (!item.containsKey(this.typeKey)) return null;
        if (item.containsKey(this.fileKey) && this.fileBuilder != null) {
          return _addPadding(this.fileBuilder(
              File(item[this.fileKey]), _convertType(item[this.typeKey])));
        } else if (item.containsKey(this.urlKey) &&
            this.networkBuilder != null) {
          return _addPadding(this.networkBuilder(
              item[this.urlKey], _convertType(item[this.typeKey])));
        }
        return null;
      });
    }
    return [];
  }

  Widget _addPadding(Widget widget) {
    if (widget == null) return widget;
    if (this.direction == Axis.horizontal) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10), child: widget);
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10), child: widget);
    }
  }

  AssetType _convertType(String type) {
    for (final val in AssetType.values) {
      if (val.toString() == "AssetType.$type") return val;
    }
    return null;
  }
}
