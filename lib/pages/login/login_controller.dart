import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelguide/common/values/constant.dart';
import 'package:travelguide/common/widgets/toast.dart';
import '../../common/global/global.dart';
import 'bloc/login_blocs.dart';

class LoginController {
  final BuildContext context;

  const LoginController({required this.context});

  Future<void> handleLogin(String type) async {
    try{
      if(type=="email"){//login with email
        final state = context.read<LoginBlocs>().state;
        String emailAddress = state.email;
        String password = state.password;
        if(emailAddress.isEmpty){
          toastInfo(msg: "Please enter your email address.");
          return;
        }
        if(password.isEmpty){
          toastInfo(msg: "Please enter your password.");
          return;
        }
        try{
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: emailAddress, password: password);
          if(credential.user==null){
            toastInfo(msg: "Account doesn't exist.");
            return;
          }
          if(!credential.user!.emailVerified){
            toastInfo(msg: "You need to verify email account.");
            return;
          }

          var user = credential.user;
          if(user!=null){//Verify Success from Firebase
            // Generate a token based on the user's UID
            String userToken = generateUserToken(user.uid);
            // Store the generated token in the storage service
            Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, userToken);
            //set user profile
            final userInfo = {
              "userId":user.uid,
              "email": emailAddress,
              "username": user.displayName,
              "loginType" : "email"
            };
            Global.storageService.setUserInfo(userInfo);
            Navigator.of(context).pushNamedAndRemoveUntil("/navigation", (route) => false);
          }else{
            //we have error getting user from Firebase
            toastInfo(msg: "Currently you are not a user of this app.");
            return;
          }
        }
        on FirebaseAuthException catch(e){
          if(e.code == "user-not-found"){
            toastInfo(msg: "The user of this email address does not exist.");
          }else if(e.code == "wrong-password"){
            toastInfo(msg: "Your password is incorrect.");
          }else if(e.code == "invalid-email"){
            toastInfo(msg: "Your email address format is wrong.");
          }
        }
      }else if(type=="google"){
        try {
          UserCredential userCredential = await signInWithGoogle();

          if (userCredential.user != null) {
            // Successfully signed in with Google
            var user = userCredential.user;
            // Generate a token based on the user's UID
            String userToken = generateUserToken(user!.uid);
            // Store the generated token in the storage service
            Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, userToken);
            //set user profile
            final userInfo = {
              "userId":user.uid,
              "email": user.email,
              "username": user.displayName,
              "loginType": "google"
            };
            Global.storageService.setUserInfo(userInfo);
            Navigator.of(context).pushNamedAndRemoveUntil("/navigation", (route) => false);
          } else {
            // Handle the case where signInWithGoogle didn't return a user
            toastInfo(msg: "Google sign-in failed.");
          }
        } catch (e) {
          // Handle any other errors that might occur
          toastInfo(msg: "An error occurred: $e");
        }
      }
    }catch(e){
      toastInfo(msg: "An error occurred: $e");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }on FirebaseAuthException catch(e){
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'User not found.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password. Please try again.';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'Network request failed. Please check your internet connection.';
      }
      toastInfo(msg: e.message ?? 'An error occurred.');
      return Future.error(errorMessage);
    }
  }

  // Generate a random key
  String generateRandomKey() {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  // Generate a user-specific token
  String generateUserToken(String uid) {
    String secretKey = generateRandomKey();
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String token = uid + timestamp + secretKey;

    var bytes = utf8.encode(token);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }
}
