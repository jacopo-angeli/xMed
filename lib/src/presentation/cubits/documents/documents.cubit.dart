import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/document.model.dart';

part 'documents.states.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit() : super(DocumentsSynchingState());
}
