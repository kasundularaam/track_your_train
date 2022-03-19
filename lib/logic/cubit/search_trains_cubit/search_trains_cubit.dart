import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:track_your_train/data/http/http_services.dart';
import 'package:track_your_train/data/http/search_trains/search_suggestions.dart';
import 'package:track_your_train/data/models/station.dart';
import 'package:track_your_train/data/models/train_details.dart';

part 'search_trains_state.dart';

class SearchTrainsCubit extends Cubit<SearchTrainsState> {
  SearchTrainsCubit() : super(SearchTrainsInitial());

  SearchSuggestions searchSuggestions = SearchSuggestions();

  Future<void> loadSearchSuggestions() async {
    try {
      emit(SearchTrainsLoading());
      List<Station> stations = await HTTPServices.getStations();
      searchSuggestions.setSuggestions = stations;
      emit(SearchTrainsInitial());
    } catch (e) {
      emit(SearchTrainsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> showSuggestions(
      {required String searchText, required bool isStart}) async {
    try {
      emit(SearchTrainsLoading());
      List<Station> result =
          searchSuggestions.searchStation(searchText: searchText);
      emit(SearchTrainsSuggestions(stations: result, isStart: isStart));
    } catch (e) {
      emit(SearchTrainsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> showResults({required String start, required String end}) async {
    try {
      emit(SearchTrainsLoading());
      List<TrainDetails> results =
          await HTTPServices.getTrainDetails(start: start, end: end);
      print(results);
      if (results.isNotEmpty) {
        emit(SearchTrainsResults(trainDetailsList: results));
      } else {
        emit(SearchTrainsNoResults());
      }
    } catch (e) {
      emit(SearchTrainsFailed(errorMsg: e.toString()));
    }
  }
}
