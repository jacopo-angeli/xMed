abstract class FailureEntity {
  const FailureEntity();
}

class ServerFailure extends FailureEntity {
  const ServerFailure();
}

class DataParsingFailure extends FailureEntity {
  const DataParsingFailure();
}

class ValidationFailure extends FailureEntity {
  const ValidationFailure();
}

class ThemeRetrieveFailure extends FailureEntity {
  const ThemeRetrieveFailure();
}

class DBFailure extends FailureEntity {
  const DBFailure();
}

// Licenses
class LicenseActivationFailure extends FailureEntity {
  const LicenseActivationFailure();
}

class LicenseSaveFailure extends FailureEntity {
  const LicenseSaveFailure();
}

class DocumentUploadFailure extends FailureEntity {
  const DocumentUploadFailure();
}

class LicenseRetrieveFailure extends FailureEntity {
  const LicenseRetrieveFailure();
}

class LicenseDownloadFailure extends FailureEntity {
  const LicenseDownloadFailure();
}

class LicenseExpired extends FailureEntity {
  const LicenseExpired();
}

class GenericFailureLicenseRequired extends FailureEntity {
  const GenericFailureLicenseRequired();
}

class InvalidCertificateFailure extends FailureEntity {
  const InvalidCertificateFailure();
}

class MissingLocalLicense extends FailureEntity {
  const MissingLocalLicense();
}

class WrongParamFailure extends FailureEntity {
  const WrongParamFailure();
}

class LoginFailure extends FailureEntity {
  const LoginFailure();
}

class FailedSigningAttempt extends FailureEntity {
  const FailedSigningAttempt();
}

class DocumentDownloadFailure extends FailureEntity {}

class DocumentsDirectoryNotFound extends FailureEntity {}
