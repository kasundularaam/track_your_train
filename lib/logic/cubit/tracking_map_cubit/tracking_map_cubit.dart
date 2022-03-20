import 'package:bloc/bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:meta/meta.dart';
import "package:latlong2/latlong.dart" as latLng;
import '../../../data/models/train_location.dart';
import '../../../data/socket/user_socket.dart';
import '../../../presentation/screens/user/user_screen/widgets/marker_view.dart';

part 'tracking_map_state.dart';

class TrackingMapCubit extends Cubit<TrackingMapState> {
  TrackingMapCubit() : super(TrackingMapInitial());

  UserSocket userSocket = UserSocket();

  Future<void> trackTrain({required String trainId}) async {
    try {
      emit(TrackingMapLoading());

      userSocket.getLocation().listen((trainLocation) {
        if (trainLocation.trainId == trainId) {
          Marker marker = Marker(
            width: 200,
            height: 200,
            point:
                latLng.LatLng(trainLocation.latitude, trainLocation.longitude),
            builder: (context) => MarkerView(trainLocation: trainLocation),
          );
          emit(TrackingMapTracking(
              trainLocation: trainLocation, marker: marker));
        }
      });
    } catch (e) {
      emit(TrackingMapFailed(errorMsg: e.toString()));
    }
  }
}
