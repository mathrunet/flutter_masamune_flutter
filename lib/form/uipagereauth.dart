part of masamune.form;

class UIPageReAuth extends UIHookPageForm {
  /// Page title.
  @protected
  String get title => "Reauthentication".localize();

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
  @override
  List<Widget> formBody(BuildContext context, IDataDocument form) {
    return [
      Text(
        "Please enter your login information again".localize(),
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
      )
    ];
  }

  /// What happens when a form is submitted.
  ///
  /// [context]: Build context.
  /// [form]: Form data.
  @override
  void onSubmit(BuildContext context, IDataDocument form) async {
    if (!this.validate(context)) return;
    context.navigator.pushReplacementNamed(this.data.getString("redirect_to"));
  }
}
