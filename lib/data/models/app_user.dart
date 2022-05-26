import 'dart:convert';

import '../../core/enums/user_type.dart';
import '../converters/user_type_converter.dart';

class AppUser {
  final String userId;
  final String userName;
  final String userEmail;
  final UserType userType;
  final String trainId;
  AppUser({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userType,
    required this.trainId,
  });

  AppUser copyWith({
    String? userId,
    String? userName,
    String? userEmail,
    UserType? userType,
    String? trainId,
  }) {
    return AppUser(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userType: userType ?? this.userType,
      trainId: trainId ?? this.trainId,
    );
  }

  String get typeString => typeToString(userType);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userType': typeString,
      'trainId': trainId,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userType: stringToType(map['userType']),
      trainId: map['trainId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(userId: $userId, userName: $userName, userEmail: $userEmail, userType: $userType, trainId: $trainId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.userId == userId &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.userType == userType &&
        other.trainId == trainId;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        userEmail.hashCode ^
        userType.hashCode ^
        trainId.hashCode;
  }
}
