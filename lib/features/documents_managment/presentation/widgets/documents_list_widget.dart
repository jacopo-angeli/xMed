import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/features/documents_managment/domain/entities/Document.dart';
import 'package:xmed/core/utils/converters/colors_converter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xmed/features/documents_managment/domain/repositories/documents_managment_repository.dart';
import 'package:xmed/features/documents_managment/domain/repositories/namirial_documents_repository.dart';

import '../../../login/domain/entities/user.dart';
import '../../../whitelabeling/presentation/cubits/theme/theme_cubit.dart';
import '../../../whitelabeling/presentation/widgets/whitelable_logo.dart';
import '../cubits/documents/documents_cubit.dart';

class DocumentsListWidget extends StatelessWidget {
  final NamirialSDKDocumentsRepository namirialSDKDocumentsRepository;
  final DocumentsManagmentRepository documentsManagmentRepository;
  final User currentUser;
  const DocumentsListWidget({
    super.key,
    required this.namirialSDKDocumentsRepository,
    required this.documentsManagmentRepository,
    required this.currentUser,
  });

  Future<void> _documentSign(
      {required int idDocumento,
      required List<String> markers,
      required String callBackOption}) async {
    final filePath = await documentsManagmentRepository.getFilePath(
        idDocumento: idDocumento.toString(), idClinica: currentUser.idClinica);
    debugPrint(
        "WIZARD APERTO CON I SEGUENTI DATI : File path: $filePath, signatureFields: $markers, partialSigning: true, callBackOption: $callBackOption");
    await namirialSDKDocumentsRepository.startWizard(
        pdfFile: filePath,
        signatureFields: markers,
        partialSigning: true,
        callBackOption: callBackOption,
        idDocumento: idDocumento.toString());
  }

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
                                style: TextStyle(
                                    color: ColorsConverter.toDartColorWidget(
                                        state.currentTheme.colorPrimary),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    fontFamily: "Serif"));
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
                  return Expanded(
                    child: RefreshIndicator(
                        onRefresh: () async {
                          await context.read<DocumentsListCubit>().sync();
                        },
                        child: ListView(children: const [
                          Text(
                            "Nessun documento in lavorazione.",
                            textAlign: TextAlign.center,
                          )
                        ])),
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
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await context.read<DocumentsListCubit>().sync();
                      },
                      child: ListView(
                        children: [
                          for (var doc in listaDocumenti.entries)
                            FractionallySizedBox(
                              widthFactor: 0.97,
                              child: Builder(builder: (context) {
                                if (doc.value.status == "FIRMATO") {
                                  return Slidable(
                                    key: Key(doc.value.idDocumento.toString()),
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onPressed: (context) async {
                                            await context
                                                .read<DocumentsListCubit>()
                                                .documentUpload(
                                                    idDocumento: doc
                                                        .value.idDocumento
                                                        .toString());
                                            (
                                              idDocumento:
                                                  doc.value.idDocumento,
                                              markers:
                                                  doc.value.markersPaziente,
                                              callBackOption: "PAZIENTE"
                                            );
                                          },
                                          backgroundColor: Colors.lightBlue,
                                          foregroundColor: Colors.black,
                                          icon: Icons.upload_file,
                                          label: 'Carica',
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      elevation: 5,
                                      child: ListTile(
                                        leading: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.file_copy,
                                              size: 30,
                                            )
                                          ],
                                        ),
                                        title: Text(doc.value.nome),
                                        subtitle: Text(doc.value.descrizione),
                                        isThreeLine: true,
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 12,
                                              color:
                                                  (doc.value.status == "FIRMATO"
                                                      ? Colors.green
                                                      : (doc.value.status ==
                                                              "DA_FIRMARE"
                                                          ? Colors.red
                                                          : Colors.orange)),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(doc.value.status
                                                .replaceAll('_', ' ')),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Slidable(
                                    key: Key(doc.value.idDocumento.toString()),
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: ScrollMotion(),

                                      // All actions are defined in the children parameter.
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onPressed: doc.value.status !=
                                                      'FIRMATO' &&
                                                  doc.value.status !=
                                                      'FIRMATO_MEDICO'
                                              ? (context) async {
                                                  await _documentSign(
                                                      idDocumento:
                                                          doc.value.idDocumento,
                                                      markers: doc
                                                          .value.markersMedico,
                                                      callBackOption: "MEDICO");
                                                }
                                              : null,
                                          backgroundColor:
                                              doc.value.status != 'FIRMATO' &&
                                                      doc.value.status !=
                                                          'FIRMATO_MEDICO'
                                                  ? Colors.amber
                                                  : Colors.green,
                                          foregroundColor: Colors.black,
                                          icon: doc.value.status != 'FIRMATO' &&
                                                  doc.value.status !=
                                                      'FIRMATO_MEDICO'
                                              ? const IconData(0xe396,
                                                  fontFamily: 'MaterialIcons')
                                              : Icons.done,
                                          label: 'Medico',
                                        ),
                                        SlidableAction(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onPressed: (context) async {
                                            await _documentSign(
                                                idDocumento:
                                                    doc.value.idDocumento,
                                                markers:
                                                    doc.value.markersPaziente,
                                                callBackOption: "PAZIENTE");
                                          },
                                          backgroundColor:
                                              doc.value.status != 'FIRMATO' &&
                                                      doc.value.status !=
                                                          'FIRMATO_PAZIENTE'
                                                  ? Colors.amber
                                                  : Colors.green,
                                          foregroundColor: Colors.black,
                                          icon: doc.value.status != 'FIRMATO' &&
                                                  doc.value.status !=
                                                      'FIRMATO_PAZIENTE'
                                              ? const IconData(0xe491,
                                                  fontFamily: 'MaterialIcons')
                                              : Icons.done,
                                          label: 'Paziente',
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      elevation: 5,
                                      child: ListTile(
                                        leading: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.file_copy,
                                              size: 30,
                                            )
                                          ],
                                        ),
                                        title: Text(doc.value.nome),
                                        subtitle: Text(doc.value.descrizione),
                                        isThreeLine: true,
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 12,
                                              color:
                                                  (doc.value.status == "FIRMATO"
                                                      ? Colors.green
                                                      : (doc.value.status ==
                                                              "DA_FIRMARE"
                                                          ? Colors.red
                                                          : Colors.orange)),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(doc.value.status
                                                .replaceAll('_', ' ')),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                            )
                        ],
                      ),
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
