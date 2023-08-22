import 'package:dartz/dartz.dart';

import '../../../../core/network/data_states.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<DataState, User>> login(String email, String password);
  Future<Either<DataState, User>> logout();
}
