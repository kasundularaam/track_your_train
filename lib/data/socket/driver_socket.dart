import 'dart:async';

import 'package:location/location.dart';
import 'package:track_your_train/core/uses_permission/location_services.dart';

import '../models/lat_long.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverSocket {
  IO.Socket socket = IO.io('http://192.168.8.100:3000', <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });
  final StreamController<LatLong> socketResponse = StreamController<LatLong>();

  void addResponse({required LatLong latLong}) =>
      socketResponse.sink.add(latLong);

  Stream<LatLong> getResponse() => socketResponse.stream;

  Stream<LatLong> sendLocation() async* {
    socket.connect();
    LocationServices.locationStream.listen(
      (LocationData currentLocation) {
        print(currentLocation.latitude);
        addResponse(
          latLong: LatLong(
            lat: currentLocation.latitude!,
            long: currentLocation.longitude!,
          ),
        );
        socket.emit(
          "driver",
          {"lat": currentLocation.latitude, "long": currentLocation.longitude},
        );
      },
    );
    yield* getResponse();
  }

  void dispose() {
    socket.dispose();
    socketResponse.close();
  }
}
