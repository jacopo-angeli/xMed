import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/logic/bloc/clinic/clinic_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicBloc, ClinicState>(
      builder: (context, state) {
        if (state is DetailsAvaiableState) {}
        return SizedBox(width: 100, height: 100, child: FlutterLogo());
      },
    );
  }
}
