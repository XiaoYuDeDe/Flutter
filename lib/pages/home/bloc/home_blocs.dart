import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/home/bloc/home_events.dart';
import 'package:travelguide/pages/home/bloc/home_states.dart';

class HomeBlocs extends Bloc<HomeEvents, HomeStates>{
  HomeBlocs():super(const HomeStates()){
    on<HomeDotEvents>((event, emit){
      emit(state.copyWith(index: event.index));
    });

    on<BtnSelectedNameEvents>((event, emit){
      emit(state.copyWith(btnSelectedName: event.btnSelectedName));
    });

    on<TopAttractionsEvents>((event, emit){
      emit(state.copyWith(topAttractions: event.topAttractions));
    });

    on<AttractionListEvents>((event, emit){
      emit(state.copyWith(attractionsList: event.attractionsList));
    });
  }

}