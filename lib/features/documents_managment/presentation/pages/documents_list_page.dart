import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/config/routers/app_router.gr.dart';
import 'package:xmed/features/documents_managment/presentation/cubits/documents/documents_cubit.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';

import '../../../../config/routers/app_router.dart';
import '../widgets/documents_list_widget.dart';
import '../widgets/settings_widget.dart';

@RoutePage()
class DocumentsListPage extends StatefulWidget {
  const DocumentsListPage({super.key});

  @override
  State<DocumentsListPage> createState() => _DocumentsListPageState();
}

int selectedIndex = 0;

class _DocumentsListPageState extends State<DocumentsListPage> {
  List<Widget> views = [
    DocumentsListWidget(),
    SettingsWidget(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        final loginCubitState = context.read<LoginCubit>().state;
        if (loginCubitState is NotLoggedState) {
          // WHEN LOGGED NAVIGATE TO DOCUMENTS VIEW PAGE
          appRouter.replace(const LoginView());
        }
      },
      child: Scaffold(
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
                      label: Text('Lista Documenti Scaricati'),
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
        ),
      ),
    );
  }
}


/*
appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: AppBar(
            toolbarHeight: 500,
            title: Center(
                child: Column(
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
                    child: Column(
                      children: [
                        WhiteLabelLogo(),
                        Padding(padding: EdgeInsets.only(bottom: 10))
                      ],
                    )),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 60, maxWidth: 100),
                  child: Column(children: [
                    Text("DOCUMENTI SCARICATI",
                        style: GoogleFonts.luckiestGuy(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)))
                  ]),
                ),
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
*/