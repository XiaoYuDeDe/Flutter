import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterEvent{
  const RegisterEvent();
}

class UserNameEvent extends RegisterEvent{
  //event get triggered pass data
  final String userName;
  const UserNameEvent(this.userName);
}

class EmailEvent extends RegisterEvent{
  //event get triggered pass data
  final String email;
  const EmailEvent(this.email);
}

class PasswordEvent extends RegisterEvent{
  //event get triggered pass data
  final String password;
  const PasswordEvent(this.password);
}

class ConfirmPasswordEvent extends RegisterEvent{
  //event get triggered pass data
  final String confirmPassword;
  const ConfirmPasswordEvent(this.confirmPassword);
}