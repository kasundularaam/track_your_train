part of 'train_details_cubit.dart';

@immutable
abstract class TrainDetailsState {}

class TrainDetailsInitial extends TrainDetailsState {}

class TrainDetailsLoading extends TrainDetailsState {}

class TrainDetailsLoaded extends TrainDetailsState {
  final TrainDetails trainDetails;
  TrainDetailsLoaded({
    required this.trainDetails,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrainDetailsLoaded && other.trainDetails == trainDetails;
  }

  @override
  int get hashCode => trainDetails.hashCode;

  @override
  String toString() => 'TrainDetailsLoaded(trainDetails: $trainDetails)';
}

class TrainDetailsFailed extends TrainDetailsState {
  final String errorMsg;
  TrainDetailsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrainDetailsFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'TrainDetailsFailed(errorMsg: $errorMsg)';
}
