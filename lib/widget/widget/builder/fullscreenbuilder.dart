import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Builder to create widgets that allow you to switch to full screen.
class FullScreenBuilder extends StatefulWidget {
  /// The aspect ratio of the elements that make it full screen.
  final double aspectRatio;

  /// Background color of the full-screen element.
  final Color backgroundColor;

  /// Full Screen Element Background.
  final Widget background;

  /// Foreground of full screen elements.
  final Widget Function(
      BuildContext context, bool fullscreen, Function onToggle) foreground;

  /// Elements to be displayed when not in full screen.
  final Widget bottom;

  /// The orientation of the device under normal conditions.
  final List<DeviceOrientation> defaultOrientations;

  /// The orientation of the device while in full screen.
  final List<DeviceOrientation> fullscreenOrientations;

  /// Builder to create widgets that allow you to switch to full screen.
  ///
  /// [aspectRatio]: The aspect ratio of the elements that make it full screen.
  /// [backgroundColor]: Background color of the full-screen element.
  /// [background]: Full Screen Element Background.
  /// [foreground]: Foreground of full screen elements.
  /// [bottom]: Elements to be displayed when not in full screen.
  /// [defaultOrientations]: The orientation of the device under normal conditions.
  /// [fullscreenOrientations]: The orientation of the device while in full screen.
  FullScreenBuilder(
      {this.aspectRatio = 1,
      this.backgroundColor,
      @required this.foreground,
      this.defaultOrientations = const [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp
      ],
      this.fullscreenOrientations = const [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      this.bottom,
      this.background})
      : assert(foreground != null);
  @override
  State<StatefulWidget> createState() => _FullStreenBuilderState();
}

class _FullStreenBuilderState extends State<FullScreenBuilder> {
  bool _fullscreen = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, oriantation) {
        bool fullscreen = oriantation == Orientation.landscape;
        return Column(children: [
          Container(
              width: constraints.maxWidth,
              height: !fullscreen
                  ? constraints.maxWidth / this.widget.aspectRatio
                  : constraints.maxHeight,
              color: this.widget.backgroundColor,
              child: Stack(fit: StackFit.expand, children: [
                if (this.widget.background != null)
                  FittedBox(fit: BoxFit.cover, child: this.widget.background),
                this.widget.foreground(context, fullscreen, this._onToggle),
              ])),
          if (this.widget.bottom != null) Expanded(child: this.widget.bottom)
        ]);
      });
    });
  }

  void _onToggle() {
    this.setState(() {
      if (this._fullscreen) {
        this._fullscreen = false;
        SystemChrome.setPreferredOrientations(this.widget.defaultOrientations);
      } else {
        this._fullscreen = true;
        SystemChrome.setPreferredOrientations(
            this.widget.fullscreenOrientations);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (!this._fullscreen) return;
    SystemChrome.setPreferredOrientations(this.widget.defaultOrientations);
  }
}
