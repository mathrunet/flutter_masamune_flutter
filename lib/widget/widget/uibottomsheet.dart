import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

/// Create a dynamically resizable bottom sheet.
class UIBottomSheet extends UIWidget {
  /// Specifies the color of the header bar.
  /// Default is bottom app bar color.
  final Color headerBarColor;
  // This controls the minimum height of the body. Must be greater or equal of
  // 0. By default is 0
  final double minHeight;
  // This controls the minimum height of the body. By default is 500
  final double maxHeight;
  // This is the content that will be hided of your bottomSheet. You can fit any
  // widget. This parameter is required
  final Widget body;
  // This is the header of your bottomSheet. This widget is the swipeable area
  // where user will interact. This parameter is required
  final Widget headerBar;
  // This flag is used to enable the automatic swipe of the bar. If it's true
  // the bottomSheet will automatically appear or disappear when user stops
  // swiping, but if it's false, it will stay at the last user finger position.
  // By default is true
  final bool autoSwiped;
  // This flag enable that the user can toggle the visibility with just tapping
  // on the header bar. By default is false
  final bool toggleVisibilityOnTap;
  // This flag enable that users can swipe the body and hide or show the
  // solid bottom sheet. Turn on false if you don't want to let the user
  // interact with the solid bottom sheet. By default is false.
  final bool draggableBody;
  // This flag enable that users can swipe the header and hide or show the
  // solid bottom sheet. Turn on false if you don't want to let the user
  // interact with the solid bottom sheet. By default is true.
  final bool canUserSwipe;
  // This property defines how 'smooth' or fast will be the animation. Low is
  // the slowest velocity and high is the fastest. By default is medium.
  final Smoothness smoothness;
  // This property is the elevation of the bottomSheet. Must be greater or equal
  // to 0. By default is 0.
  final double elevation;
  // This flag controls if the body is shown to the user by default. If it's
  // true, the body will be shown. If it's false the body will be hided. By
  // default it's false.
  final bool showOnAppear;
  // This object used to control behavior internally
  // from the app and don't depend of user's interaction.
  // can hide and show  methods plus have isOpened variable
  // to check widget visibility on a screen
  final SolidController controller = SolidController();
  // This method will be executed when the solid bottom sheet is completely
  // opened.
  final Function onShow;
  // This method will be executed when the solid bottom sheet is completely
  // closed.
  final Function onHide;

  /// Create a dynamically resizable bottom sheet.
  UIBottomSheet({
    Key key,
    this.headerBarColor,
    @required this.headerBar,
    @required this.body,
    this.minHeight = 0,
    this.maxHeight = 500,
    this.autoSwiped = true,
    this.toggleVisibilityOnTap = false,
    this.canUserSwipe = true,
    this.draggableBody = false,
    this.smoothness = Smoothness.medium,
    this.elevation = 0.0,
    this.showOnAppear = false,
    this.onShow,
    this.onHide,
  })  : assert(elevation >= 0.0),
        assert(minHeight >= 0.0),
        super(key: key) {
    this.controller.height =
        this.showOnAppear ? this.maxHeight : this.minHeight;
    this.controller.smoothness = smoothness;
  }

  /// Callback for building.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SolidBottomSheet(
      headerBar: BottomAppBar(
          elevation: 0,
          color: this.headerBarColor ?? context.theme.bottomAppBarColor,
          child: GestureDetector(
              onTap: () {
                if (this.controller.isOpened)
                  this.controller.hide();
                else
                  this.controller.show();
              },
              child: this.headerBar)),
      body: this.body,
      controller: this.controller,
      minHeight: this.minHeight,
      maxHeight: this.maxHeight,
      autoSwiped: this.autoSwiped,
      toggleVisibilityOnTap: this.toggleVisibilityOnTap,
      canUserSwipe: this.canUserSwipe,
      draggableBody: this.draggableBody,
      smoothness: this.smoothness,
      elevation: this.elevation,
      showOnAppear: this.showOnAppear,
      onShow: this.onShow,
      onHide: this.onHide,
    ));
  }
}
