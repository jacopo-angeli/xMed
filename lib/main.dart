import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xmed/features/login/data/models/authentication/authentication_request_dto.dart';
import 'package:xmed/features/login/data/repositories/user_repository_impl.dart';
import 'package:xmed/features/login/domain/usecases/login.dart';
import 'package:xmed/features/login/domain/usecases/logout.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';
import 'package:xmed/features/whitelabeling/presentation/cubits/theme/theme_cubit.dart';
import 'package:xmed/utils/constants/strings.dart';

import 'config/routers/app_router.dart';
import 'config/themes/app_themes.dart';
import 'features/connection/presentation/cubits/internet/internet_cubit.dart';
import 'features/license/data/repositories/license_repository_impl.dart';
import 'features/license/domain/repositories/license_repository.dart';
import 'utils/services/signature_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final test = AuthenticationRequestDto(
      username: 'mario@clinica01.it', password: '123123123');
  print(test.toJson());
  print(await SignatureService.generateSignature(
      '{"input":{"institute":2272,"password":"123123123","username":"mario@clinica01.it"}}'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // REPOSITORIES DECLARATION
  late final UserRepositoryImpl userRepository;
  late final LicenseRepository licenseRepository;

  // USECASES DECLARATION
  late final LogInUseCase logInUseCase;
  late final LogOutUseCase logOutUseCase;

  // BLOCS DECLARATION
  late final LoginCubit loginCubit;
  late final InternetCubit internetCubit;
  late final ThemeCubit themeCubit;

  // ignore: prefer_const_constructors_in_immutables
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // REPOSITORIES INSTANTIALIZATION
    userRepository = UserRepositoryImpl();
    licenseRepository = LicenseRepositoryImpl();

    // USECASE INITIALIZATION AND DEPENDENCY INJECTION
    logInUseCase = LogInUseCase(userRepository: userRepository);
    logOutUseCase = LogOutUseCase(
        userRepository: userRepository); // ? UserRepository Necessary ?

    // BLOC INITIALIZATION AND DEPENDENCY INJECTION
    internetCubit = InternetCubit(connectivity: Connectivity());
    themeCubit = ThemeCubit();
    loginCubit =
        LoginCubit(loginUseCase: logInUseCase, logOutUseCase: logOutUseCase);

    // TRIGGER APPSTARTED EVENT
    themeCubit.appStartedEvent();
    loginCubit.appStartedEvent();

    // WIDGET BUILD
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => internetCubit),
        BlocProvider(create: (context) => loginCubit),
        BlocProvider(create: (context) => themeCubit)
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
}
