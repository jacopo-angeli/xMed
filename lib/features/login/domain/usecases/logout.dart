import 'package:dartz/dartz.dart';

import '../../../../core/network/data_states.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class LogOutUseCase {
  final UserRepository userRepository;

  LogOutUseCase({required this.userRepository});

  Future<Either<DataState, User>> execute(
      {required String username, required String password}) async {
    return await userRepository.logout();
  }
}
