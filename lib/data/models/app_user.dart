import 'dart:convert';

import 'package:track_your_train/data/converters/user_type_converter.dart';

import '../../core/enums/user_type.dart';

class AppUser {
  final String userId;
  final String userName;
  final String userEmail;
  final UserType userType;
  AppUser({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userType,
  });

  AppUser copyWith({
    String? userId,
    String? userName,
    String? userEmail,
    UserType? userType,
  }) {
    return AppUser(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userType: userType ?? this.userType,
    );
  }

  String get typeString => typeToString(userType);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userType': typeString,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userType: stringToType(map['userType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(userId: $userId, userName: $userName, userEmail: $userEmail, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.userId == userId &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        userEmail.hashCode ^
        userType.hashCode;
  }
}
