part of 'tracking_map_cubit.dart';

@immutable
abstract class TrackingMapState {}

class TrackingMapInitial extends TrackingMapState {}

class TrackingMapLoading extends TrackingMapState {}

class TrackingMapTracking extends TrackingMapState {
  final TrainLocation trainLocation;
  final Marker marker;
  TrackingMapTracking({
    required this.trainLocation,
    required this.marker,
  });
}

class TrackingMapFailed extends TrackingMapState {
  final String errorMsg;
  TrackingMapFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrackingMapFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'TrackingMapFailed(errorMsg: $errorMsg)';
}
