import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmed/features/documents_managment/domain/entities/Document.dart';

import '../../../whitelabeling/presentation/widgets/xmed_logo.dart';
import '../cubits/documents/documents_cubit.dart';

class DocumentsListWidget extends StatelessWidget {
  const DocumentsListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text("DOCUMENTI SCARICATI",
                        style: GoogleFonts.luckiestGuy(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 32)))
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
                  Icon(Icons.dangerous_rounded),
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
                      ListTile(
                        leading: Icon(Icons.auto_stories_rounded),
                        title: Text(doc.nome),
                        subtitle: Text(doc.descrizione),
                        isThreeLine: true,
                        trailing: Text(doc.status),
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
