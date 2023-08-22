import 'package:dartz/dartz.dart';

import '../../../../core/error_handling/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<FailureEntity, User>> login(
      {required String email, required String password});
  Future<Either<FailureEntity, User>> logout();
}
