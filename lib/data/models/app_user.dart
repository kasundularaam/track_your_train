import 'dart:convert';

class AppUser {
  final String email;
  final bool isUser;
  AppUser({
    required this.email,
    required this.isUser,
  });

  AppUser copyWith({
    String? email,
    bool? isUser,
  }) {
    return AppUser(
      email: email ?? this.email,
      isUser: isUser ?? this.isUser,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'isUser': isUser,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'] ?? '',
      isUser: map['isUser'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() => 'AppUser(email: $email, isUser: $isUser)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser && other.email == email && other.isUser == isUser;
  }

  @override
  int get hashCode => email.hashCode ^ isUser.hashCode;
}
