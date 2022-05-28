import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class FireTrain {
  static CollectionReference usersRef =
      FirebaseFirestore.instance.collection("users");

  static Future<AppUser> getUserData({required String trainNumber}) async {
    try {
      QuerySnapshot snapshot =
          await usersRef.where("trainId", isEqualTo: trainNumber).get();
      List<AppUser> users = snapshot.docs
          .map(
            (doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>),
          )
          .toList();
      if (users.isNotEmpty) {
        return users.first;
      } else {
        throw "Train not found";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
