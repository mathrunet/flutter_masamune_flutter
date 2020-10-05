part of masamune.list;

class Space extends SizedBox {
  Space({double width = 8, double height = 8})
      : super(width: width, height: height);
  Space.width([double value = 8]) : super(width: value);
  Space.height([double value = 8]) : super(height: value);
}
