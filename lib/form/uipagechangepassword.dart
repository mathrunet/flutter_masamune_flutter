part of masamune.form;

class UIPageChangePassword extends UIPageForm {
  /// Page title.
  @protected
  String get title => "Change Password".localize();

  /// Set the form type.
  ///
  /// Available for login and password reset page.
  FormBuilderType get formType => FormBuilderType.center;

  /// Creating a app bar.
  ///
  /// [context]: Build context.
  @protected
  @override
  Widget appBar(BuildContext context) {
    return AppBar(title: Text(this.title));
  }

  /// Form body definition.
  ///
  /// [context]: Build context.
  /// [form]: Form data.
  @override
  List<Widget> formBody(BuildContext context, IDataDocument form) {
    return [
      Text(
        "Please enter the information you want to change".localize(),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      FormItemPassword(
        hintText: "Please enter a password".localize(),
        labelText: "Password".localize(),
        confirm: true,
        notMatchText: "Passwords do not match.".localize(),
        confirmLabelText: "ConfirmationPassword".localize(),
        onSaved: (value) {
          if (isEmpty(value)) return;
          form["password"] = value;
        },
      ),
    ];
  }

  /// What happens when a form is submitted.
  ///
  /// [context]: Build context.
  /// [form]: Form data.
  @override
  void onSubmit(BuildContext context, IDataDocument form) async {
    if (!this.validate(context)) return;
    UIDialog.show(context,
        title: "Success".localize(),
        text: "Editing is complete.".localize(),
        submitText: "OK".localize(), onSubmit: () {
      context.navigator.pop();
    });
  }
}
