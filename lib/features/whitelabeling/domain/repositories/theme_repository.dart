import 'package:dartz/dartz.dart';
import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/whitelabeling/domain/entities/theme.dart';

abstract class ThemeRepository {
  /// TODO Descrizione
  Future<Either<FailureEntity, XmedTheme>> getRemoteClinicTheme(
      {required idClinica});

  /// TODO Descrizione
  Future<Either<FailureEntity, XmedTheme>> getLocalClinicTheme();

  /// TODO Descrizione
  Future<void> writeLocalClinicTheme(XmedTheme tema);
}
