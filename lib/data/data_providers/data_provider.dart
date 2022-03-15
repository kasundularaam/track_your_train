// Dummy file

class DataProvider {
  static String loginUrl({required String email, required String password}) =>
      "$serverAddress/login/$email/$password";

  static String signInUrl(
          {required String name,
          required String email,
          required String password,
          required String confirmPassword}) =>
      "$serverAddress/signin/$name/$email/$password/$confirmPassword";
}

const String serverAddress = "http://15.206.173.183:3000";
