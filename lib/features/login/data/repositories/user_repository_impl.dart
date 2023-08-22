import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xmed/core/network/http_custom_client.dart';
import 'package:xmed/features/login/data/models/authentication/authentication_request_dto.dart';
import 'package:xmed/features/login/domain/entities/user.dart';
import 'package:xmed/features/login/domain/repositories/user_repository.dart';

import '../../../../core/error_handling/failures.dart';
import '../../../../utils/constants/strings.dart';
import '../models/authentication/authentication_response_dto.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<FailureEntity, User>> logout() async {
    // Delete dei dati dell'salvati in locale per evitare autologin
    return Right(User.defaultUser());
  }

  @override
  Future<Either<FailureEntity, User>> login(
      {required String email, required String password}) async {
    // Contatta il back-office con una coppia username e password
    // Gestisce la risposta del backoffice

    // Definizione della request body
    final requestBody =
        AuthenticationRequestDto(email: email, password: password);

    final client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    late Response response;

    try {
      response = await client.post(authenticationEndPoint);
    } on Exception {
      return const Left((LoginFailure()));
    }

    if (response.statusCode != 200) {
      return const Left((LoginFailure()));
    }

    late AuthenticationResponseDto data;

    try {
      data = AuthenticationResponseDto.fromJson(response.data);
    } on Exception {
      return const Left((DataParsingFailure()));
    }

    if (data.output.messages.isNotEmpty) {
      if (data.output.messages[0].code == 'password' ||
          data.output.messages[0].code == 'username') {
        return const Left((LoginFailure()));
      }
    }

    final User user = User.fromMap(data.toMap());

    const FlutterSecureStorage()
      ..write(key: 'username', value: email)
      ..write(key: 'password', value: password);

    return Right(user);
  }
}
