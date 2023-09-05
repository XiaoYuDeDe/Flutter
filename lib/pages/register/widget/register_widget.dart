import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';

Widget signUpButtonWidget(void Function()? function){
  return GestureDetector(
    onTap: function,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
      decoration: BoxDecoration(
          color: AppColors.btnColor,
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(
            color: Color.fromARGB(255, 204, 204, 204),
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
            color: AppColors.bgColor,
          ),
        ),
      ),
    ),
  );
}