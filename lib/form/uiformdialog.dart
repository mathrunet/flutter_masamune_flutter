part of masamune.form;

/// Show dialog for form.
///
/// ```
/// UIFormDialog.show( context );
/// ```
class UIFormDialog {
  /// Show dialog.
  ///
  /// [context]: Build context.
  /// [submitText]: Default submit button text.
  /// [submitHeight]: Height of submit button.
  /// [onSubmit]: Default submit button action.
  /// [submitBorderRadius]: Border radius of the Submit button.
  /// [submitBackgroundColor]: Background color of the Submit button.
  /// [title]: Default title.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  static Future show(BuildContext context,
      {String submitText = "OK",
      List<Widget> Function(BuildContext context, IDataDocument form) builder,
      BorderRadiusGeometry submitBorderRadius,
      Color submitBackgroundColor,
      double submitHeight = 80,
      String title,
      bool popOnPress = true,
      void onSubmit(IDataDocument form)}) async {
    if (context == null) return;
    if (title == null || builder == null) return;
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final OverlayState overlay = context.navigator.overlay;
    final IDataDocument form = TemporaryDocument();
    await showDialog(
      context: overlay.context,
      builder: (context) {
        return WillPopScope(
          onWillPop: null,
          child: Form(
            key: key,
            child: SimpleDialog(
              title: Text(title),
              titlePadding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              children: [
                ...builder(context, form),
                Space.height(10),
                FormItemSubmit(
                  label: submitText,
                  height: submitHeight,
                  backgroundColor: submitBackgroundColor,
                  borderRadius: submitBorderRadius,
                  onPressed: () {
                    context.unfocus();
                    if (!key.currentState.validate()) return;
                    key.currentState.save();
                    onSubmit?.call(form);
                    if (popOnPress)
                      Navigator.of(context, rootNavigator: true).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
