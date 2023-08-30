import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/features/whitelabeling/presentation/cubits/theme/theme_cubit.dart';
import 'package:xmed/core/utils/converters/images_converter.dart';

class WhiteLabelLogo extends StatelessWidget {
  final double? customWidth;
  final double? customHeight;
  const WhiteLabelLogo({
    super.key,
    this.customWidth,
    this.customHeight,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ThemeSynchedState:
          case ThemeSynchingState:
            return SizedBox(
                width: customWidth,
                height: customHeight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ImageConverter.b64toWidget(state.currentTheme!.logo),
                ));
          case AppStartedState:
          default:
            return SizedBox(
                width: customWidth,
                height: customHeight,
                child: Image.asset('assets/logo.png'));
        }
      },
    );
  }
}
