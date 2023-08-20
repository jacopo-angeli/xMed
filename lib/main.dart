import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xmed/data/repositories/clinic_repository.dart';
import 'package:xmed/logic/bloc/clinic/clinic_bloc.dart';
import 'package:xmed/logic/bloc/login/login_bloc.dart';
import 'package:xmed/presentation/screens/login_page.dart';

void main() async {
  /*----------------------------Widget Inizialization--------------------------- */
  // Salvataggio dei dati della clinica in locale
  await Hive.initFlutter();
  // Per utilizzare GoogleFonts
  WidgetsFlutterBinding.ensureInitialized();
  // Per varaibili in .env files
  await dotenv.load(fileName: ".env.test");

  ClinicRepository repo = ClinicRepository();
  repo.getClinicaDetails(clinicID: "13");

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<ClinicBloc>(
          create: (context) => ClinicBloc(),
        ),
      ],
      child: MaterialApp(
          home: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return LoginPage();
      }))));
}
