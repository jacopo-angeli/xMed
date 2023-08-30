import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmed/features/documents_managment/domain/entities/Document.dart';
import 'package:xmed/core/utils/converters/colors_converter.dart';

import '../../../whitelabeling/presentation/cubits/theme/theme_cubit.dart';
import '../../../whitelabeling/presentation/widgets/whitelable_logo.dart';
import '../cubits/documents/documents_cubit.dart';

class DocumentsListWidget extends StatelessWidget {
  const DocumentsListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const WhiteLabelLogo(
                          customHeight: 100,
                        ),
                        BlocBuilder<ThemeCubit, ThemeState>(
                          builder: (context, state) {
                            return Text("DOCUMENTI SCARICATI",
                                style: GoogleFonts.luckiestGuy(
                                    textStyle: TextStyle(
                                        color:
                                            ColorsConverter.toDartColorWidget(
                                                state.currentTheme!
                                                    .colorPrimary),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32)));
                          },
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 50)),
            BlocBuilder<DocumentsListCubit, DocumentsListState>(
              builder: (context, state) {
                if (state is DocumentsSynchState &&
                    state.documentsList.isEmpty) {
                  return const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [Text("Nessun documento in lavorazione.")],
                  );
                } else if (state is DocumentsSynchingState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                          value: null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(state.currentOperation)
                    ],
                  );
                } else {
                  // Recupero la lista dei documenti
                  final Map<int, Document> listaDocumenti = state.documentsList;
                  // Mostro a schermo la lista di documenti
                  Widget widget = Expanded(
                    child: ListView(
                      children: [
                        for (var doc in listaDocumenti.entries)
                          FractionallySizedBox(
                            widthFactor: 0.97,
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Builder(builder: (context) {
                                      switch (doc.value.status) {
                                        case 'DA_FIRMARE':
                                        case 'FIRMATO_PAZIENTE':
                                        case 'FIRMATO_MEDICO':
                                          return const Icon(
                                            Icons.edit_document,
                                            size: 50,
                                          );
                                        case 'FIRMATO':
                                        default:
                                          return const Icon(
                                            Icons.upload,
                                            size: 50,
                                          );
                                      }
                                    }),
                                  ],
                                ),
                                title: Text(doc.value.nome),
                                subtitle: Text(doc.value.descrizione),
                                isThreeLine: true,
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: (doc.value.status == "FIRMATO"
                                          ? Colors.green
                                          : (doc.value.status == "DA_FIRMARE"
                                              ? Colors.red
                                              : Colors.orange)),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(doc.value.status.replaceAll('_', ' ')),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  );
                  return widget;
                }
              },
            )
          ],
        ));
  }
}
