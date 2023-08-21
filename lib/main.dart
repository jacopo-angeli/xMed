import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xmed/utils/constants/STRINGS.dart';

import 'config/routers/app_router.dart';
import 'config/themes/app_themes.dart';
import 'features/connection/presentation/cubits/internet/internet_cubit.dart';
import 'features/login/presentation/blocs/login/login_bloc.dart';
import 'features/whitelabeling/presentation/blocs/clinic/clinic_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*--------------------- Global BLoC -------------------- */
    final InternetCubit internetCubit =
        InternetCubit(connectivity: Connectivity());
    final ClinicBloc clinicBloc = ClinicBloc();
    final LoginBloc loginBloc = LoginBloc()..add(AppStartedEvent());

    return OKToast(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        title: appTitle,
        theme: AppTheme.light,
        builder: (context, child) => MultiBlocProvider(providers: [
          // Connectivity Cubit
          BlocProvider(create: (context) => internetCubit),
          // Login Bloc
          BlocProvider(create: (context) => loginBloc),
          // Clinic Bloc
          BlocProvider(create: (context) => clinicBloc)
        ], child: child as Widget),
      ),
    );
  }
}
