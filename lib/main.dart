import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xmed/features/login/data/repositories/user_repository_impl.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';
import 'package:xmed/core/utils/constants/strings.dart';
import 'package:xmed/features/whitelabeling/domain/entities/theme.dart';

import 'config/routers/app_router.dart';
import 'config/themes/app_themes.dart';
import 'features/connection/presentation/cubits/internet/internet_cubit.dart';
import 'features/whitelabeling/data/repositories/theme_repository_impl.dart';
import 'features/whitelabeling/presentation/cubits/theme/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark));

  // REPOSITORIES
  final userRepository = UserRepositoryImpl();
  // final licenseRepository = LicenseRepositoryImpl();
  final themeRepository = ThemeRepositoryImpl();

  // BLOCS
  final InternetCubit internetCubit =
      InternetCubit(connectivity: Connectivity());
  final LoginCubit loginCubit =
      LoginCubit(internetCubit: internetCubit, userRepository: userRepository);
  final XmedTheme xmedDefaultTheme = await XmedTheme.getDefaultTheme();
  final ThemeCubit themeCubit = ThemeCubit(
      defaultTheme: xmedDefaultTheme,
      themeRepository: themeRepository,
      loginCubit: loginCubit);

  // TRIGGER APPSTARTED EVENT (VISUALIZZATO TEMA DI DEFAULT)
  await themeCubit.appStartedEvent();
  // ? PROBABILEMENTE FAR TERMINARE IL CARICAMENTO INIZIALE QUI

  runApp(MyApp(
    internetCubit: internetCubit,
    loginCubit: loginCubit,
    themeCubit: themeCubit,
  ));
}

class MyApp extends StatefulWidget {
  final InternetCubit internetCubit;
  final LoginCubit loginCubit;
  final ThemeCubit themeCubit;
  MyApp(
      {super.key,
      required this.internetCubit,
      required this.loginCubit,
      required this.themeCubit});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WIDGET BUILD
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => widget.internetCubit),
        BlocProvider(create: (context) => widget.loginCubit..appStartedEvent()),
        BlocProvider(create: (context) => widget.themeCubit),
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
