import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/welcome/bloc/welcome_events.dart';
import 'package:travelguide/pages/welcome/bloc/welcome_states.dart';

class WelcomeBlocs extends Bloc<WelcomeEvents, WelcomeStates>{
  WelcomeBlocs():super(WelcomeStates()){
    on<WelcomeEvents>((event,emit){
      //switch from 0 to 1 would be reflected state.page value and assign to page variable.
      emit(WelcomeStates(page:state.page));
    });
  }
}