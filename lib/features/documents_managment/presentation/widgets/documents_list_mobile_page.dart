import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/features/documents_managment/domain/repositories/namirial_documents_repository.dart';
import 'package:xmed/features/documents_managment/presentation/cubits/documents/documents_cubit.dart';
import 'package:xmed/core/utils/converters/colors_converter.dart';
import 'package:xmed/features/license/domain/repositories/namirial_sdk_repository.dart';

import '../../../login/domain/entities/user.dart';
import '../../../whitelabeling/presentation/cubits/theme/theme_cubit.dart';
import '../../domain/repositories/documents_managment_repository.dart';
import '../widgets/documents_list_widget.dart';
import '../widgets/settings_widget.dart';

class DocumentsListMobileLayout extends StatefulWidget {
  final NamirialSDKDocumentsRepository namirialSDKDocumentsRepository;
  final DocumentsManagmentRepository documentsManagmentRepository;
  final User currentUser;

  DocumentsListMobileLayout(
      {super.key,
      required this.namirialSDKDocumentsRepository,
      required this.documentsManagmentRepository,
      required this.currentUser});

  @override
  State<DocumentsListMobileLayout> createState() =>
      _DocumentsListMobileLayoutState();
}

class _DocumentsListMobileLayoutState extends State<DocumentsListMobileLayout> {
  List<Widget> views = [];
  @override
  void initState() {
    super.initState();
    views = [
      DocumentsListWidget(
        namirialSDKDocumentsRepository: widget.namirialSDKDocumentsRepository,
        documentsManagmentRepository: widget.documentsManagmentRepository,
        currentUser: widget.currentUser,
      ),
      const SettingsWidget(),
    ];
  }

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
