import 'package:dartz/dartz.dart';

import 'package:refactor_xmed/core/error/failures.dart';
import 'package:refactor_xmed/features/login/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(String username, String password);
}
