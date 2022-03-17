import 'dart:convert';

class TrainLocation {
  final String trainId;
  final String trainName;
  final double latitude;
  final double longitude;
  TrainLocation({
    required this.trainId,
    required this.trainName,
    required this.latitude,
    required this.longitude,
  });

  TrainLocation copyWith({
    String? trainId,
    String? trainName,
    double? latitude,
    double? longitude,
  }) {
    return TrainLocation(
      trainId: trainId ?? this.trainId,
      trainName: trainName ?? this.trainName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'trainId': trainId,
      'trainName': trainName,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory TrainLocation.fromMap(Map<String, dynamic> map) {
    return TrainLocation(
      trainId: map['trainId'] ?? '',
      trainName: map['trainName'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainLocation.fromJson(String source) =>
      TrainLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TrainLocation(trainId: $trainId, trainName: $trainName, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrainLocation &&
        other.trainId == trainId &&
        other.trainName == trainName &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return trainId.hashCode ^
        trainName.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
