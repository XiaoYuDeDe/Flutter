import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/common/widgets/toast.dart';

import '../forgotpassword/forgot_password.dart';
import '../login_controller.dart';

Widget forgotPasswordWidget(BuildContext context){
  return Container(
    margin:  EdgeInsets.only(right: 25.w),
    height: 20.h,
    child: GestureDetector(
      onTap: (){

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ForgotPassword();
              }));
            },
            child: Text(
              "Forgot password?",
              style: TextStyle(
                  color: AppColors.linkColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal
              ),
            )
          )
        ],
      ),
    ),
  );
}

Widget loginButtonWidget(void Function()? function){
  return GestureDetector(
    onTap: function,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(left: 25.w, right: 25.w, top:20.h),
      decoration: BoxDecoration(
        color: AppColors.btnColor,
        borderRadius: BorderRadius.circular(15.w),
        border: Border.all(
          color: Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0,1),
            color: Colors.grey.withOpacity(0.1)
          )
        ]
      ),
      child: Center(
        child: Text(
          "Log in",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.btnTextColor,
          ),
        ),
      ),
    ),
  );
}

Widget signUpButtonWidget(void Function()? function){
  return GestureDetector(
    onTap: function,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
      decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(
            color: AppColors.barLineColor,
          ),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0,1),
                color: Colors.grey.withOpacity(0.1)
            )
          ]
      ),
      child: Center(
        child: Text(
          "Sign up",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.contentTitleColor,
          ),
        ),
      ),
    ),
  );
}

Widget thirdPartyLoginWidget(BuildContext context){//context for access bloc
  return Container(
    margin: EdgeInsets.only(top: 10.h),
    padding: EdgeInsets.only(left: 25.w,right: 25.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () async {
            await LoginController(context: context).handleLogin("google");
          },
          child: SizedBox(
            width: 50.w,
            height: 50.w,
            child: Image.asset("assets/icons/google.png"),
          ),
        ),
        GestureDetector(
          onTap: () async {
            // Call Apple sign-in method
            toastInfo(msg: "apple");
          },
          child: SizedBox(
            width: 50.w,
            height: 50.w,
            child: Image.asset("assets/icons/apple.png"),
          ),
        ),
      ],
    ),
  );
}
