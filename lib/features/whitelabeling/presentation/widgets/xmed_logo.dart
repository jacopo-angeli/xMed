import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/features/whitelabeling/presentation/cubits/theme/theme_cubit.dart';

class WhiteLabelLogo extends StatelessWidget {
  const WhiteLabelLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        // TODO Sistemare la view sulla base dello stato del tema
        return const SizedBox(width: 100, height: 100, child: FlutterLogo());
      },
    );
  }
}
