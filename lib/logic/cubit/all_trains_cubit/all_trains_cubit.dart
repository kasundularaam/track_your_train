import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:track_your_train/presentation/screens/user/user_screen/widgets/marker_view.dart';

import '../../../data/socket/user_socket.dart';

part 'all_trains_state.dart';

class AllTrainsCubit extends Cubit<AllTrainsState> {
  AllTrainsCubit() : super(AllTrainsInitial());

  UserSocket userSocket = UserSocket();
  List<Marker> markers = [];
  List<String> trainIds = [];

  Future<void> loadTrains() async {
    try {
      emit(AllTrainsLoading());

      userSocket.getLocation().listen((trainLocation) {
        if (!trainIds.contains(trainLocation.trainId)) {
          Marker marker = Marker(
            width: 200,
            height: 200,
            point:
                latLng.LatLng(trainLocation.latitude, trainLocation.longitude),
            builder: (context) => MarkerView(trainLocation: trainLocation),
          );
          trainIds.add(trainLocation.trainId);
          markers.add(marker);
        }
        if (trainIds.contains(trainLocation.trainId)) {
          Marker marker = Marker(
            width: 200,
            height: 200,
            point:
                latLng.LatLng(trainLocation.latitude, trainLocation.longitude),
            builder: (context) => MarkerView(trainLocation: trainLocation),
          );
          final index = trainIds.indexOf(trainLocation.trainId);
          markers[index] = marker;
        }
        emit(AllTrainsLoaded(markers: markers));
      });
    } catch (e) {
      emit(AllTrainsFailed(errorMsg: e.toString()));
    }
  }

  void dispose() => userSocket.dispose();
}
