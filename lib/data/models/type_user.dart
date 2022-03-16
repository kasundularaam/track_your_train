import 'dart:convert';

import '../../core/enums/user_type.dart';
import '../converters/user_type_converter.dart';

class TypeUser {
  final String userId;
  final String userEmail;
  final UserType userType;
  TypeUser({
    required this.userId,
    required this.userEmail,
    required this.userType,
  });

  TypeUser copyWith({
    String? userId,
    String? userEmail,
    UserType? userType,
  }) {
    return TypeUser(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      userType: userType ?? this.userType,
    );
  }

  String get typeString => typeToString(userType);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userType': typeString,
    };
  }

  factory TypeUser.fromMap(Map<String, dynamic> map) {
    return TypeUser(
      userId: map['userId'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userType: stringToType(map['userType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeUser.fromJson(String source) =>
      TypeUser.fromMap(json.decode(source));

  @override
  String toString() =>
      'TypeUser(userId: $userId, userEmail: $userEmail, userType: $userType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TypeUser &&
        other.userId == userId &&
        other.userEmail == userEmail &&
        other.userType == userType;
  }

  @override
  int get hashCode => userId.hashCode ^ userEmail.hashCode ^ userType.hashCode;
}
