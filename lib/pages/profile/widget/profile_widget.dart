import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/routes/routes.dart';
import 'package:travelguide/common/themes/colors.dart';

Widget profilePhotoWidget(){
  return Container(
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.only(right: 5.w),
    width: 120.w,
    height: 120.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.w),
        image: const DecorationImage(
            image: AssetImage(
                "assets/icons/avatar.png"
            )
        )
    ),
    child: Image(
      width: 20.w,
      height: 20.h,
      image: const AssetImage("assets/icons/photo.png"),
    ),
  );
}

Widget userInfoRowWidget(String iconPath, String label, String value){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Image.asset(iconPath, width: 25, height: 25, color: AppColors.contentTitleColor),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 25),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget settingWidget(BuildContext context){
   return Column(
    children: [
      GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(AppRoutes.SETTINGS);
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.barLineColor,
                width: 1.0,
              ),
              bottom: BorderSide(
                color:AppColors.barLineColor,
                width: 1.0,
              ),
            ),
            color: AppColors.bgColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Container(
                  width: 35.w,
                  height: 35.h,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: AppColors.bgColor,
                  ),
                  child: Image.asset(
                    "assets/icons/settings.png",
                    color: AppColors.iconColor,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: AppColors.contentTitleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.contentTitleColor,
              ),
            ],
          ),
        ),
      )
    ],
  );
}

Widget addProfileBarWidget(BuildContext context,
    String widgetName,
    String navigationPath,
    String iconPath,
    String userId){
  if (widgetName == "Settings") {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(navigationPath);
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.barLineColor,
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color:AppColors.barLineColor,
                  width: 1.0,
                ),
              ),
              color: AppColors.bgColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Container(
                    width: 35.w,
                    height: 35.h,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: AppColors.bgColor,
                    ),
                    child: Image.asset(
                      iconPath,
                      color: AppColors.iconColor,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    widgetName,
                    style: TextStyle(
                      color: AppColors.contentTitleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.contentTitleColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  } else if(userId == "HXIPw6e7ZUftqKlvDCqL9vvOQsq1" &&
      (widgetName == "Category Management" || widgetName == "Attraction Management")){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(navigationPath);
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.barLineColor,
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color:AppColors.barLineColor,
                  width: 1.0,
                ),
              ),
              color: AppColors.bgColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Container(
                    width: 35.w,
                    height: 35.h,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: AppColors.bgColor,
                    ),
                    child: Image.asset(
                      iconPath,
                      color: AppColors.iconColor,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    widgetName,
                    style: TextStyle(
                      color: AppColors.contentTitleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.contentTitleColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }else{
    return Container();
  }
}