import 'package:track_your_train/data/checker/match_passwords.dart';
import 'package:track_your_train/data/checker/username_checker.dart';

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

  static bool validateRegister(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) {
    try {
      final bool validatedName = UsernameChecker.checkUsername(userName: name);
      final bool validatedEmail = EmailChecker.validateEmail(email: email);
      final bool validatedPassword =
          PasswordChecker.validatePassword(password: password);
      final bool matchPasswords = MatchPasswords.matchPasswords(
          password: password, confirmPassword: confirmPassword);
      return validatedEmail &&
          validatedPassword &&
          validatedName &&
          matchPasswords;
    } catch (e) {
      throw e.toString();
    }
  }
}
