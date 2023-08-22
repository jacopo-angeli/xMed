import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:xmed/core/network/data_states.dart';
import 'package:xmed/core/network/http_custom_client.dart';
import 'package:xmed/features/login/data/models/authentication/authentication_request_dto.dart';
import 'package:xmed/features/login/domain/entities/user.dart';
import 'package:xmed/features/login/domain/repositories/user_repository.dart';

import '../../../../utils/exceptions.dart';

class UserRepositoryImpl implements UserRepository {
  User currentUser = User.defaultUser();
  @override
  Future<Either<DataState, User>> login(
      String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      throw LoginException();
    }

    final requestBody = AuthenticationRequestDto.fromMap(<String, dynamic>{
      'username': username,
      'password': password,
    }).toJson();

    final client = await HttpCustomClient.builder().setup(requestBody);

    late Response response;

    print(client.body);
    return Right(currentUser);

    // try {
    //   response = await client.post('/loginVerify');
    // } on Exception {
    //   throw LoginException();
    // }

    // if (response.statusCode != 200) {
    //   return const Left(DataFailed(LoginFailure()));
    // }

    // late AuthenticationResponseDto data;

    // try {
    //   data = AuthenticationResponseDto.fromJson(response.data);
    // } on Exception {
    //   return const Left(DataFailed(DataParsingFailure()));
    // }

    // if (data.output.messages.isNotEmpty) {
    //   if (data.output.messages[0].code == 'password' ||
    //       data.output.messages[0].code == 'username') {
    //     return const Left(DataFailed(LoginFailure()));
    //   }
    // }

    // final User user = User.fromMap(data.toMap());

    // const FlutterSecureStorage()
    //   ..write(key: 'username', value: username)
    //   ..write(key: 'password', value: password);

    // currentUser = user;
    // return Right(currentUser);
  }

  @override
  Future<Either<DataState, User>> logout() async {
    currentUser = User.defaultUser();
    return Right(currentUser);
  }
}
