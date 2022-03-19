import 'package:track_your_train/data/models/station.dart';

class SearchSuggestions {
  List<Station> _suggestions = [];

  set setSuggestions(List<Station> stationsList) {
    _suggestions = stationsList;
  }

  List<Station> get stations => _suggestions;

  List<Station> searchStation({required String searchText}) {
    List<Station> searchResults = [];
    if (searchText.isNotEmpty) {
      for (Station station in _suggestions) {
        if (station.name.toLowerCase().contains(searchText.toLowerCase())) {
          searchResults.add(station);
        }
      }
    } else {
      searchResults.clear();
    }
    return searchResults;
  }
}
