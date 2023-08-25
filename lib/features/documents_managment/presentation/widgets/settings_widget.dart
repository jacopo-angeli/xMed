import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SettingsList(
        applicationType: ApplicationType.both,
        sections: [
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
        ],
      ),
    );
  }
}
