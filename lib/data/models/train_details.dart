import 'dart:convert';

import 'package:flutter/foundation.dart';

class TrainDetails {
  final String titleText;
  final String startStation;
  final String departureTime;
  final String endStation;
  final String trainType;
  final String trainName;
  final String trainNumber;
  final String runby;
  final List<String> availableClasses;
  final String directtrain;
  TrainDetails({
    required this.titleText,
    required this.startStation,
    required this.departureTime,
    required this.endStation,
    required this.trainType,
    required this.trainName,
    required this.trainNumber,
    required this.runby,
    required this.availableClasses,
    required this.directtrain,
  });

  TrainDetails copyWith({
    String? titleText,
    String? startStation,
    String? departureTime,
    String? endStation,
    String? trainType,
    String? trainName,
    String? trainNumber,
    String? runby,
    List<String>? availableClasses,
    String? directtrain,
  }) {
    return TrainDetails(
      titleText: titleText ?? this.titleText,
      startStation: startStation ?? this.startStation,
      departureTime: departureTime ?? this.departureTime,
      endStation: endStation ?? this.endStation,
      trainType: trainType ?? this.trainType,
      trainName: trainName ?? this.trainName,
      trainNumber: trainNumber ?? this.trainNumber,
      runby: runby ?? this.runby,
      availableClasses: availableClasses ?? this.availableClasses,
      directtrain: directtrain ?? this.directtrain,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titleText': titleText,
      'startStation': startStation,
      'departureTime': departureTime,
      'endStation': endStation,
      'trainType': trainType,
      'trainName': trainName,
      'trainNumber': trainNumber,
      'runby': runby,
      'availableClasses': availableClasses,
      'directtrain': directtrain,
    };
  }

  factory TrainDetails.fromMap(Map<String, dynamic> map) {
    return TrainDetails(
      titleText: map['titleText'] ?? '',
      startStation: map['startStation'] ?? '',
      departureTime: map['departureTime'] ?? '',
      endStation: map['endStation'] ?? '',
      trainType: map['trainType'] ?? '',
      trainName: map['trainName'] ?? '',
      trainNumber: map['trainNumber'] ?? '',
      runby: map['runby'] ?? '',
      availableClasses: List<String>.from(map['availableClasses']),
      directtrain: map['directtrain'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainDetails.fromJson(String source) =>
      TrainDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TrainDetails(titleText: $titleText, startStation: $startStation, departureTime: $departureTime, endStation: $endStation, trainType: $trainType, trainName: $trainName, trainNumber: $trainNumber, runby: $runby, availableClasses: $availableClasses, directtrain: $directtrain)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrainDetails &&
        other.titleText == titleText &&
        other.startStation == startStation &&
        other.departureTime == departureTime &&
        other.endStation == endStation &&
        other.trainType == trainType &&
        other.trainName == trainName &&
        other.trainNumber == trainNumber &&
        other.runby == runby &&
        listEquals(other.availableClasses, availableClasses) &&
        other.directtrain == directtrain;
  }

  @override
  int get hashCode {
    return titleText.hashCode ^
        startStation.hashCode ^
        departureTime.hashCode ^
        endStation.hashCode ^
        trainType.hashCode ^
        trainName.hashCode ^
        trainNumber.hashCode ^
        runby.hashCode ^
        availableClasses.hashCode ^
        directtrain.hashCode;
  }
}
