import '../models/authentication/authentication_request_dto.dart';
import '../models/authentication/authentication_response_dto.dart';

abstract class RemoteAuthDataSource {
  Future<AuthenticationResponseDto> login(AuthenticationRequestDto requestBody);
}
