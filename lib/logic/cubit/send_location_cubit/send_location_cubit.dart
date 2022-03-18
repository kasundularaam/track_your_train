import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

import '../../../core/uses_permission/location_services.dart';
import '../../../data/firebase/fire_auth.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/train_location.dart';
import '../../../data/socket/driver_socket.dart';
import '../../../data/socket/user_socket.dart';
import '../../../presentation/screens/user/user_screen/widgets/marker_view.dart';

part 'send_location_state.dart';

class SendLocationCubit extends Cubit<SendLocationState> {
  SendLocationCubit() : super(SendLocationInitial());

  UserSocket userSocket = UserSocket();
  DriverSocket? driverSocket;
  List<Marker> markers = [];
  List<String> trainIds = [];

  Future<void> sendLocation() async {
    try {
      bool isPermissionAllowed = await LocationServices.isPermissionAllowed();

      if (isPermissionAllowed) {
        AppUser appUser = await FireAuth.getUserData();
        print(appUser);
        driverSocket =
            DriverSocket(trainId: appUser.trainId, trainName: appUser.userName);
        driverSocket!.sendLocation().listen((trainLocation) {
          emit(
            SendLocationSending(trainLocation: trainLocation, markers: markers),
          );
        });
        loadAllTrains();
      } else {
        emit(
          SendLocationFailed(
            errorMsg: "Location Permission denied",
          ),
        );
      }
    } catch (e) {
      emit(
        SendLocationFailed(
          errorMsg: e.toString(),
        ),
      );
    }
  }

  void loadAllTrains() {
    userSocket.getLocation().listen((trainLocation) {
      if (!trainIds.contains(trainLocation.trainId)) {
        Marker marker = Marker(
          width: 200,
          height: 200,
          point: latLng.LatLng(trainLocation.latitude, trainLocation.longitude),
          builder: (context) => MarkerView(trainLocation: trainLocation),
        );
        trainIds.add(trainLocation.trainId);
        markers.add(marker);
      }
      if (trainIds.contains(trainLocation.trainId)) {
        Marker marker = Marker(
          width: 200,
          height: 200,
          point: latLng.LatLng(trainLocation.latitude, trainLocation.longitude),
          builder: (context) => MarkerView(trainLocation: trainLocation),
        );
        final index = trainIds.indexOf(trainLocation.trainId);
        markers[index] = marker;
      }
    });
  }

  void dispose() => driverSocket!.dispose();
}
