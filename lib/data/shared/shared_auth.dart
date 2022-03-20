import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_your_train/data/converters/user_type_converter.dart';
import 'package:track_your_train/data/shared/shared_keys.dart';

import '../../data/models/type_user.dart';

class SharedAuth {
  static Future<void> addUser({required TypeUser typeUser}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(SharedKeys.uid, typeUser.userId);
      preferences.setString(SharedKeys.email, typeUser.userEmail);
      preferences.setString(SharedKeys.userType, typeUser.typeString);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<bool> signed() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String? uid = preferences.getString(SharedKeys.uid);
      if (uid != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> clearData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove(SharedKeys.uid);
      await preferences.remove(SharedKeys.email);
      await preferences.remove(SharedKeys.userType);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<TypeUser> getUser() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String uid = preferences.getString(SharedKeys.uid) ?? "";
      final String email = preferences.getString(SharedKeys.email) ?? "";
      final String userType = preferences.getString(SharedKeys.userType) ?? "";

      if (uid.isEmpty) {
        throw "Empty UID!";
      }
      if (email.isEmpty) {
        throw "Empty email!";
      }
      if (userType.isEmpty) {
        throw "Empty userType!";
      }

      return TypeUser(
        userId: uid,
        userEmail: email,
        userType: stringToType(userType),
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
