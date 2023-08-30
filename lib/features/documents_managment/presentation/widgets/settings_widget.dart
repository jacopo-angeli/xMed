import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:xmed/core/utils/converters/colors_converter.dart';
import 'package:xmed/features/documents_managment/presentation/cubits/documents/documents_cubit.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';

import '../../../whitelabeling/presentation/cubits/theme/theme_cubit.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SettingsList(
        applicationType: ApplicationType.both,
        sections: [
          SettingsSection(title: Text("Profilo"), tiles: [
            SettingsTile.navigation(
              title: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Text(state.currentTheme!.nome);
                },
              ),
            ),
            SettingsTile.navigation(
              title: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Text(state.currentTheme!.descrizione);
                },
              ),
            ),
            SettingsTile.navigation(
              title: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Text(state.currentTheme!.status);
                },
              ),
            ),
          ]),
          SettingsSection(
              title: const Text(
                'Informazioni sul tema',
                style: TextStyle(fontSize: 15),
              ),
              tiles: [
                SettingsTile.navigation(
                    leading: BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) {
                        return Icon(
                          Icons.circle,
                          color: ColorsConverter.toDartColorWidget(
                              state.currentTheme!.colorPrimary),
                        );
                      },
                    ),
                    title: const Text('Colore Primario')),
                SettingsTile.navigation(
                    leading: BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) {
                        return Icon(
                          Icons.circle,
                          color: ColorsConverter.toDartColorWidget(
                              state.currentTheme!.colorBackground),
                        );
                      },
                    ),
                    title: const Text('Colore Sfondo')),
                SettingsTile.navigation(
                    leading: BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) {
                        return Icon(
                          Icons.circle,
                          color: ColorsConverter.toDartColorWidget(
                              state.currentTheme!.colorAccent),
                        );
                      },
                    ),
                    title: const Text('Colore di contrasto')),
                SettingsTile.navigation(
                    title: const Text("Aggiorna"),
                    trailing: BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) {
                        return IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            context
                                .read<ThemeCubit>()
                                .synch(currentTheme: state.currentTheme!);
                          },
                        );
                      },
                    ))
              ]),
          SettingsSection(title: const Text('Common'), tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: const Text('Lingua'),
              value: const Text('Italiano'),
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              trailing: ElevatedButton(
                child: const Text('LOGOUT'),
                onPressed: () {
                  context.read<LoginCubit>().logOutRequest();
                },
              ),
            )
          ]),
          SettingsSection(
            title: const Text('Gestione dei documenti'),
            tiles: [
              SettingsTile.navigation(
                title: const Text("Pulisci la cache"),
                trailing: IconButton(
                  icon: Icon(Icons.clear_all),
                  onPressed: () {
                    context.read<DocumentsListCubit>().clearCache(
                        idClinica:
                            context.read<LoginCubit>().currentUser.idClinica);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
