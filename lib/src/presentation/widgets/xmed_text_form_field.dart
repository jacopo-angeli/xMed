import 'package:flutter/material.dart';

class XmedTextFormField extends StatelessWidget {
  XmedTextFormField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.prefill = "",
    this.errorMessage = '',
    this.obscureText = false,
  });

  final TextEditingController textEditingController = TextEditingController();
  final String label;
  final Icon prefixIcon;
  final bool obscureText;
  final String errorMessage;
  final String prefill;

  @override
  Widget build(BuildContext context) {
    if (prefill.isNotEmpty) textEditingController.text = prefill;
    return TextFormField(
      obscureText: obscureText,
      controller: textEditingController,
      decoration: InputDecoration(
          errorText: errorMessage.isEmpty ? null : errorMessage,
          prefixIcon: prefixIcon,
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  String getContent() {
    return textEditingController.text;
  }
}
