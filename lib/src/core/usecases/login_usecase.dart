import '../entitites/credentials_entity.dart';
import '../entitites/user_entity.dart';

abstract class LoginUseCase {
  Future<UserEntity> login(CredentialsEntity credential);
}
