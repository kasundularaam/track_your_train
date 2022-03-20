import 'dart:async';

import 'package:location/location.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:track_your_train/data/models/train_location.dart';

import '../../core/uses_permission/location_services.dart';
import '../data_providers/data_provider.dart';

class DriverSocket {
  final String trainId;
  final String trainName;
  DriverSocket({
    required this.trainId,
    required this.trainName,
  });
  IO.Socket socket = IO.io(socketAddress, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });
  final StreamController<TrainLocation> socketResponse =
      StreamController<TrainLocation>();

  void addResponse({required TrainLocation trainLocation}) =>
      socketResponse.sink.add(trainLocation);

  Stream<TrainLocation> getResponse() => socketResponse.stream;

  Stream<TrainLocation> sendLocation() async* {
    socket.connect();
    LocationServices.locationStream.listen(
      (LocationData currentLocation) {
        addResponse(
          trainLocation: TrainLocation(
              trainId: trainId,
              trainName: trainName,
              latitude: currentLocation.latitude!,
              longitude: currentLocation.longitude!),
        );
        TrainLocation trainLocation = TrainLocation(
            trainId: trainId,
            trainName: trainName,
            latitude: currentLocation.latitude!,
            longitude: currentLocation.longitude!);
        socket.emit(
          "driver",
          trainLocation.toMap(),
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
