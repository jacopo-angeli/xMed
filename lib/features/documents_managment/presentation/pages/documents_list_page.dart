import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:xmed/features/documents_managment/presentation/cubits/documents/documents_cubit.dart';
import 'package:xmed/features/whitelabeling/presentation/widgets/xmed_logo.dart';

import '../../domain/enitites/Document.dart';

@RoutePage()
class DocumentsListPage extends StatefulWidget {
  const DocumentsListPage({super.key});

  @override
  State<DocumentsListPage> createState() => _DocumentsListPageState();
}

int selectedIndex = 0;

class _DocumentsListPageState extends State<DocumentsListPage> {
  List<Widget> views = [
    Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: AppBar(
            title: Center(
                child: Column(
          children: [
            SizedBox(height: 60, width: 60, child: WhiteLabelLogo()),
            Text("DOCUMENTI SCARICATI",
                style: GoogleFonts.luckiestGuy(
                    textStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))),
          ],
        ))),
      ),
      body: BlocBuilder<DocumentsListCubit, DocumentsListState>(
        builder: (context, state) {
          if (state is EmptyDocumentsListState) {
            return Center(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.dangerous_rounded),
                      Text("La tua lista documenti sembra essere vuota")
                    ],
                  )),
            );
          } else if (state is DocumentsListSynchingState) {
            return const CircularProgressIndicator();
          } else {
            final List<Document> listaDocumenti =
                context.read<DocumentsListCubit>().state.documentList;
            // per ogni elemento della lista devo creare una
            // Card(
            //       child: ListTile(
            //     leading: Icon(Icons.auto_stories_rounded),
            //     title: Text('Artroscopia del ginocchio'),
            //     subtitle: Text('operazione a cuore aperto.'),
            //   //     isThreeLine: true,
            //     )),
            // da mettere tutte all' interno di una Listview
            return ListView(children: [
              for (var doc in listaDocumenti)
                Card(
                    child: ListTile(
                  leading: Icon(Icons.auto_stories_rounded),
                  title: Text(doc.nome),
                  subtitle: Text(doc.descrizione),
                  isThreeLine: true,
                  trailing: Text(doc.status),
                ))
            ]);
          }
        },
      ),
    ),
    Center(
      child: Text('Impostazioni'),
    ),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => DocumentsListCubit()..sync([]),
        child: SafeArea(
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
                    label: Text('First'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.bookmark_border),
                    selectedIcon: Icon(Icons.book),
                    label: Text('Second'),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // This is the main content.
              Expanded(child: views[_selectedIndex]),
            ],
          ),
        ),
      ),
    );
    // child: Scaffold(
    //   body: Row(
    //     children: [
    //       SideNavigationBar(
    //         theme: SideNavigationBarTheme(
    //             backgroundColor: Colors.grey.shade800,
    //             itemTheme: SideNavigationBarItemTheme(
    //               unselectedBackgroundColor: Colors.grey.shade800,
    //               selectedBackgroundColor: Colors.grey,
    //               selectedItemColor: Colors.white,
    //             ),
    //             togglerTheme: SideNavigationBarTogglerTheme.standard(),
    //             dividerTheme: SideNavigationBarDividerTheme.standard()),
    //         selectedIndex: selectedIndex,
    //         items: const [
    //           SideNavigationBarItem(
    //             icon: Icons.edit_document,
    //             label: 'Documenti Scaricati',
    //           ),
    //           SideNavigationBarItem(
    //             icon: Icons.settings,
    //             label: 'Impostazioni',
    //           ),
    //         ],
    //         onTap: (index) {
    //           setState(() {
    //             selectedIndex = index;
    //           });
    //         },
    //       ),
    //       Expanded(
    //         child: views.elementAt(selectedIndex),
    //       ),
    //     ],
    //   ),
    // ),
  }
}
