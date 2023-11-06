import 'package:flutter/material.dart';

class XmedDisabledCredentialButton extends StatelessWidget {
  const XmedDisabledCredentialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          // TODO Cosa fare se le credenziali sono disattivate?
        },
        child: const Text("Richiedi Abilitazione delle credenziali.",
            style: TextStyle(fontSize: 12)));
  }
}
