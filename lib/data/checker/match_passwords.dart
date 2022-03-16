class MatchPasswords {
  static bool matchPasswords(
      {required String password, required String confirmPassword}) {
    if (password == confirmPassword) {
      return true;
    } else {
      throw "Passwords do not match!";
    }
  }
}
