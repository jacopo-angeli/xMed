import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;

  const ErrorMessage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.red, fontSize: 12),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
