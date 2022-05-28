import 'dart:convert';

class Booking {
  final String id;
  final String uid;
  final String userNic;
  final String userName;
  final String userEmail;
  final String userPhone;
  final int ticketCount;
  final String trainId;
  final int timeStamp;
  final String trainNumber;
  final bool checked;
  Booking({
    required this.id,
    required this.uid,
    required this.userNic,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.ticketCount,
    required this.trainId,
    required this.timeStamp,
    required this.trainNumber,
    required this.checked,
  });

  Booking copyWith({
    String? id,
    String? uid,
    String? userNic,
    String? userName,
    String? userEmail,
    String? userPhone,
    int? ticketCount,
    String? trainId,
    int? timeStamp,
    String? trainNumber,
    bool? checked,
  }) {
    return Booking(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      userNic: userNic ?? this.userNic,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      ticketCount: ticketCount ?? this.ticketCount,
      trainId: trainId ?? this.trainId,
      timeStamp: timeStamp ?? this.timeStamp,
      trainNumber: trainNumber ?? this.trainNumber,
      checked: checked ?? this.checked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'userNic': userNic,
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'ticketCount': ticketCount,
      'trainId': trainId,
      'timeStamp': timeStamp,
      'trainNumber': trainNumber,
      'checked': checked,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      userNic: map['userNic'] ?? '',
      userName: map['userName'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userPhone: map['userPhone'] ?? '',
      ticketCount: map['ticketCount']?.toInt() ?? 0,
      trainId: map['trainId'] ?? '',
      timeStamp: map['timeStamp']?.toInt() ?? 0,
      trainNumber: map['trainNumber'] ?? '',
      checked: map['checked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Booking(id: $id, uid: $uid, userNic: $userNic, userName: $userName, userEmail: $userEmail, userPhone: $userPhone, ticketCount: $ticketCount, trainId: $trainId, timeStamp: $timeStamp, trainNumber: $trainNumber, checked: $checked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Booking &&
        other.id == id &&
        other.uid == uid &&
        other.userNic == userNic &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.userPhone == userPhone &&
        other.ticketCount == ticketCount &&
        other.trainId == trainId &&
        other.timeStamp == timeStamp &&
        other.trainNumber == trainNumber &&
        other.checked == checked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        userNic.hashCode ^
        userName.hashCode ^
        userEmail.hashCode ^
        userPhone.hashCode ^
        ticketCount.hashCode ^
        trainId.hashCode ^
        timeStamp.hashCode ^
        trainNumber.hashCode ^
        checked.hashCode;
  }
}
