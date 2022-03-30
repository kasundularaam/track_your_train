import 'dart:convert';

class Booking {
  final String userNic;
  final String userName;
  final String userEmail;
  final String userPhone;
  final int ticketCount;
  final String trainId;
  Booking({
    required this.userNic,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.ticketCount,
    required this.trainId,
  });

  Booking copyWith({
    String? userNic,
    String? userName,
    String? userEmail,
    String? userPhone,
    int? ticketCount,
    String? trainId,
  }) {
    return Booking(
      userNic: userNic ?? this.userNic,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      ticketCount: ticketCount ?? this.ticketCount,
      trainId: trainId ?? this.trainId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userNic': userNic,
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'ticketCount': ticketCount,
      'trainId': trainId,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      userNic: map['userNic'] ?? '',
      userName: map['userName'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userPhone: map['userPhone'] ?? '',
      ticketCount: map['ticketCount']?.toInt() ?? 0,
      trainId: map['trainId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Booking(userNic: $userNic, userName: $userName, userEmail: $userEmail, userPhone: $userPhone, ticketCount: $ticketCount, trainId: $trainId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Booking &&
        other.userNic == userNic &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.userPhone == userPhone &&
        other.ticketCount == ticketCount &&
        other.trainId == trainId;
  }

  @override
  int get hashCode {
    return userNic.hashCode ^
        userName.hashCode ^
        userEmail.hashCode ^
        userPhone.hashCode ^
        ticketCount.hashCode ^
        trainId.hashCode;
  }
}
