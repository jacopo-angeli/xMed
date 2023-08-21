import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmed/features/whitelabeling/presentation/cubits/theme/theme_cubit.dart';

import '../blocs/login/login_bloc.dart';
import '../widgets/xmed_text_form_field.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginView> {
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
          MultiBlocListener(
            listeners: [
              BlocListener<LoginBloc, LoginState>(listener: (context, state) {
                // Se è in stato di WrongInputState modifico gli input fields con gli errori dedicati
                // WrongInputState contiene un campo apposito per l'email e per la password, viene printato il messaggio
                // contenuto nei due campi solo se è presente
                if (state is WrongInputState) {
                  setState(() {
                    emailFormField = XmedTextFormField(
                      label: "Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      errorMessage: state.emailError,
                      prefill: state.email == null ? '' : state.email as String,
                    );
                    passwordFormField = XmedTextFormField(
                        label: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        obscureText: true,
                        errorMessage: state.passwordError,
                        prefill: state.password == null
                            ? ''
                            : state.password as String);
                  });
                }
              }),
              BlocListener<ThemeCubit, ThemeState>(listener: (context, state) {
                print(state.runtimeType.toString());
              }),
            ],
            child: Form(
              key: formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: FractionallySizedBox(
                  widthFactor: 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const FlutterLogo(),
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
                                  // context.read<LoginBloc>().add(
                                  //     LoginAttemptEvent(
                                  //         credentials: Credentials(
                                  //             email:
                                  //                 emailFormField.getContent(),
                                  //             password: passwordFormField
                                  //                 .getContent())));
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
