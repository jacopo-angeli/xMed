import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:xmed/data/model/login.dart';
import 'package:xmed/logic/bloc/login/login_bloc.dart';
import 'package:xmed/presentation/widgets/xmed_form_error_message.dart';
import 'package:xmed/presentation/widgets/xmed_logo.dart';
import 'package:xmed/presentation/widgets/xmed_text_form_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });

  final formKey = GlobalKey<FormState>();

  final XmedTextFormField emailFormField = XmedTextFormField(
    label: "Email",
    prefixIcon: const Icon(Icons.email_outlined),
  );

  final XmedTextFormField passwordFormField = XmedTextFormField(
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
          Form(
            key: formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Logo(),
                  const SizedBox(
                    height: 40,
                  ),
                  emailFormField,
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is WrongInputState &&
                          state.emailError.isNotEmpty) {
                        return ErrorMessage(errorMessage: state.emailError);
                      } else {
                        return const SizedBox(
                          height: 10,
                        );
                      }
                    },
                  ),
                  passwordFormField,
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is WrongInputState &&
                          state.passwordError.isNotEmpty) {
                        return ErrorMessage(errorMessage: state.passwordError);
                      } else {
                        return const SizedBox(
                          height: 10,
                        );
                      }
                    },
                  ),
                  Builder(builder: (context) {
                    return BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoggingState) {
                          return const CircularProgressIndicator();
                        } else if (state is NotLoggedState) {
                          return ElevatedButton(
                              onPressed: () {
                                // triggerare evento login
                                context.read<LoginBloc>().add(
                                    LoginRequestedEvent(
                                        loginData: LoginData(
                                            email: emailFormField.getContent(),
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
                        } else {
                          return TextButton(
                              onPressed: () {
                                // TBD
                              },
                              child: const Text(
                                  "Richiedi Abilitazione delle credenziali.",
                                  style: TextStyle(fontSize: 12))
                              //invio email al supporto tecnico   ,
                              );
                        }
                      },
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
