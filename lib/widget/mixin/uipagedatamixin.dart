import 'package:masamune_flutter/masamune_flutter.dart';

/// A mix-in class for handling the data passed to the page by [pushPath] etc.
abstract class UIPageDataMixin implements UIWidget {
  /// The UID passed to this page.
  String get uid => this.data?.uid;

  /// The name passed to this page.
  String get name => this.data?.getString("name");

  /// The text passed to this page.
  String get text => this.data?.getString("text");

  /// Gets the redirect path passed to the page.
  String get redirectTo => this.data?.getString("redirect_to", "/");

  //// True to add a new page.
  bool get additional => this.data?.getBool("additional") ?? false;

  /// The data passed to this page.
  IDataDocument get data => PathMap.get<IDataDocument>(DefaultPath.pageData);
}
