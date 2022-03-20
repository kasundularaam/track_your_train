import 'dart:convert';

import 'package:track_your_train/data/models/train_details.dart';

import '../models/station.dart';

class HttpListConverter {
  static List<Station> parseStations(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Station>(
          (json) => Station.fromMap(json),
        )
        .toList();
  }

  static List<TrainDetails> parseTrains(String responseBody) {
    List<TrainDetails> list = [];
    List<Map<String, dynamic>> parsed =
        json.decode(responseBody).cast<Map<String, dynamic>>();

    for (var item in parsed) {
      if (item.length >= 10) {
        list.add(TrainDetails.fromMap(item));
      }
    }
    return list;
  }
}
