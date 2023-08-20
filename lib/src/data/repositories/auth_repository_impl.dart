import '../../core/entitites/user_entity.dart';
import '../../core/repositories/user_repository.dart';
import '../datasources/remote_auth_data_source.dart';
import '../models/authentication/authentication_request_dto.dart';
import '../models/authentication/authentication_response_dto.dart';

class AuthRepositoryImpl implements UserRepository {
  final RemoteAuthDataSource remoteSource;

  AuthRepositoryImpl(this.remoteSource);

  @override
  Future<AuthenticationResponseDto> auth(
      AuthenticationRequestDto requestBody) async {
    return await remoteSource.login(requestBody);
  }
}
