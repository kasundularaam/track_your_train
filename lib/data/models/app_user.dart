import 'dart:convert';

class AppUser {
  final String email;
  final bool isDriver;
  AppUser({
    required this.email,
    required this.isDriver,
  });

  AppUser copyWith({
    String? email,
    bool? isDriver,
  }) {
    return AppUser(
      email: email ?? this.email,
      isDriver: isDriver ?? this.isDriver,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'isDriver': isDriver,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'] ?? '',
      isDriver: map['isDriver'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() => 'AppUser(email: $email, isDriver: $isDriver)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.email == email &&
        other.isDriver == isDriver;
  }

  @override
  int get hashCode => email.hashCode ^ isDriver.hashCode;
}
