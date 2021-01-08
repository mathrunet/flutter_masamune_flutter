// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:masamune_flutter/masamune_flutter.dart';

// /// Widget for counter with plus button and minus button.
// class UICounter extends UIWidget with UIPageTextEditingMixin, UIPageFocusMixin {
//   /// The width of the form.
//   final double width;

//   /// Maximum number of digits in a text field.
//   final int maxLength;

//   /// Initial value.
//   final double defaultValue;

//   /// Callback for any changes.
//   final void Function(double value) onChange;

//   /// Widget padding.
//   final EdgeInsetsGeometry padding;

//   /// Widget for counter with plus button and minus button.
//   ///
//   /// [width]: The width of the form.
//   /// [maxLength]: Maximum number of digits in a text field.
//   /// [defaultValue]: Initial value.
//   /// [onChange]: Callback for any changes.
//   /// [padding]: Widget padding.
//   UICounter(
//       {this.onChange,
//       this.maxLength,
//       this.defaultValue = 0,
//       this.width = 100,
//       this.padding = const EdgeInsets.symmetric(vertical: 5)}) {
//     this.textEditingController =
//         TextEditingController(text: this.defaultValue.toString());
//   }

//   /// Determines whether to build.
//   ///
//   /// True to build.
//   ///
//   /// Override and use.
//   ///
//   /// [context]: Build context.
//   @override
//   bool rebuildable(BuildContext context) {
//     return !this.hasFocus(context);
//   }

//   /// Callback for building.
//   ///
//   /// Override and use.
//   ///
//   /// [context]: Build context.
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: this.width,
//         margin: this.padding,
//         child: Row(
//           children: [
//             Expanded(
//                 flex: 1,
//                 child: IconButton(
//                     padding: const EdgeInsets.all(0),
//                     onPressed: () {
//                       if (isEmpty(this.textEditingController.text)) return;
//                       double d =
//                           double.tryParse(this.textEditingController.text);
//                       if (d == null) return;
//                       d = d - 1;
//                       this.textEditingController.text = d.toString();
//                       if (this.onChange != null) this.onChange(d);
//                     },
//                     icon: Icon(Icons.remove))),
//             Expanded(
//                 flex: 2,
//                 child: TextField(
//                   onTap: () {
//                     this.select();
//                   },
//                   maxLength: this.maxLength,
//                   textAlign: TextAlign.center,
//                   focusNode: this.focusNode(context),
//                   keyboardType: TextInputType.number,
//                   controller: this.textEditingController,
//                   onChanged: (value) {
//                     if (isEmpty(this.textEditingController.text)) return;
//                     double d = double.tryParse(this.textEditingController.text);
//                     if (d == null) return;
//                     if (this.onChange != null) this.onChange(d);
//                   },
//                   onEditingComplete: () {
//                     if (isNotEmpty(this.textEditingController.text)) return;
//                     this.textEditingController.text =
//                         this.defaultValue.toString();
//                   },
//                   onSubmitted: (value) {
//                     if (isNotEmpty(this.textEditingController.text)) return;
//                     this.textEditingController.text =
//                         this.defaultValue.toString();
//                   },
//                   decoration: InputDecoration(
//                       counterText: "",
//                       hintText: this.defaultValue.toString(),
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 5),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                           borderSide: BorderSide(
//                               color: context.theme.dividerColor, width: 2))),
//                   style: context.theme.textTheme.bodyText1
//                       .copyWith(height: 1.25, fontSize: 20),
//                 )),
//             Expanded(
//                 flex: 1,
//                 child: IconButton(
//                     padding: const EdgeInsets.all(0),
//                     onPressed: () {
//                       if (isEmpty(this.textEditingController.text)) return;
//                       double d =
//                           double.tryParse(this.textEditingController.text);
//                       if (d == null) return;
//                       d = d + 1;
//                       this.textEditingController.text = d.toString();
//                       if (this.onChange != null) this.onChange(d);
//                     },
//                     icon: Icon(Icons.add)))
//           ],
//         ));
//   }
// }
