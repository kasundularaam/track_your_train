import 'dart:io';

import '../../core/exceptions/route_exception.dart';
import '../converters/http_list_converter.dart';
import '../data_providers/data_provider.dart';

import 'package:http/http.dart' as http;

import '../models/station.dart';
import '../models/train_details.dart';

class HTTPServices {
  static Future<List<Station>> getStations() async {
    try {
      final response = await http.get(
        Uri.parse(
          DataProvider.stationsUrl(),
        ),
      );
      if (response.statusCode == 200) {
        return HttpListConverter.parseStations(response.body);
      } else {
        throw Failure(message: '${response.statusCode}');
      }
    } on SocketException {
      throw Failure(message: "No connection!");
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  static Future<List<TrainDetails>> getTrainDetails(
      {required String start, required String end}) async {
    try {
      final response = await http.get(
        Uri.parse(
          DataProvider.trainSearchUrl(start: start, end: end),
        ),
      );
      if (response.statusCode == 200) {
        return HttpListConverter.parseTrains(response.body);
      } else {
        throw Failure(message: '${response.statusCode}');
      }
    } on SocketException {
      throw Failure(message: "No connection!");
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
