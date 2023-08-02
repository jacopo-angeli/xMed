import 'package:flutter/material.dart';

class XmedTextFormField extends StatelessWidget {
  XmedTextFormField(
      {super.key,
      required this.label,
      required this.prefixIcon,
      this.obscureText = false});

  final TextEditingController textEditingController = TextEditingController();
  final String label;
  final Icon prefixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: textEditingController,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  String getContent() {
    return textEditingController.text;
  }
}
