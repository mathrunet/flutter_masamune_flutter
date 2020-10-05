part of masamune.list;

/// Create a small gallery in the list.
class SmallGallery extends StatelessWidget {
  /// Gallery element.
  final List<Widget> children;

  /// The number next to the gallery.
  final int crossAxisCount;

  /// Create a small gallery in the list.
  ///
  /// [children]: Gallery element.
  /// [crossAxisCount]: The number next to the gallery.
  SmallGallery({@required this.children, this.crossAxisCount = 4});

  @override
  Widget build(BuildContext context) {
    print(this.children);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        constraints: constraints,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: this.children == null || this.children.length <= 0
            ? Container(
                alignment: Alignment.center,
                height: 100,
                child: Text("No data.".localize()))
            : GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: this.crossAxisCount,
                children: this.children,
              ),
      );
    });
  }
}
