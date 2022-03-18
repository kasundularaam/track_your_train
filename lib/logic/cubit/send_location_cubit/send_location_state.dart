part of 'send_location_cubit.dart';

@immutable
abstract class SendLocationState {}

class SendLocationInitial extends SendLocationState {}

class SendLocationSending extends SendLocationState {
  final TrainLocation trainLocation;
  final List<Marker> markers;
  SendLocationSending({
    required this.trainLocation,
    required this.markers,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendLocationSending &&
        other.trainLocation == trainLocation &&
        listEquals(other.markers, markers);
  }

  @override
  int get hashCode => trainLocation.hashCode ^ markers.hashCode;

  @override
  String toString() =>
      'SendLocationSending(trainLocation: $trainLocation, markers: $markers)';
}

class SendLocationFailed extends SendLocationState {
  final String errorMsg;
  SendLocationFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendLocationFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SendLocationFailed(errorMsg: $errorMsg)';
}
