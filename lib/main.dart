import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xmed/features/login/data/repositories/user_repository_impl.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';
import 'package:xmed/utils/constants/strings.dart';

import 'config/routers/app_router.dart';
import 'config/themes/app_themes.dart';
import 'features/connection/presentation/cubits/internet/internet_cubit.dart';
import 'features/license/data/repositories/license_repository_impl.dart';
import 'features/license/domain/repositories/license_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // REPOSITORIES DECLARATION
  late final UserRepositoryImpl userRepository;
  late final LicenseRepository licenseRepository;

  // BLOCS DECLARATION
  late final LoginCubit loginCubit;
  late final InternetCubit internetCubit;

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // REPOSITORY INSTANTIALIZATION
    widget.userRepository = UserRepositoryImpl();
    widget.licenseRepository = LicenseRepositoryImpl();

    // BLOC INITIALIZATION AND DEPENDENCY INJECTION
    widget.internetCubit = InternetCubit(connectivity: Connectivity());
    widget.loginCubit = LoginCubit(
        internetCubit: widget.internetCubit,
        userRepository: widget.userRepository);

    // TRIGGER APPSTARTED EVENT (VISUALIZZATO TEMA DI DEFAULT)
    // ? PROBABILEMENTE FAR TERMINARE IL CARICAMENTO INIZIALE QUI
    widget.loginCubit.appStartedEvent();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WIDGET BUILD
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => widget.internetCubit),
        BlocProvider(create: (context) => widget.loginCubit)
      ],
      child: OKToast(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
          title: appTitle,
          theme: AppTheme.light,
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.internetCubit.close();
    widget.loginCubit.close();
    super.dispose();
  }
}
