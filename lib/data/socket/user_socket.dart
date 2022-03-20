import 'dart:async';

import 'package:track_your_train/data/models/train_location.dart';

import '../data_providers/data_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserSocket {
  IO.Socket socket = IO.io(socketAddress, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });

  final socketResponse = StreamController<TrainLocation>();

  void addResponse({required TrainLocation trainLocation}) =>
      socketResponse.sink.add(trainLocation);

  Stream<TrainLocation> getResponse() => socketResponse.stream;

  void dispose() {
    socket.dispose();
    socketResponse.close();
  }

  Stream<TrainLocation> getLocation() async* {
    socket.connect();
    socket.on('user', (data) {
      TrainLocation trainLocation = TrainLocation.fromMap(data);
      addResponse(trainLocation: trainLocation);
    });
    yield* getResponse();
  }
}
