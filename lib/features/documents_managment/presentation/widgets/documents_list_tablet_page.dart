import 'package:flutter/material.dart';

import '../widgets/documents_list_widget.dart';
import '../widgets/settings_widget.dart';

class DocumentsListTabletLayout extends StatefulWidget {
  const DocumentsListTabletLayout({super.key});

  @override
  State<DocumentsListTabletLayout> createState() =>
      _DocumentsListTabletLayoutState();
}

int selectedIndex = 0;

class _DocumentsListTabletLayoutState extends State<DocumentsListTabletLayout> {
  List<Widget> views = [
    const DocumentsListWidget(),
    const SettingsWidget(),
  ];
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
            Expanded(child: views[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
