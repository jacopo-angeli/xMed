import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:xmed/models/login.dart';
import 'package:xmed/logic/bloc/login/login_bloc.dart';
import 'package:xmed/presentation/widgets/xmed_logo.dart';
import 'package:xmed/presentation/widgets/xmed_text_form_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  XmedTextFormField emailFormField = XmedTextFormField(
    label: "Email",
    prefixIcon: const Icon(Icons.email_outlined),
  );

  XmedTextFormField passwordFormField = XmedTextFormField(
    label: "Password",
    prefixIcon: const Icon(Icons.lock_outline),
    obscureText: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is WrongInputState) {
                setState(() {
                  emailFormField = XmedTextFormField(
                    label: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    errorMessage: state.emailError,
                    prefill: state.loginData.email,
                  );
                  passwordFormField = XmedTextFormField(
                      label: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: true,
                      errorMessage: state.passwordError,
                      prefill: state.loginData.password);
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("${state.emailError}, ${state.passwordError}")));
              }
            },
            child: Form(
              key: formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: FractionallySizedBox(
                  widthFactor: 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Logo(),
                      const SizedBox(height: 10),
                      emailFormField,
                      const SizedBox(height: 10),
                      passwordFormField,
                      const SizedBox(height: 10),
                      Builder(builder: (context) {
                        return BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                          if (state is LoggingState) {
                            return const CircularProgressIndicator();
                          } else if (state is DisabledCredentialState) {
                            return TextButton(
                                onPressed: () {
                                  // TBD
                                },
                                child: const Text(
                                    "Richiedi Abilitazione delle credenziali.",
                                    style: TextStyle(fontSize: 12))
                                //invio email al supporto tecnico   ,
                                );
                          } else {
                            return ElevatedButton(
                                onPressed: () {
                                  // triggerare evento login
                                  context.read<LoginBloc>().add(
                                      LoginRequestedEvent(
                                          loginData: LoginData(
                                              email:
                                                  emailFormField.getContent(),
                                              password: passwordFormField
                                                  .getContent())));
                                },
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.only(
                                            left: 30,
                                            right: 30,
                                            top: 20,
                                            bottom: 20))),
                                child: Text(
                                  "ACCEDI",
                                  style: GoogleFonts.chewy(
                                      textStyle: const TextStyle(fontSize: 30)),
                                ));
                          }
                        });
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
