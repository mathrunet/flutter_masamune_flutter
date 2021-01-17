part of masamune.list;

/// Button to load next.
///
/// Please use it in the list.
class LoadNext extends StatelessWidget {
  /// The collection path to read.
  final String path;

  /// Button label.
  final String label;

  /// Button to load next.
  ///
  /// Please use it in the list.
  LoadNext({this.path, this.label});

  /// Build method.
  ///
  /// [BuildContext]: Build Context.
  @override
  Widget build(BuildContext context) {
    if (!(PathMap.get<IDataCollection>(this.path)?.canNext() ?? false))
      return Container();
    return Center(
        child: FlatButton.icon(
            onPressed: () {
              PathMap.get<IDataCollection>(this.path)?.next();
            },
            icon: const Icon(Icons.refresh),
            label: Text(this.label)));
  }
}
