import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_your_train/core/uses_permission/location_services.dart';
import 'package:track_your_train/data/socket/driver_socket.dart';

import '../../../data/models/lat_long.dart';

part 'send_location_state.dart';

class SendLocationCubit extends Cubit<SendLocationState> {
  SendLocationCubit() : super(SendLocationInitial());

  DriverSocket driverSocket = DriverSocket();

  Future<void> sendLocation() async {
    try {
      bool isPermissionAllowed = await LocationServices.isPermissionAllowed();

      if (isPermissionAllowed) {
        driverSocket.sendLocation().listen((latLong) {
          emit(
            SendLocationSending(
              latLong: latLong,
            ),
          );
        });
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

  void dispose() => driverSocket.dispose();
}
