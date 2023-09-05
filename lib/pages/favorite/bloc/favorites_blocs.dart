import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_events.dart';
import 'favorites_states.dart';

class FavoritesBlocs extends Bloc<FavoritesEvents, FavoritesStates>{

  FavoritesBlocs():super(const FavoritesStates()){

    on<FavoritesResultEvent>((event, emit){
      emit(state.copyWith(favoritesResult: event.favoritesResult));
    });

  }

}