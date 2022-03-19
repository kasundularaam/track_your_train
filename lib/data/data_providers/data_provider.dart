// Dummy file

class DataProvider {
  static String trainSearchUrl({required String start, required String end}) =>
      "$serverAddress/user/trains?start=$start&end=$end";

  static String stationsUrl() => "$serverAddress/user/stations";
  static String trainDetails({required String trainId}) =>
      "$serverAddress/user/trains?id=$trainId";
}

const String serverAddress = "http://35.154.29.42:8000";
