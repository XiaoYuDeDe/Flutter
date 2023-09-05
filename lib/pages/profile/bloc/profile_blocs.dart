import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/profile/bloc/profile_events.dart';
import 'package:travelguide/pages/profile/bloc/profile_states.dart';

class ProfileBlocs extends Bloc<ProfileEvents, ProfileStates>{

  ProfileBlocs():super(const ProfileStates()){

    on<ImageUrlEvent>((event, emit){
      emit(state.copyWith(imageUrl: event.imageUrl));
    });

  }

}