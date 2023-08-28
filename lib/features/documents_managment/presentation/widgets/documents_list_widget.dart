import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmed/features/documents_managment/domain/entities/Document.dart';
import 'package:xmed/utils/converters/colors_converter.dart';

import '../../../whitelabeling/presentation/cubits/theme/theme_cubit.dart';
import '../../../whitelabeling/presentation/widgets/xmed_logo.dart';
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
                        const SizedBox(
                          height: 60,
                          width: 60,
                          child: WhiteLabelLogo(),
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<ThemeCubit, ThemeState>(
                          builder: (context, state) {
                            return Text("DOCUMENTI SCARICATI",
                                style: GoogleFonts.luckiestGuy(
                                    textStyle: TextStyle(
                                        color:
                                            ColorsConverter.toDartColorWidget(
                                                state.theme.colorPrimary),
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
                if (state is EmptyDocumentsListState) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("La tua lista documenti sembra essere vuota")
                    ],
                  );
                } else if (state is DocumentsListSynchingState) {
                  return const CircularProgressIndicator();
                } else {
                  final List<Document> listaDocumenti =
                      context.read<DocumentsListCubit>().state.documentList;
                  Widget widget = Expanded(
                    child: ListView(
                      children: [
                        for (var doc in listaDocumenti)
                          FractionallySizedBox(
                            widthFactor: 0.97,
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Builder(builder: (context) {
                                      switch (doc.status) {
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
                                title: Text(doc.nome),
                                subtitle: Text(doc.descrizione),
                                isThreeLine: true,
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: (doc.status == "FIRMATO"
                                          ? Colors.green
                                          : (doc.status == "DA_FIRMARE"
                                              ? Colors.red
                                              : Colors.orange)),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(doc.status.replaceAll('_', ' ')),
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
