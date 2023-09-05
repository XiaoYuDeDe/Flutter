import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_attraction_events.dart';
import 'add_attraction_states.dart';

class AddAttractionBlocs extends Bloc<AddAttractionEvents, AddAttractionStates>{

  AddAttractionBlocs():super(AddAttractionStates()){

    on<AttractionIdEvent>((event, emit){
      emit(state.copyLastObject(attractionId: event.attractionId));
    });

    on<NameEvent>((event, emit){
      emit(state.copyLastObject(name: event.name));
    });

    on<CityEvent>((event, emit){
      emit(state.copyLastObject(city: event.city));
    });

    on<CategoryIdEvent>((event, emit){
      emit(state.copyLastObject(categoryId: event.categoryId));
    });

    on<DescriptionEvent>((event, emit){
      emit(state.copyLastObject(description: event.description));
    });

    on<AverageRatingEvent>((event, emit){
      emit(state.copyLastObject(averageRating: event.averageRating));
    });

    on<ImageUrlEvent>((event, emit){
      emit(state.copyLastObject(imageUrl: event.imageUrl));
    });

    on<CategoryResultsEvent>((event, emit){
      emit(state.copyLastObject(categoryResults: event.categoryResults));
    });

    on<SelectedImageEvent>((event, emit){
      emit(state.copyLastObject(selectedImage: event.selectedImage));
    });

  }

}