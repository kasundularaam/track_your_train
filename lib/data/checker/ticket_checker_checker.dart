class TicketCheckerChecker {
  static const String tcEmail = "tc@tyt.com";
  static const String tcPassword = "123456";
  static const String uid = "tc000000";
  static bool isTicketChecker(
      {required String email, required String password}) {
    if (email == tcEmail && password == tcPassword) {
      return true;
    } else {
      return false;
    }
  }
}
