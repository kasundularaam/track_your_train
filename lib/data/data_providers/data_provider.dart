class DataProvider {
  static String trainSearchUrl({required String start, required String end}) =>
      "$url/user/trains?start=$start&end=$end";

  static String stationsUrl() => "$url/user/stations";
  static String trainDetails({required String trainId}) =>
      "$url/user/trains?id=$trainId";
}

const String url =
    "http://ec2-13-233-184-58.ap-south-1.compute.amazonaws.com:8001";

const String socketAddress =
    "http://ec2-13-233-184-58.ap-south-1.compute.amazonaws.com:3000";
