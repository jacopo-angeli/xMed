import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/logic/bloc/login/login_bloc.dart';
import 'package:xmed/presentation/screens/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BlocProvider<LoginBloc>(
    create: (context) => LoginBloc(),
    child: MaterialApp(
        home: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return LoginPage();
    })),
  ));
}
