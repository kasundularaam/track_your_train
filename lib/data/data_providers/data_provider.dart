// Dummy file

class DataProvider {
  static String loginUrl({required String email, required String password}) =>
      "http://192.168.8.100:3000/login/$email/$password";

  static String signInUrl(
          {required String name,
          required String email,
          required String password,
          required String confirmPassword}) =>
      "http://127.0.0.1:3000/signin/$name/$email/$password/$confirmPassword";
}
