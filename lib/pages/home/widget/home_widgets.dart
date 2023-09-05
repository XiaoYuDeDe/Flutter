import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/pages/home/bloc/home_blocs.dart';
import 'package:travelguide/pages/home/bloc/home_events.dart';
import 'package:travelguide/pages/home/bloc/home_states.dart';

import '../../../common/themes/colors.dart';
import '../../attractions/attractions.dart';

Widget homeTitle(String text, {Color textColor = AppColors.appBarColor, int top=20, int fontSize = 18}){
  return Container(
    margin: EdgeInsets.only(top: top.h),
    child: Text(
      text,
      style: TextStyle(
          color: textColor,
          fontSize: fontSize.sp,
          fontWeight: FontWeight.bold
      ),
    ),
  );
}

Widget slideViewWidget(BuildContext context, HomeStates state) {
  return Column(
    children: [
      Container(
        width: 350.w,
        margin: EdgeInsets.only(top: 15.h),
        child: Row(
          children: [
            textWidget("Top 3 Popular Places", color: AppColors.pageTitleColor, fontSize: 20),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.h),
        width: 350.w,
        height: 160.h,
        child: PageView(
          onPageChanged: (value) {
            context.read<HomeBlocs>().add(HomeDotEvents(value));
          },
          children: state.topAttractions.map((attraction) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AttractionsDetail(attraction: attraction),
                  ),
                );
              },
              child: sliderContainer(imageUrl: attraction.imageUrl),
            );
          }).toList(),
        ),
      ),
      DotsIndicator(
        dotsCount: 3,
        position: state.index,
        decorator: DotsDecorator(
          color: AppColors.dotColor,
          activeColor: AppColors.btnColor,
          size: const Size.square(8.0),
          activeSize: const Size(15.0, 8.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    ],
  );
}

Widget sliderContainer({required String imageUrl}){
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.h)),
        image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(imageUrl),
        )
    ),
  );
}

Widget textWidget(String text,
    {
      Color color=AppColors.bgColor,
      int fontSize=16,
      FontWeight fontWeight=FontWeight.bold
    }){
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize.sp
    ),
  );
}

Widget buttonWidget(String btnText, HomeStates state, {Function()? onPressed}) {
  final isSelected = state.btnSelectedName == btnText;

  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.pageTitleColor : AppColors.bgColor,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: isSelected ? AppColors.pageTitleColor : AppColors.bgColor,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      child: textWidget(
        btnText,
        color: isSelected ? AppColors.bgColor : AppColors.dotColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

Widget attractionGrid(){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.w),
      color: Colors.grey[100],
    ),
    child: Column(
      children: [
        Container(
          height: 110.h,//image height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.w),
              topRight: Radius.circular(15.w),
            ),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/welcome1.jpg"),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w), // 添加左侧间距
                    child: Text(
                      "Big Title",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.iconColor),
                      Text(
                        "4.5",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/icons/location.png",
                    width: 20.w,
                    height: 20.h,
                    color: AppColors.iconColor,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Small Title",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
