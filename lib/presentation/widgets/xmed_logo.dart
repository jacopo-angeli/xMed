import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 100, height: 100, child: FlutterLogo());
  }
}
