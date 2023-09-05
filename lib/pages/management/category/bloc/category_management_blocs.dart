import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_management_events.dart';
import 'category_management_states.dart';

class CategoryManagementBlocs extends Bloc<CategoryManagementEvents, CategoryManagementStates>{

  CategoryManagementBlocs():super(const CategoryManagementStates()){

    on<CategoryNameEvent>((event, emit){
      emit(state.copyWith(categoryName: event.categoryName));
    });

    on<CategoryResultsEvent>((event, emit){
      emit(state.copyWith(categoryResults: event.categoryResults));
    });

  }

}