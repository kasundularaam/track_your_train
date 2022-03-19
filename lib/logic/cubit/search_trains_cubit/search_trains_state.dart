part of 'search_trains_cubit.dart';

@immutable
abstract class SearchTrainsState {}

class SearchTrainsInitial extends SearchTrainsState {}

class SearchTrainsLoading extends SearchTrainsState {}

class SearchTrainsSuggestions extends SearchTrainsState {
  final List<Station> stations;
  final bool isStart;
  SearchTrainsSuggestions({
    required this.stations,
    required this.isStart,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchTrainsSuggestions &&
        listEquals(other.stations, stations) &&
        other.isStart == isStart;
  }

  @override
  int get hashCode => stations.hashCode ^ isStart.hashCode;

  @override
  String toString() =>
      'SearchTrainsSuggestions(stations: $stations, isStart: $isStart)';
}

class SearchTrainsResults extends SearchTrainsState {
  final List<TrainDetails> trainDetailsList;
  SearchTrainsResults({
    required this.trainDetailsList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchTrainsResults &&
        listEquals(other.trainDetailsList, trainDetailsList);
  }

  @override
  int get hashCode => trainDetailsList.hashCode;

  @override
  String toString() =>
      'SearchTrainsResults(trainDetailsList: $trainDetailsList)';
}

class SearchTrainsNoResults extends SearchTrainsState {}

class SearchTrainsFailed extends SearchTrainsState {
  final String errorMsg;
  SearchTrainsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchTrainsFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SearchTrainsFailed(errorMsg: $errorMsg)';
}
