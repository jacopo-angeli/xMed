import 'package:dartz/dartz.dart';

import '../../../../core/error_handling/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class LogInUseCase {
  final UserRepository userRepository;

  LogInUseCase({required this.userRepository});

  Future<Either<FailureEntity, User>> execute(
      {required String email, required String password}) async {
    return await userRepository.login(email: email, password: password);
  }
}
