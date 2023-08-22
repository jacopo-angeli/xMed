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

class DBFailure extends FailureEntity {
  const DBFailure();
}

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

class LoginFailure extends FailureEntity {
  const LoginFailure();
}
