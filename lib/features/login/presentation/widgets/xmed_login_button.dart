import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';

class XmedLoginButton extends StatelessWidget {
  const XmedLoginButton({
    super.key,
    required this.loginCubit,
  });

  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          // TRIGGER EVENTO LOGIN
          loginCubit.logInRequest(email: "yo", password: "yoyo");
        },
        style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
                EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20))),
        child: Text(
          "ACCEDI",
          style: GoogleFonts.chewy(textStyle: const TextStyle(fontSize: 30)),
        ));
  }
}
