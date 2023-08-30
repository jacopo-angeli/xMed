import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/features/documents_managment/presentation/cubits/documents/documents_cubit.dart';
import 'package:xmed/core/utils/converters/colors_converter.dart';

import '../../../whitelabeling/presentation/cubits/theme/theme_cubit.dart';
import '../widgets/documents_list_widget.dart';
import '../widgets/settings_widget.dart';

class DocumentsListMobileLayout extends StatefulWidget {
  const DocumentsListMobileLayout({super.key});

  @override
  State<DocumentsListMobileLayout> createState() =>
      _DocumentsListMobileLayoutState();
}

class _DocumentsListMobileLayoutState extends State<DocumentsListMobileLayout> {
  List<Widget> views = [
    const DocumentsListWidget(),
    const SettingsWidget(),
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) async {
    await Future.delayed(const Duration(milliseconds: 50));
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (themeCubitContext, themeCubitState) {
            return BlocBuilder<DocumentsListCubit, DocumentsListState>(
              builder: (context, state) {
                if (state is DocumentsSynchingState) {
                  return FloatingActionButton(
                    backgroundColor: ColorsConverter.toDartColorWidget(
                        themeCubitState.currentTheme!.colorAccent),
                    onPressed: null,
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  return FloatingActionButton(
                    backgroundColor: ColorsConverter.toDartColorWidget(
                        themeCubitState.currentTheme!.colorAccent),
                    child: const Icon(Icons.refresh),
                    onPressed: () {
                      debugPrint("DEBUGGG");
                      context.read<DocumentsListCubit>().sync();
                    },
                  );
                }
              },
            );
          },
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner_outlined),
                activeIcon: Icon(Icons.document_scanner),
                label: 'Documenti in lavorazione'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlue,
          onTap: _onItemTapped,
        ),
        body: views[_selectedIndex],
      ),
    );
  }
}
