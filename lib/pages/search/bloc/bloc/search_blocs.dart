import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/search/bloc/bloc/search_events.dart';
import 'package:travelguide/pages/search/bloc/bloc/search_states.dart';

class SearchBlocs extends Bloc<SearchEvents, SearchStates>{
  SearchBlocs() : super(const SearchStates()) {
    on<SearchTextEvent>((event, emit) {
      emit(state.copyWith(searchText: event.searchText));
    });

    on<SelectCategoriesEvent>((event, emit) {
      emit(state.copyWith(selectedCategories: event.selectedCategories));
    });

    on<SearchResultsEvent>((event, emit) {
      emit(state.copyWith(searchResults: event.searchResults));
    });

  }
}