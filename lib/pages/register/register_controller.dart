import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/common/widgets/toast.dart';
import 'package:travelguide/pages/register/bloc/register_blocs.dart';

class RegisterController{
  final BuildContext context;
  const RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    final state = context.read<RegisterBlocs>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String confirmPassword = state.confirmPassword;
    if(userName.isEmpty){
      toastInfo(msg: "User name can not be empty");
      return;
    }
    if(email.isEmpty){
      toastInfo(msg: "Email can not be empty");
      return;
    }
    if(password.isEmpty){
      toastInfo(msg: "Password can not be empty");
      return;
    }
    if(confirmPassword.isEmpty){
      toastInfo(msg: "Confirm password can not be empty");
      return;
    }
    try{
      final credntial = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if(credntial.user!=null){
        await credntial.user?.sendEmailVerification();
        await credntial.user?.updateDisplayName(userName);
        toastInfo(msg: "An email has been sent your registered email.");
        Navigator.of(context).pop();//go to previous page.
      }
    }on FirebaseAuthException catch(e){
      if(e.code == "weak-password"){
        toastInfo(msg: "The password provided is weak.");
      }else if(e.code == "email-already-in-use"){
        toastInfo(msg: "The email is already in use.");
      }else if(e.code == "invalid-email"){
        toastInfo(msg: "The email is invalid.");
      }
    }

  }
}