import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.icon,
    this.inputDecoration,
    required this.hintText,
    this.labelText,
    required this.requiredText,
    this.isDense,
    this.inputBorder,
  }) : super(key: key);

  final TextEditingController controller;
  final Widget? icon;
  final InputDecoration? inputDecoration;
  final String hintText;
  final String? labelText;
  final String requiredText;
  final bool? isDense;
  final InputBorder? inputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: inputBorder,
        isDense: isDense,
        icon: icon,
        hintText: hintText,
        labelText: labelText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return requiredText;
        }
        return null;
      },
    );
  }
}
