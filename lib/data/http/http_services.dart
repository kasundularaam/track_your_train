import 'dart:developer';
import 'dart:io';

import '../../core/exceptions/route_exception.dart';
import '../data_providers/data_provider.dart';

import 'package:http/http.dart' as http;

import '../models/app_user.dart';

class HTTPServices {
  static Future<AppUser> loginUser(
      {required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        final response = await http.get(
          Uri.parse(
            DataProvider.loginUrl(email: email, password: password),
          ),
        );
        if (response.statusCode == 200) {
          log(response.body);
          return AppUser.fromJson(response.body);
        } else {
          throw Failure(message: '${response.statusCode}');
        }
      } else {
        throw Failure(message: "Some fields are empty");
      }
    } on SocketException {
      throw Failure(message: "No connection!");
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
