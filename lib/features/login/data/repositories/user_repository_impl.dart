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

    // DEFINIZIONE DELLA REQUEST BODY
    final requestBody =
        AuthenticationRequestDto(username: email, password: password);

    // DICHIARAZIONE DEL CLIENT + SUA INIZIALIZZAZIONE
    HttpCustomClient client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    // DICHIARAZIONE VARIABILE RESPONSE
    late Response response;

    // TENTO IL LOGIN
    try {
      response = await client.post(authenticationEndPoint);
    } on Exception {
      return const Left((LoginFailure()));
    }

    // RESPONSE STATUS CODE MAP
    // 200
    //    CAMPO username VUOTO
    //    CAMPO password VUOTO
    //    CREDENZIALI CORRETTE
    // 500
    //    CREDENZIALI ERRATE
    //    ERRORE DI CONNESSIONE CON IL SERVER
    if (response.statusCode != 200) {
      return const Left((LoginFailure()));
    }

    // DICHIARAZIONE DTO
    late AuthenticationResponseDto data;

    // CREAZIONE DTO DELLA RISPOSTA DAL RISULTATO DELLA CHIAMATA
    // response.data è DI TIPO Map<string, dynamic>
    try {
      data = AuthenticationResponseDto.fromMap(response.data);
    } on Exception {
      return const Left((DataParsingFailure()));
    }

    if (response.data['output']['messages'].isNotEmpty) {
      if (response.data.output.messages[0].code == 'password' ||
          response.data.output.messages[0].code == 'username') {
        return const Left((LoginFailure()));
      }
    }

    final User user = User.fromDto(data);

    const FlutterSecureStorage()
      ..write(key: 'username', value: email)
      ..write(key: 'password', value: password);

    return Right(user);
  }
}
