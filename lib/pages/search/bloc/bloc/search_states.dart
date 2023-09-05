import '../../../../entities/attraction.dart';

class SearchStates{
  final String searchText;
  final List<String> selectedCategories;
  final List<Attraction> searchResults;


  const SearchStates({this.searchText = "", this.selectedCategories = const[], this.searchResults = const[]});

  SearchStates copyWith({String? searchText, List<String>? selectedCategories, List<Attraction>? searchResults}) {
    return SearchStates(
      searchText: searchText ?? this.searchText,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      searchResults: searchResults ?? this.searchResults
    );
  }
}
