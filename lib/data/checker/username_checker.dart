class UsernameChecker {
  static bool checkUsername({required String userName}) {
    if (userName.length > 3) {
      return true;
    } else {
      throw "Name is too short";
    }
  }
}
