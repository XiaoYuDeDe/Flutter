import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/register/bloc/register_events.dart';
import 'package:travelguide/pages/register/bloc/register_states.dart';

class RegisterBlocs extends Bloc<RegisterEvent, RegisterStates>{
  RegisterBlocs():super(const RegisterStates()){
    on<UserNameEvent>(userNameEvent);
    on<EmailEvent>(emailEvent);
    on<PasswordEvent>(passwordEvent);
    on<ConfirmPasswordEvent>(confirmPasswordEvent);
  }

  void userNameEvent(UserNameEvent event, Emitter<RegisterStates> emit){
    emit(state.copyWith(userName: event.userName));
  }

  void emailEvent(EmailEvent event, Emitter<RegisterStates> emit){
    emit(state.copyWith(email: event.email));
  }

  void passwordEvent(PasswordEvent event, Emitter<RegisterStates> emit){
    emit(state.copyWith(password: event.password));
  }

  void confirmPasswordEvent(ConfirmPasswordEvent event, Emitter<RegisterStates> emit){
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }
}