import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';
import '../../../whitelabeling/presentation/widgets/xmed_logo.dart';
import '../../domain/enitites/Document.dart';
import '../cubits/documents/documents_cubit.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(title: Text('Common'), tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: Text('Language'),
              value: Text('English'),
            ),
            SettingsTile.navigation(
              leading: Icon(Icons.logout),
              title: Text('LogOut'),
              trailing: ElevatedButton(
                child: Text('LOGOUT'),
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
