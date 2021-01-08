// part of masamune.form;

// /// Template for creating form pages.
// abstract class UIHookPageForm extends UIHookPageScaffold with UIPageFormMixin {
//   /// Creating a floating action button.
//   ///
//   /// [context]: Build context.
//   @override
//   Widget floatingActionButton(BuildContext context) {
//     return FloatingActionButton(
//         onPressed: () => this.onSubmit(context, this.form),
//         child: Icon(this.floatingActionButtonIcon));
//   }

//   /// What happens when a form is submitted.
//   ///
//   /// [context]: Build context.
//   /// [form]: Form data.
//   void onSubmit(BuildContext context, IDataDocument form);

//   /// FAB icon definition.
//   IconData get floatingActionButtonIcon => Icons.check;

//   /// Form body definition.
//   ///
//   /// [context]: Build context.
//   /// [form]: Form data.
//   List<Widget> formBody(BuildContext context, IDataDocument form);

//   /// Set the form type.
//   ///
//   /// Available for login and password reset page.
//   FormBuilderType get formType => FormBuilderType.listView;

//   /// Specify the padding of the form.
//   EdgeInsetsGeometry get formPadding => null;

//   /// Creating a body.
//   ///
//   /// [context]: Build context.
//   @override
//   Widget body(BuildContext context) {
//     return FormBuilder(
//       type: this.formType,
//       key: this.formKey,
//       padding: this.formPadding,
//       children: this.formBody(context, this.form),
//     );
//   }
// }
