import '../../data/models/authentication/authentication_request_dto.dart';
import '../../data/models/authentication/authentication_response_dto.dart';

abstract class UserRepository {
  Future<AuthenticationResponseDto> auth(AuthenticationRequestDto requestBody);
}
