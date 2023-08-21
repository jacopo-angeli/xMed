import 'package:dartz/dartz.dart';

import '../../../../core/error/data_states.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class Login {
  final UserRepository userRepository;

  Login({required this.userRepository});

  Future<Either<DataState, User>> execute(
      {required String username, required String password}) async {
    return await userRepository.login(username, password);
  }
}
