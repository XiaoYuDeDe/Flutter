import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/profile/settings/bloc/settings_event.dart';
import 'package:travelguide/pages/profile/settings/bloc/settings_states.dart';

class SettingsBlocs extends Bloc<SettingsEvents, SettingsStates>{
  SettingsBlocs():super(const SettingsStates()){
    on<TriggerSettings>(triggerSettings);
  }
}

triggerSettings(event, emit){
  emit(SettingsStates());
}
