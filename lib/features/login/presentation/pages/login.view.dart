import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xmed/config/routers/app_router.dart';
import 'package:xmed/config/routers/app_router.gr.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';
import 'package:xmed/features/login/presentation/widgets/xmed_disbled_credential_button.dart';

import '../../../../utils/constants/strings.dart';
import '../../../whitelabeling/presentation/widgets/xmed_logo.dart';
import '../widgets/xmed_text_form_field.dart';

// Prima pagina dell' applicazione
// Tento autologin (.appStartedEvent)

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
    // BLOC LISTENER MANAGING LOGIN EVENT
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          print("okay");
          final loginCubitState = context.read<LoginCubit>().state;
          if (loginCubitState is LoggedState) {
            // WHEN LOGGED NAVIGATE TO DOCUMENTS VIEW PAGE
            appRouter.replace(const DocumentsListRoute());
          } else if (loginCubitState is LoginErrorState) {
            showToast(backofficeConnectionError);
          }
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MultiBlocListener(
                  listeners: [
                    BlocListener<LoginCubit, LoginState>(
                        listener: (context, state) {
                      // SE È IN STATO DI WRONGINPUTSTATE MODIFICO GLI INPUT FIELDS CON GLI ERRORI DEDICATI
                      // WRONGINPUTSTATE CONTIENE UN CAMPO APPOSITO PER L'EMAIL E PER LA PASSWORD,
                      // VIENE PRINTATO IL MESSAGGIO CONTENUTO NEI DUE CAMPI SOLO SE È PRESENTE
                      if (state is WrongInputState) {
                        setState(() {
                          emailFormField = XmedTextFormField(
                            label: "Email",
                            prefixIcon: const Icon(Icons.email_outlined),
                            errorMessage: state.emailError,
                            prefill: state.email == null
                                ? ''
                                : state.email as String,
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
                      } else if (state is LoginErrorState) {
                        setState(() {
                          emailFormField = XmedTextFormField(
                            label: "Email",
                            prefixIcon: const Icon(Icons.email_outlined),
                            prefill: state.email.isEmpty ? '' : state.email,
                          );
                          passwordFormField = XmedTextFormField(
                              label: "Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              obscureText: true,
                              prefill:
                                  state.password.isEmpty ? '' : state.password);
                        });
                      } else {
                        setState(() {
                          emailFormField = XmedTextFormField(
                            label: "Email",
                            prefixIcon: const Icon(Icons.email_outlined),
                          );
                          passwordFormField = XmedTextFormField(
                              label: "Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              obscureText: true);
                        });
                      }
                    }),
                  ],
                  // MAIN CONTENT DELLA PAGINA
                  child: Form(
                    key: formKey,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // WHITE LABEL LOGO DINAMICO SULLA BASE DELLO STATO DEL THEME CUBIT
                            const WhiteLabelLogo(),
                            const SizedBox(height: 10),

                            // EMAIL CUSTOM INPUT FIELD
                            emailFormField,
                            const SizedBox(height: 10),

                            // PASSWORD CUSTOM INPUT FIELD
                            passwordFormField,
                            const SizedBox(height: 10),

                            // GESTIONE LOGINCUBIT STATE
                            Builder(builder: (context) {
                              return BlocBuilder<LoginCubit, LoginState>(
                                  builder: (context, state) {
                                // RECUPERO ISTANZA DEL CUBIT
                                final loginCubit = context.read<LoginCubit>();

                                // GESTIONE STATO DEL CUBIT
                                switch (state.runtimeType) {
                                  // LOGGING STATE
                                  case LoggingState:
                                    return const CircularProgressIndicator();

                                  // DISABLED CREDENTIAL STATE
                                  case DisabledCredentialState:
                                    return const XmedDisabledCredentialButton();

                                  // NOTLOGGEDSTATE
                                  // WRONGINPUTSTATE
                                  default:
                                    return ElevatedButton(
                                        onPressed: () {
                                          // TRIGGER EVENTO LOGIN
                                          loginCubit.logInRequest(
                                              email:
                                                  emailFormField.getContent(),
                                              password: passwordFormField
                                                  .getContent());
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
                                              textStyle: const TextStyle(
                                                  fontSize: 30)),
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
          ),
        ));
  }
}
