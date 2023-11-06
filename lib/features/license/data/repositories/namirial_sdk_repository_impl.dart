import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/license/domain/entities/license.dart';
import '../../domain/repositories/namirial_sdk_repository.dart';

class NamirialSDKLicenseRepositoryImpl implements NamirialSDKLicenseRepository {
  // DICHIARAZIONE CHANNEL PER INTEGRAZIONE CON PARTE NATIVA
  final _licenseChannel = const MethodChannel('cwbi/license');
  final _setupChannel = const MethodChannel('cwbi/setup');

  /// CONTROLLA SE NEL DISPOSITIVO è PRESENTE UNA LICENZA E
  /// CONTEMPORANEAMENTE SE è VALIDA
  @override
  Future<Either<FailureEntity, License>> requireLicense(
      {required String username,
      required String email,
      required String licenseFilePath}) async {
    // TENTO DI RECUPERARE LA LICENZA DA METODO requireLicense DI NAMIRIAL SDK
    // OUTCOMES:
    // licenseData.isDataValid (CHECK DELLA VALIDITà DEL promoCode):
    //        LICENZA OK E LICENZA RECUPERATA => LICENZA IN FORMATO JSON (String)
    //        LICENZA FROZEN/EXPIRED => String "expired"
    //        CERTIFICATO INVALIDO => String "invalid"
    //        ERRORE GENERICO => String "error"
    //  not licenseData.isDataValid && not licenseData.hasValidCertificate() (CHECK DELLA VALIDITà DEL CERTIFICATO):
    //        => String "wrong params"
    // not licenseData.isDataValid && licenseData.hasValidCertificate() :
    //        => String "invalid certificate"
    final String nativeRequireLicenseResult =
        await _licenseChannel.invokeMethod(
      'requireLicense',
      {
        'username': username,
        'mailAddress': email,
        'licenseFile': licenseFilePath,
      },
    );
    switch (nativeRequireLicenseResult) {
      case 'expired':
        return const Left(LicenseExpired());
      case 'invalid':
        return const Left(InvalidCertificateFailure());
      case 'error':
        return const Left(GenericFailureLicenseRequired());
      case 'wrong params':
        return const Left(WrongParamFailure());
      case 'invalid certificate':
        break;
      default:
        break;
    }

    return Right(License.fromJson(nativeRequireLicenseResult));
  }
}
