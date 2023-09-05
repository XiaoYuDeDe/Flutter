import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/common/widgets/toast.dart';

import '../../../common/widgets/common_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Password reset link sent! Check your email"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch(e){
      toastInfo(msg: e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Forgot Password"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Enter your email to receive the password reset link.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.barLineColor.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.barLineColor.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Enter your email address",
                fillColor: AppColors.barLineColor.withOpacity(0.5),
                filled: true,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            width: 320.w, //
            height: 40.h, //
            child: MaterialButton(
              onPressed: passwordReset,
              color: AppColors.btnColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.btnTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
