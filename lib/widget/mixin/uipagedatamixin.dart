import 'package:masamune_flutter/masamune_flutter.dart';

/// A mix-in class for handling the data passed to the page by [pushPath] etc.
abstract class UIPageDataMixin {
  /// The UID passed to this page.
  String get uid => PathMap.get<String>("page/data/uid");

  /// The name passed to this page.
  String get name => PathMap.get<String>("page/data/name");

  /// The text passed to this page.
  String get text => PathMap.get<String>("page/data/text");

  /// Gets the redirect path passed to the page.
  String get redirectTo => this.data?.getString("redirect_to", "/");

  /// The data passed to this page.
  IDataDocument get data => PathMap.get<IDataDocument>("page/data");
}
