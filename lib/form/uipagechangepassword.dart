part of masamune.form;

class UIPageChangePassword extends UIHookPageForm {
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
      FormItemTextField(
        controller: textEditingController(),
        hintText: "Please enter a password".localize(),
        labelText: "Password".localize(),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        onSaved: (value) {
          if (isEmpty(value)) return;
          form["password"] = value;
        },
      ),
      FormItemTextField(
        controller: textEditingController(),
        hintText: "Please enter a password".localize(),
        labelText: "ConfirmationPassword".localize(),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        onSaved: (value) {
          if (isEmpty(value)) return;
          form["confirmation"] = value;
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
    if (form["password"] != form["confirmation"]) {
      UIDialog.show(context,
          title: "Error".localize(),
          text: "Passwords do not match.".localize(),
          submitText: "OK".localize(),
          onSubmit: () {});
      return;
    }
    UIDialog.show(context,
        title: "Success".localize(),
        text: "Editing is complete.".localize(),
        submitText: "OK".localize(), onSubmit: () {
      context.navigator.pop();
    });
  }
}
