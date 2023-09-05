import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';

AppBar buildAppBar(String barText){
  return AppBar(
    centerTitle: true,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),//line propriety
      child: Container(
        color: AppColors.barLineColor,
        height: 1.0,//height defines the thickness of the line
      ),
    ),
    title: Text(
      barText,
      style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal
      ),
    ),
  );
}

AppBar commonAppBarWidget(String text, {Color titleColor = AppColors.contentTitleColor, bool showBackButton = true}) {
  return AppBar(
    automaticallyImplyLeading: showBackButton,
    centerTitle: true,
    bottom: PreferredSize(
      //line propriety
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: AppColors.barLineColor,
        height: 1.0, //height defines the thickness of the line
      ),
    ),
    title: Text(
      text,
      style: TextStyle(
          color: titleColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget commonLabelWidget(String text, {bool isBold = true}){
  return Container(
    margin: EdgeInsets.only(
        top: 10.h,
        bottom: 5.h
    ),
    child: Text(
      text,
      style: TextStyle(
          color: AppColors.contentTitleColor,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: 16.sp
      ),
    ),
  );
}

Widget commonTextFieldWidget(String hintText, String textType, String iconName,
    void Function(String value)? function){
  return Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          border: Border.all(color: AppColors.contentTitleColor)
      ),
      child: Row(
        children: [
          Container(
            width: 18.w,
            height: 18.w,
            margin: EdgeInsets.only(left: 15.w),
            child: Image.asset("assets/icons/$iconName.png"),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.h),
            width: 270.w,
            height: 50.h,
            child: TextField(
              onChanged: (value)=>function!(value),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent
                    )
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent
                    )
                ),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent
                    )
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent
                    )
                ),
                hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.5)
                ),

              ),
              style: TextStyle(
                  color: AppColors.contentTitleColor,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.normal,
                  fontSize: 16.sp
              ),
              autocorrect: false,
              obscureText: textType=="password"?true:false,//password input

            ),
          )
        ],
      )
  );
}
