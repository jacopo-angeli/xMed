import 'package:flutter/material.dart';
import 'package:xmed/features/documents_managment/domain/repositories/namirial_documents_repository.dart';
import '../../../login/domain/entities/user.dart';
import '../../domain/repositories/documents_managment_repository.dart';
import '../widgets/documents_list_widget.dart';
import '../widgets/settings_widget.dart';

class DocumentsListTabletLayout extends StatefulWidget {
  final NamirialSDKDocumentsRepository namirialSDKDocumentsRepository;
  final DocumentsManagmentRepository documentsManagmentRepository;
  final User currentUser;

  List<Widget> views = [];

  DocumentsListTabletLayout(
      {super.key,
      required this.namirialSDKDocumentsRepository,
      required this.documentsManagmentRepository,
      required this.currentUser});

  @override
  State<DocumentsListTabletLayout> createState() =>
      _DocumentsListTabletLayoutState();
}

int selectedIndex = 0;

class _DocumentsListTabletLayoutState extends State<DocumentsListTabletLayout> {
  @override
  void initState() {
    widget.views.add(
      DocumentsListWidget(
        namirialSDKDocumentsRepository: widget.namirialSDKDocumentsRepository,
        documentsManagmentRepository: widget.documentsManagmentRepository,
        currentUser: widget.currentUser,
      ),
    );
    widget.views.add(
      const SettingsWidget(),
    );

    super.initState();
  }

  void _onItemTapped(int index) async {
    await Future.delayed(const Duration(milliseconds: 50));
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: _selectedIndex,
              groupAlignment: 0,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.document_scanner_outlined),
                  selectedIcon: Icon(Icons.document_scanner),
                  label: Column(
                    children: [
                      Text('Documenti'),
                      Text('in lavorazione'),
                    ],
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Impostazioni'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(child: widget.views[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
