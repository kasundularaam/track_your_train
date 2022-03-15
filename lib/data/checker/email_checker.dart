class EmailChecker {
  static bool validateEmail({required String email}) {
    if (email.isNotEmpty) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (emailValid) {
        return true;
      } else {
        throw "Email is not valid!";
      }
    } else {
      throw "Email field is empty!";
    }
  }
}
