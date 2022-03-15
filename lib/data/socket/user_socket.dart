import 'dart:async';

import '../data_providers/data_provider.dart';
import '../models/lat_long.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserSocket {
  IO.Socket socket = IO.io(serverAddress, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });

  final socketResponse = StreamController<LatLong>();

  void addResponse({required LatLong latLong}) =>
      socketResponse.sink.add(latLong);

  Stream<LatLong> getResponse() => socketResponse.stream;

  void dispose() {
    socket.dispose();
    socketResponse.close();
  }

  Stream<LatLong> getLocation() async* {
    socket.connect();
    socket.on('user', (data) {
      LatLong latLong = LatLong(lat: data["lat"], long: data["long"]);
      addResponse(latLong: latLong);
    });
    yield* getResponse();
  }
}
