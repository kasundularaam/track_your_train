import 'dart:convert';

import '../../core/enums/user_type.dart';

class TypeUser {
  final String email;
  final String uid;
  final UserType userType;
  TypeUser({
    required this.email,
    required this.uid,
    required this.userType,
  });

  TypeUser copyWith({
    String? email,
    String? uid,
    UserType? userType,
  }) {
    return TypeUser(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      userType: userType ?? this.userType,
    );
  }

  String get typeToString {
    if (userType == UserType.user) {
      return "user";
    }
    if (userType == UserType.driver) {
      return "driver";
    }

    return "ticketChecker";
  }

  static UserType stringToType(String typeString) {
    if (typeString == "user") {
      return UserType.user;
    }
    if (typeString == "driver") {
      return UserType.user;
    }
    return UserType.ticketChecker;
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'userType': typeToString,
    };
  }

  factory TypeUser.fromMap(Map<String, dynamic> map) {
    return TypeUser(
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      userType: stringToType(map['userType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeUser.fromJson(String source) =>
      TypeUser.fromMap(json.decode(source));

  @override
  String toString() =>
      'TypeUser(email: $email, uid: $uid, userType: $userType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TypeUser &&
        other.email == email &&
        other.uid == uid &&
        other.userType == userType;
  }

  @override
  int get hashCode => email.hashCode ^ uid.hashCode ^ userType.hashCode;
}
