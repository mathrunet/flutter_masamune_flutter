part of masamune.form;

class UIPageChangeEmail extends UIHookPageForm {
  /// Page title.
  @protected
  String get title => "Change Email".localize();

  /// Default mail address.
  @protected
  String get email => "";

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
        controller: textEditingController(this.email),
        hintText: "Please enter a email address".localize(),
        labelText: "Email".localize(),
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          if (isEmpty(value)) return;
          form["email"] = value;
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
