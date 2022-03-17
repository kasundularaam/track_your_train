part of 'all_trains_cubit.dart';

@immutable
abstract class AllTrainsState {}

class AllTrainsInitial extends AllTrainsState {}

class AllTrainsLoading extends AllTrainsState {}

class AllTrainsLoaded extends AllTrainsState {
  final List<Marker> markers;
  AllTrainsLoaded({
    required this.markers,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllTrainsLoaded && listEquals(other.markers, markers);
  }

  @override
  int get hashCode => markers.hashCode;

  @override
  String toString() => 'AllTrainsLoaded(markers: $markers)';
}

class AllTrainsFailed extends AllTrainsState {
  final String errorMsg;
  AllTrainsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllTrainsFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'AllTrainsFailed(errorMsg: $errorMsg)';
}
