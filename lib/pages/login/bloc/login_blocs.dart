import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/login/bloc/login_events.dart';
import 'package:travelguide/pages/login/bloc/login_states.dart';

class LoginBlocs extends Bloc<LoginEvents, LoginStates>{
  LoginBlocs():super(const LoginStates()){
    on<EmailEvent>((event, emit){
      emit(state.copyWith(email: event.email));
    });
    on<PasswordEvent>((event, emit){
      emit(state.copyWith(password: event.password));
    });
  }
}