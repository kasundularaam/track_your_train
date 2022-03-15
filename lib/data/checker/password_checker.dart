class PasswordChecker {
  static bool validatePassword({required String password}) {
    if (password.isNotEmpty) {
      if (password.length > 5) {
        return true;
      } else {
        throw "Wrong password!";
      }
    } else {
      throw "Password field is empty!";
    }
  }
}
