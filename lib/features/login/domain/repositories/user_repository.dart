import 'package:dartz/dartz.dart';

import '../../../../core/error_handling/failures.dart';
import '../entities/user.dart';

/// User repository interface
abstract class UserRepository {
  /// Tenta il login dato una email e una password
  Future<Either<FailureEntity, User>> login(
      {required String email, required String password});

  /// Effettua il log out, concretamente solo in locale in quanto
  /// una sessione non richiede salvataggio di nessun dato nel backoffice
  Future<Either<FailureEntity, User>> logout();
}
