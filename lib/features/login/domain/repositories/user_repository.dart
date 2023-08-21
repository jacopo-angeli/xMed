import 'package:dartz/dartz.dart';

import '../../../../core/netwwork/data_states.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<DataState, User>> login(String username, String password);
}
