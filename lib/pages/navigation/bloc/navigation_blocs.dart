import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/navigation/bloc/navigation_events.dart';
import 'package:travelguide/pages/navigation/bloc/navigation_states.dart';

class NavigationBlocs extends Bloc<NavigationEvents, NavigationStates>{
  NavigationBlocs():super(const NavigationStates()){
    on<TriggerNavigationEvents>((event, emit){
      emit(NavigationStates(index:event.index));
    });
  }
}