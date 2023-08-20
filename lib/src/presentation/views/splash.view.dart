import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routers/app_router.gr.dart';
import '../blocs/login/login_bloc.dart';
import '../widgets/xmed_logo.dart';

/// Una schermata di avvio dell'applicazione.
@RoutePage() // Annotazione per configurare AutoRoute
class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key); // Costruttore della classe

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // Ascolta lo stato del bloc LoginBloc
        if (state is NotLoggedState) {
          // Se lo stato è NotLoggedState (utente non autenticato)
          AutoRouter.of(context).replace(
              LoginView()); // Naviga alla vista LoginView utilizzando AutoRouter
        }
      },
      child: const Scaffold(
        body: XmedLogo(), // Mostra il widget XmedLogo al centro della schermata
      ),
    );
  }
}
