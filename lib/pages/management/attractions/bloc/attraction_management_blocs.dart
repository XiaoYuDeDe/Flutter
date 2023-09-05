import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/management/attractions/bloc/attraction_management_events.dart';
import 'attraction_management_states.dart';

class AttractionManagementBlocs extends Bloc<AttractionManagementEvents, AttractionManagementStates>{

  AttractionManagementBlocs():super(const AttractionManagementStates()){

    on<AttractionResultsEvent>((event, emit){
      emit(state.copyWith(attractionResults: event.attractionResults));
    });

  }

}