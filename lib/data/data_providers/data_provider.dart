class DataProvider {
  static String trainSearchUrl({required String start, required String end}) =>
      "$endPointAddress/user/trains?start=$start&end=$end";

  static String stationsUrl() => "$endPointAddress/user/stations";
  static String trainDetails({required String trainId}) =>
      "$endPointAddress/user/trains?id=$trainId";
}

const String endPointAddress = "http://3.108.41.163:8001";

const String socketAddress = "http://3.108.41.163:3000";
