import '../../../../entities/attraction.dart';

abstract class SearchEvents{
  const SearchEvents();
}

class SearchTextEvent extends SearchEvents{
  final String searchText;
  const SearchTextEvent(this.searchText);
}

class SelectCategoriesEvent extends SearchEvents{
  final List<String> selectedCategories;
  const SelectCategoriesEvent(this.selectedCategories);
}

class SearchResultsEvent extends SearchEvents{
  final List<Attraction> searchResults;
  const SearchResultsEvent(this.searchResults);
}
