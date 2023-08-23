import 'package:xmed/utils/constants/regular_expressions.dart';

class ValidatorService {
  static emailValidation({required String email}) {
    return RegExp(RegularExpressions.emailRegExp()).hasMatch(email);
  }
}
