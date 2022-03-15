import 'dart:async';

import 'package:location/location.dart';

import '../../core/uses_permission/location_services.dart';
import '../data_providers/data_provider.dart';
import '../models/lat_long.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverSocket {
  IO.Socket socket = IO.io(serverAddress, <String, dynamic>{
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
