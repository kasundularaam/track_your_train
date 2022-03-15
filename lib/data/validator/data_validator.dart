import '../checker/email_checker.dart';
import '../checker/password_checker.dart';

class DataValidator {
  static bool validateLogin({required String email, required String password}) {
    try {
      final bool validatedEmail = EmailChecker.validateEmail(email: email);
      final bool validatedPassword =
          PasswordChecker.validatePassword(password: password);
      return validatedEmail && validatedPassword;
    } catch (e) {
      throw e.toString();
    }
  }
}
