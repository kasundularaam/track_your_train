import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track_your_train/data/models/app_user.dart';

import '../models/type_user.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static CollectionReference usersRef =
      FirebaseFirestore.instance.collection("users");

  static User get currentUser {
    User? user = auth.currentUser;
    if (user != null) {
      return user;
    } else {
      throw "No user available!";
    }
  }

  static String get uid => currentUser.uid;

  static bool get signed {
    User? user = auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<User> registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user!;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<User> signInUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user!;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> addNewUser({required AppUser appUser}) async {
    try {
      await usersRef.doc(appUser.userId).set(appUser.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<TypeUser> getTypeUser({required String uid}) async {
    try {
      DocumentSnapshot snapshot = await usersRef.doc(uid).get();
      Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
      return TypeUser.fromMap(map);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<AppUser> getUserData() async {
    try {
      DocumentSnapshot snapshot = await usersRef.doc(uid).get();
      Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
      return AppUser.fromMap(map);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> signOut() async {
    try {
      auth.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
